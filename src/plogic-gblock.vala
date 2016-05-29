/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public class Plg.GBlock : GBaseOperator, Plg.Block {
  protected Output.Map _outputs = new Output.Map ();
  protected Plg.Variable.Map _variables = new Plg.Variable.Map ();
  protected Operator.Map _operators = new Operator.Map ();

  public Output.Map get_outputs () { return _outputs; }
  public Plg.Operator.Map get_operators () { return _operators; }
  public Plg.Variable.Map get_variables () { return _variables; }

  construct {
      name = "Block1";
  }

  public void add_operator (Plg.Operator op) {
      _operators.set (op.name, op);
      op.set_parent (this);
  }

  public void add_variable (Plg.Variable v) {
      _variables.set (v.name, v);
  }

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = true;
    if (!enable) { _evaluated = false; return; }
    if (get_parent () != null) {
      foreach (Input input in inputs.values) {
        if (!input.enable) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
    }
    foreach (Operator op in get_operators ().values) {
      op.evaluate ();
      if (!op.get_evaluated ()) _evaluated = false;
    }
  }
}
