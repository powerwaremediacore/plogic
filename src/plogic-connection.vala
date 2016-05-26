/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Gee;

public interface Plg.Connection : Object {
  public abstract string operator { get; set; }
  public abstract string value { get; set; }
  public class Set : Gee.HashSet<Connection> {
    public new Connection[] to_array () { return ((Gee.Collection<Connection>) this).to_array (); }
  }
}
