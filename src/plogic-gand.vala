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
    foreach (Input input in inputs.values) {
      if (!input.enable) continue;
      GLib.message ("Oper: "+name+" Evaluating input: "+input.name);
      var parent = get_parent ();
      if (parent != null) {
        var c = input.connection;
        if (c == null) continue;
        if (!evaluate_input (input, cancellable)) continue;
        GLib.message ("Oper: "+name+" Evaluated input:"+input.name+" as "+input.state.to_string ());
      }
      _evaluated = true;
      s = s && input.state;
      if (!s) break;
    }
    if (_evaluated) {
      _output.state = s;
      GLib.message ("Oper: "+name+" Evaluated to: "+_output.state.to_string ());
      evaluate_output (_output);
    }
  }
}
