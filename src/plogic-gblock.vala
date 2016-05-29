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
    foreach (Operator op in operators.values) {
      op.evaluate ();
      if (!op.get_evaluated ()) _evaluated = false;
    }
  }
}
