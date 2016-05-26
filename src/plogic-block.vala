/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

using Gee;

public errordomain Plg.BlockError {
  INVALID_INPUT_NAME,
  INVALID_OUTPUT_NAME,
  INVALID_VALUE_NAME
}

public interface Plg.Block : Object, Plg.LogicObject, Plg.Operator {
  public abstract Plg.Output.Map get_outputs ();
  public abstract Plg.Variable.Map get_variables ();
  public abstract Plg.Operator.Map get_operators ();
  public abstract Plg.Value get_connection_value ();
}
