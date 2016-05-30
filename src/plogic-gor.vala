/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public class Plg.GOr : Plg.GBaseOperatorGate {
  construct {
      name = "OR1";
  }
  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = false;
    if (!enable) return;
    _output.state = false;
    bool res = false;
    foreach (Input input in inputs.values) {
      if (!input.enable) continue;
      var parent = get_parent ();
      if (parent != null) {
        var c = input.connection;
        if (c == null) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
      _evaluated = true;
      res = res || input.state;
    }
    if (_evaluated == true) {
      _output.state = res;
      GLib.message ("Oper: "+name+" Evaluated to: "+_output.state.to_string ());
      // If in block update output connections
      evaluate_output (_output);
      return;
    }
  }
}
