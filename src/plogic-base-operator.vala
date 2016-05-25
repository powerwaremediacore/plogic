/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.BaseOperator : Object, LogicObject, Operator {
  protected Operator.Map _inputs = new Operator.Map ();
  protected bool _evaluated = false;
  protected Plog.Value _output = new Plog.Value ();

  public string name { get; set; default = "or";  }
  public bool enable { get; set; }
  public bool hold { get; set; }
  public Operator.Map inputs { get { return _inputs; } }
  public bool evaluated { get { return _evaluated; } }
  public void reset () { _valuated = false; }
  public abstract void evaluate ();
}
