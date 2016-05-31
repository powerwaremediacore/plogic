/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Operator : Object, Plg.LogicObject {
  public abstract Input.Map inputs { get; set; }
  public abstract bool get_evaluated ();
  public abstract void reset ();
  public abstract void evaluate (GLib.Cancellable? cancellable = null);
  public abstract void set_parent (Plg.Block parent);
  public abstract Plg.Block? get_parent ();

  /**
   * Connects a parent's {@link Operator} output to this operator's input or
   * operator's input to parent's input.
   *
   * If @operator is null, then @value should be a parent's input name. If not,
   * then @value should be an parent's operator's output's name.
   */
  public virtual bool connect_input (string input, string? operator, string value) {
    var i = inputs.get (input);
    if (i == null) return false;
    if (operator == null) {
      if (get_parent () == null) return false;
      if (!(get_parent () is Block)) return false;
      var pi = get_parent ().inputs.get (value);
      if (pi == null) return false;
      var pc = new GConnection ();
      pc.value = value;
      i.connection = pc;
      return true;
    }
    if (get_parent () == null) return false;
    var op = get_parent ().operators.get (operator);
    if (op == null) return false;
    Plg.Output opv = null;
    if (op is Block)
      opv = (op as Block).outputs.get (value);
    if (op is OperatorGate) {
      if ((op as OperatorGate).output.name != value) return false;
      opv = (op as OperatorGate).output;
    }
    if (opv == null) return false;
    var opvc = new GConnection ();
    opvc.operator = this.name;
    opvc.value = input;
    opv.connections.add (opvc);
    var iopc = new GConnection ();
    iopc.operator = operator;
    iopc.value = value;
    i.connection = iopc;
    return true;
  }
  /**
   * Change input state based on its connection. If no connection, state is not
   * updated and no furder evaluation is made.
   *
   * Rerturns: TRUE if its value was updated.
   */
  public virtual bool evaluate_input (Input input, GLib.Cancellable? cancellable = null) {
    GLib.message ("Oper:"+this.name+" Evaluating input: "+input.name);
    var parent = get_parent ();
    if (parent == null) return true; // Keeps actual intput's state
    var c = input.connection;
    if (c == null) return true; // No connection but still valid, keeps input's state
    if (c.operator == null) {
      var pin = parent.inputs.get (c.value);
      if (pin == null) return false;
      if (pin.connection != null) {
        string cs = "";
        if (pin.connection.operator != null) cs += pin.connection.operator;
        if (pin.connection.value != null) cs += ":"+pin.connection.value;
        GLib.message ("Parent: "+parent.name+" input:"+pin.name+" connnected: "+cs);
        parent.evaluate_input (pin, cancellable);
        //assert_not_reached ();
      }
      input.state = pin.state;
      GLib.message ("Oper:"+this.name+" Evaluated input:"+input.name+" to: "+pin.state.to_string ());
    } else {
      var pop = parent.operators.get (c.operator);
      if (pop == null) return false;
      Output popi = null;
      if (pop is Block)
        popi = (pop as Block).outputs.get (c.value);
      if (pop is OperatorGate)
        popi = (pop as OperatorGate).output;
      if (popi == null) return false;
      pop.evaluate (cancellable);
    }
    return true;
  }
  /**
   * Change operator's outputs state based on its connection.
   *
   * Rerturns: TRUE if its value was updated.
   */
  public virtual bool evaluate_output (Output output, GLib.Cancellable? cancellable = null) {
    var parent = get_parent ();
    if (parent == null) return true; // No output values updated
    foreach (Connection cnn in output.connections) {
      if (cnn.operator == null) {
        if (get_parent () == null) continue;
        GLib.message ("Oper: "+name+" Searching Output: "+cnn.value+" on Parent: "+get_parent ().name);
        var o = parent.outputs.get (cnn.value);
        if (o != null) {
          o.state = output.state;
          GLib.message ("Oper: "+name+" Updated Output: "+o.name+" on Parent: "+get_parent ().name+" to: "+o.state.to_string ());
          parent.evaluate_output (o, cancellable);
          continue;
        }
        GLib.message ("Oper: "+name+" Searching Variable: "+cnn.value+" on Parent: "+get_parent ().name);
        var v = get_parent ().variables.get (cnn.value);
        if (v == null) continue;
        v.state = output.state;
        GLib.message ("Oper: "+name+" Updated Variable: "+v.name+" on Parent: "+get_parent ().name+" to"+v.state.to_string ());
      }
      if (cnn.operator != null) {
        GLib.message ("Oper: "+name+" Searching Input: "+cnn.value+" on Parent: "+get_parent ().name+" Oper:"+cnn.operator);
        var op = parent.operators.get (cnn.operator);
        if (op == null) continue;
        if (cnn.value == null) continue;
        var opi = op.inputs.get (cnn.value);
        if (opi == null) continue;
        opi.state = output.state;
        GLib.message ("Oper: "+name+" Updated input: "+opi.name+" on Parent: "+get_parent ().name+" Oper:"+cnn.operator+" to: "+opi.state.to_string ());
      }
    }
    return true;
  }
  public class Map : Gee.HashMap<string,Operator> {
    public new Operator get (string name) { return base.get (name); }
    public new void set (string name, Operator op) { base.set (name, op); }
  }
}
