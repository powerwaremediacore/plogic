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

public interface Plg.Block : Object, GXml.Serializable, Plg.LogicObject, Plg.Operator {
  public abstract Plg.Output.Map outputs { get; set; }
  public abstract Plg.Variable.Map variables { get; set; }
  public abstract Plg.Operator.Map operators { get; set; }

  public abstract bool connect_output_internal (string name, string operator, string value);
  public abstract bool connect_input_internal (string name, string operator, string value);
}
