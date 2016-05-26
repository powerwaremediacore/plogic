/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Operator : Object, Plg.LogicObject {
  public abstract Input.Map get_inputs ();
  public abstract bool get_evaluated ();
  public abstract void reset ();
  public abstract void evaluate (GLib.Cancellable? cancellable);
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
      var pin = parent.get_inputs ().get (c.value);
      if (pin != null) input.state = pin.state;
    } else {
      var pop = parent.get_operators ().get (c.operator);
      if (pop == null) return false;
      if (!pop.get_evaluated ()) pop.evaluate (cancellable);
      Output popi = null;
      if (pop is Block)
        popi = (pop as Block).get_outputs ().get (c.value);
      if (pop is OperatorGate)
        popi = (pop as OperatorGate).get_output ();
      if (popi == null) return false;
      input.state = popi.state;
    }
    return true;
  }
  public class Map : Gee.HashMap<string,Operator> {
    public new Operator get (string name) { return base.get (name); }
  }
}
