/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public class Plg.GBlock : BaseOperator, Plg.Block {
  protected Output.Map _outputs = new Output.Map ();
  protected Plg.Variables.Map _variables = new Plg.Variables.Map ();
  protected Operator.Map _operators = new Operator.Map ();
  protected Plg.Block _parent;

  public Output.Map get_outputs () { return _outputs; }
  public Plg.Operator.Map get_operators () { return _operators; }
  public Plg.Value.Map get_variables () { return _variables; }

  public void set_parent (Plg.Block parent) {
    _parent = parent;
  }
  public Plg.Block? get_parent () {
    return _parent;
  }

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = true;
    if (parent != null) {
      foreach (Input input in get_inputs ().values) {
        var c = input.get_connection ();
        if (c == null) continue;
        if (c.operator == null) {
          var pin = parent.get_inputs ().get (c.value);
          if (pin != null) input.state == pin.state;
        } else {
          var pop = parent.get_operators ().get (c.operator);
          if (pop == null) continue;
          if (!pop.get_evaluated ()) pop.evaluate ();
          var popi = pop.get_outputs ().get (c.value);
          if (popi == null) continue;
          input.state = popi.state;
        }
      }
    }
    foreach (Operator op in get_operators ().values) {
      op.evaluate (null);
    }
  }
}
