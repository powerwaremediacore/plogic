/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public class Plg.And : Plg.BaseOperatorGate {
  public override void evaluate (GLib.Cancellable? cancellable) {
    _evaluated = false;
    if (!enable) return;
    bool s = true;
    foreach (Input input in get_inputs ().values) {
      if (!input.enable) continue;
      s = s && input.state;
      if (!s) break;
    }
    _output.state = s;
    if (!hold)
      _evaluated = true;
  }
}
