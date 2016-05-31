/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.GBaseOperator : Object, LogicObject, Operator {
  protected bool _evaluated = false;
  protected Plg.Block _parent;

  public string name { get; set; default = "or";  }
  public bool enable { get; set; default = true; }
  public Input.Map inputs { get; set; default = new Input.Map (); }
  public bool get_evaluated () { return _evaluated; }
  public virtual void reset () { _evaluated = false; }
  public void set_parent (Plg.Block parent) {
    _parent = parent;
  }
  public Plg.Block? get_parent () {
    return _parent;
  }
  public abstract void evaluate (GLib.Cancellable? cancellable = null);
}
