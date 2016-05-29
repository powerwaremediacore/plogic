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
   * Change input state based on its connection.
   *
   * Rerturns: TRUE if its value was updated.
   */
  public virtual bool evaluate_input (Input input, GLib.Cancellable? cancellable = null) {
    var parent = get_parent ();
    if (parent == null) return true; // Keeps actual intput's state
    var c = input.connection;
    if (c == null) return false;
    if (c.operator == null) {
      var pin = parent.inputs.get (c.value);
      if (pin != null) input.state = pin.state;
    } else {
      var pop = parent.get_operators ().get (c.operator);
      if (pop == null) return false;
      if (!pop.get_evaluated ()) pop.evaluate (cancellable);
      Output popi = null;
      if (pop is Block)
        popi = (pop as Block).outputs.get (c.value);
      if (pop is OperatorGate)
        popi = (pop as OperatorGate).get_output ();
      if (popi == null) return false;
      input.state = popi.state;
    }
    return true;
  }
  /**
   * Change block's outputs state based on its connection.
   *
   * Rerturns: TRUE if its value was updated.
   */
  public virtual bool evaluate_output (Output output, GLib.Cancellable? cancellable = null) {
    var parent = get_parent ();
    if (parent == null) return true; // No output values updated
    foreach (Connection cnn in output.connections) {
      if (cnn.operator == null) {
        if (get_parent () == null) continue;
        var o = get_parent ().outputs.get (cnn.value);
        if (o == null) continue;
        o.state = output.state;
      }
    }
    return true;
  }
  public class Map : Gee.HashMap<string,Operator> {
    public new Operator get (string name) { return base.get (name); }
    public new void set (string name, Operator op) { base.set (name, op); }
  }
}
