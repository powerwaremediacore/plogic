/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public class Plg.GValue : Plg.GObject, Plg.LogicObject, Plg.Value {
  protected Plg.Operator _operator = null;

  public string name { get; set; default = "Value1"; }
  public bool state { get; set; default = true; }
  public bool enable { get; set; default = true; }

  public GValue.with_operator (Plg.Operator op) { _operator = op; }
  public void set_operator (Plg.Operator op) { _operator = op; }
  public Plg.Operator get_operator () { return _operator; }
  public void reset () {
    state = true;
  }
}

public class Plg.GInput : Plg.GValue, Input {
  public Plg.Connection? connection { get; set; }
  construct {
    name = "Input1";
  }
  public GInput.with_operator (Plg.Operator op) { _operator = op; }
}

public class Plg.GOutput : Plg.GValue, Output {
  public Plg.Connection.Set connections { get; set; default = new Plg.Connection.Set (); }
  [Description (nick="InternalConnection")]
  public Plg.InternalConnection internal_connection { get; set; }
  construct {
    name = "Output1";
  }
  public GOutput.with_operator (Plg.Operator op) { _operator = op; }
}

public class Plg.GVariable : Plg.GValue, Variable {
  public Plg.Connection connection { get; set; }
  construct {
    name = "Variable1";
  }
  public GVariable.with_operator (Plg.Operator op) { _operator = op; }
}
