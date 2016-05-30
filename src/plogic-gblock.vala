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

  public bool connect_output (string name, string operator, string value) {
      var o = outputs.get (name);
      if (o == null) return false;
      var bop = operators.get (operator);
      if (bop == null) return false;
      Plg.Output obop = null;
      if (bop is Block)
        obop = (bop as Block).outputs.get (value);
      if (bop is OperatorGate)
        obop = (bop as OperatorGate).output;
      if (obop == null) return false;
      var c = new GInternalConnection ();
      c.operator = operator;
      c.value = value;
      o.internal_connection = c;
      o.enable = true;
      var cp = new GConnection ();
      cp.value = name;
      obop.connections.add (cp);
      return true;
  }

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = false;
    if (!enable) { _evaluated = false; return; }
    foreach (Output output in outputs.values) {
        if (output.internal_connection == null) continue;
        if (output.internal_connection.operator == null) continue;
        if (output.internal_connection.value == null) continue;
        var bop = operators.get (output.internal_connection.operator);
        if (bop == null) continue;
        Plg.Value bopo = null;
        if (bop is Block)
          bopo = (bop as Block).outputs.get (output.internal_connection.value);
        if (bop is OperatorGate)
          bopo = (bop as OperatorGate).output;
        if (bopo == null) continue;
        GLib.message ("Block: "+name+" Evaluating Oper: "+bop.name);
        bop.evaluate (cancellable);
        _evaluated = bop.get_evaluated ();
    }
    if (get_parent () != null) {
      foreach (Input input in inputs.values) {
        if (!input.enable) continue;
        if (!evaluate_input (input, cancellable)) continue;
      }
    }
    foreach (Output output in outputs.values) {
        evaluate_output (output, cancellable);
    }
  }
}
