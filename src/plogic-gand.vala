/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public class Plg.GAnd : Plg.GBaseOperatorGate {
  construct {
      name = "AND1";
  }
  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = false;
    if (!enable) return;
    bool s = true;
    foreach (Input input in get_inputs ().values) {
      if (!input.enable) continue;
      var parent = get_parent ();
      if (parent != null) {
        var c = input.connection;
        if (c == null) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
      _evaluated = true;
      s = s && input.state;
      if (!s) break;
    }
    if (_evaluated) {
      _output.state = s;
      evaluate_output (_output);
    }
  }
}
