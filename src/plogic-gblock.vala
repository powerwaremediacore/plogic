/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public class Plg.GBlock : GBaseOperator, Plg.Block {
  public Output.Map outputs { get; set; default = new Output.Map (); }
  public Plg.Operator.Map operators { get; set; default = new Operator.Map (); }
  public Plg.Variable.Map variables { get; set; default = new Plg.Variable.Map (); }

  construct {
      name = "Block1";
  }


  public override void reset () {
    GLib.message ("Reseting Block: "+name);
    _evaluated = false;
    foreach (Operator op in operators.values) {
      GLib.message ("Reseting inner Block: "+op.name);
      if (op is Block)
        (op as Block).reset ();
      else
        op.reset ();
    }
  }
  public void add_operator (Plg.Operator op) {
      _operators.set (op.name, op);
      op.set_parent (this);
  }

  public void add_variable (Plg.Variable v) {
      _variables.set (v.name, v);
  }
  public bool connect_input_internal (string input, string operator, string value) {
    var i = inputs.get (input);
    if (i == null) return false;
    var op = operators.get (operator);
    if (op == null) return false;
    var opi = op.inputs.get (value);
    if (opi == null) return false;
    var c = new GConnection ();
    c.value = input;
    opi.connection = c;
    return true;
  }
  /**
   * Connects block's output to internal operator's output.
   */
  public bool connect_output_internal (string output, string operator, string oper_output) {
      var o = outputs.get (output);
      if (o == null) return false;
      var bop = operators.get (operator);
      if (bop == null) return false;
      Plg.Output obop = null;
      if (bop is Block)
        obop = (bop as Block).outputs.get (oper_output);
      if (bop is OperatorGate) {
        if ((bop as OperatorGate).output.name != oper_output) return false;
        obop = (bop as OperatorGate).output;
      }
      if (obop == null) return false;
      var c = new GInternalConnection ();
      c.operator = operator;
      c.value = oper_output;
      o.internal_connection = c;
      o.enable = true;
      var cp = new GConnection ();
      cp.value = output;
      obop.connections.add (cp);
      return true;
  }

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = false;
    if (!enable) { _evaluated = false; return; }
    foreach (Output output in outputs.values) {
        GLib.message ("Block:"+name+" Evaluating output: "+output.name);
        if (output.internal_connection == null) continue;
        if (output.internal_connection.operator == null) continue;
        if (output.internal_connection.value == null) continue;
        var bop = operators.get (output.internal_connection.operator);
        if (bop == null) continue;
        Plg.Value bopo = null;
        if (bop is Block)
          bopo = (bop as Block).outputs.get (output.internal_connection.value);
        if (bop is OperatorGate)
          bopo = (bop as OperatorGate).output;
        if (bopo == null) continue;
        GLib.message ("Block: "+name+" Evaluating Oper: "+bop.name);
        bop.evaluate (cancellable);
        _evaluated = bop.get_evaluated ();
    }
    if (get_parent () != null) {
      foreach (Input input in inputs.values) {
        if (!input.enable) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
    }
    foreach (Output output in outputs.values) {
        evaluate_output (output, cancellable);
    }
  }
}
