/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Value : Object, GXml.Serializable, LogicObject {
  public abstract bool state { get; set; }
  public abstract void set_operator (Plg.Operator op);
  public abstract Plg.Operator get_operator ();
  public class Map : Gee.HashMap<string,Plg.Value> {
    public new Plg.Value get (string name) { return base.get (name); }
  }
}
