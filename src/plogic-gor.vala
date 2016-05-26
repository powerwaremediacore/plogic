/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public class Plg.GOr : Plg.GBaseOperatorGate {
  public override void evaluate (GLib.Cancellable? cancellable) {
    _evaluated = false;
    if (!enable) return;
    _output.state = false;
    foreach (Input input in get_inputs ().values) {
      if (!input.enable) continue;
      var parent = get_parent ();
      if (parent != null) {
        var c = input.connection;
        if (c == null) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
      _output.state = _output.state || input.state;
    }
    _evaluated = true;
  }
}
