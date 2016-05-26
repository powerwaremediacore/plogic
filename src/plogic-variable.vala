/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Variable : Object, LogicObject, Plg.Value {
  public abstract Plg.Connection.Set connections { get; set; }
  public class Map : Gee.HashMap<string,Variable> {
    public new Variable get (string name) { return base.get (name); }
  }
}
