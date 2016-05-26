/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public interface Plg.OperatorGate : Object, Plg.LogicObject, Plg.Operator {
  public abstract Plg.Output get_output ();
}
