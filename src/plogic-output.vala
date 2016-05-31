/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.Output : Object, GXml.Serializable, LogicObject, Plg.Value {
  /**
   * A set of {@link Plg.Connection} objects updated by this output.
   */
  public abstract Plg.Connection.Set connections { get; set; }
  /**
   * A {@link Plg.Connection} object to refer updates source. It is
   * used by {@link Plg.Operator.evaluate()} to find sources to be
   * evaluated before this output is updated.
   *
   * You should use {@link Plg.Block.connect_output()} as convenience
   * in order to set it. If you set is directly, you should set
   * {@link Plg.Connection.operator} and {@link Plg.Connection.value} to
   * point to a block internal operator. {@link Plg.OperatorGate} objects
   * have just one {@link Plg.Output}, used and updated internally, with no
   * connection to other operator.
   */
  [Description (nick="InternalConnection")]
  public abstract Plg.InternalConnection internal_connection { get; set; }
  public class Map : GXml.SerializableHashMap<string,Output> {
    public new Output get (string name) { return base.get (name); }
  }
}
