/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public class Plg.Or : Plg.BaseOperatorGate {
  public override void evaluate (GLib.Cancellable? cancellable) {
    _evaluated = false;
    if (!enable) return;
    _output.state = false;
    foreach (Value input in get_inputs ().values) {
      if (!input.enable) continue;
      _output.state = _output.state || input.state;
    }
    _evaluated = true;
  }
}
