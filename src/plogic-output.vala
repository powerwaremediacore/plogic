/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Output : Object, LogicObject, Plg.Value {
  /**
   * A set of {@link Plg.Connection} objects updated by this output.
   */
  public abstract Plg.Connection.Set connections { get; set; }
  public class Map : Gee.HashMap<string,Output> {
    public new Output get (string name) { return base.get (name); }
  }
}
