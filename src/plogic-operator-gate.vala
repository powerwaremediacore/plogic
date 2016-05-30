/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public interface Plg.OperatorGate : Object, Plg.LogicObject, Plg.Operator {
  /**
   * Implementators should not set this property, but internally.
   */
  public abstract Plg.Output output { get; set; }
}
