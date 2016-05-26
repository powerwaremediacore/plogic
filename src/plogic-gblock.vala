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

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = true;
    if (!enable) { _evaluated = false; return; }
    if (get_parent () != null) {
      foreach (Input input in get_inputs ().values) {
        if (!input.enable) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
    }
    foreach (Operator op in get_operators ().values) {
      op.evaluate (null);
    }
  }
}
