/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.GBaseOperatorGate : Plg.BaseOperator, OperatorGate {
  protected Plg.OutputValue _output = new Plg.OutputValue ();
  public Plg.Output get_output () { return _output; }
}
