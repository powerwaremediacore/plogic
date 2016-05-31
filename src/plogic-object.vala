/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.LogicObject : Object, GXml.Serializable {
  public abstract string name { get; set; }
  public abstract bool enable { get; set; }
  public abstract void reset ();
}

