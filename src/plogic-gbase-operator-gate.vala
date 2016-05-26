/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public abstract class Plg.GBaseOperatorGate : Plg.GBaseOperator, OperatorGate {
  protected Plg.Output _output = new Plg.GOutput ();
  public Plg.Output get_output () { return _output; }
}
