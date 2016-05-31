/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Input : Object, GXml.Serializable, Plg.LogicObject, Plg.Value {
  public abstract Plg.Connection? connection { get; set; }
  // TODO: Add order property
  public class Map : GXml.SerializableHashMap<string,Input> {
    public new Input get (string name) { return base.get (name); }
  }
}
