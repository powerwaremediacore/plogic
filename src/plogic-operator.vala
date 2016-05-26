/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Operator : Object, Plg.LogicObject {
  public abstract Input.Map get_inputs ();
  public abstract bool get_evaluated ();
  public abstract void reset ();
  public abstract void evaluate (GLib.Cancellable? cancellable);
  public class Map : Gee.HashMap<string,Operator> {
    public new Operator get (string name) { return base.get (name); }
  }
}
