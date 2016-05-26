/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.GBaseOperator : Object, LogicObject, Operator {
  protected Input.Map _inputs = new Input.Map ();
  protected bool _evaluated = false;

  public string name { get; set; default = "or";  }
  public bool enable { get; set; }
  public Input.Map get_inputs () { return _inputs; }
  public bool get_evaluated () { return _evaluated; }
  public void reset () { _evaluated = false; }
  public abstract void evaluate (GLib.Cancellable? cancellable);
}
