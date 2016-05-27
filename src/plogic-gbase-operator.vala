/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.GBaseOperator : Object, LogicObject, Operator {
  protected Input.Map _inputs = new Input.Map ();
  protected bool _evaluated = false;
  protected Plg.Block _parent;

  public string name { get; set; default = "or";  }
  public bool enable { get; set; default = true; }
  public Input.Map get_inputs () { return _inputs; }
  public bool get_evaluated () { return _evaluated; }
  public void reset () { _evaluated = false; }
  public void set_parent (Plg.Block parent) {
    _parent = parent;
  }
  public Plg.Block? get_parent () {
    return _parent;
  }
  public abstract void evaluate (GLib.Cancellable? cancellable = null);
}
