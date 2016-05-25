/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
public class Plg.BaseOperatorGate : Plg.BaseOperator, OperatorGate {
  public Value output { get { return _output; } }
  public virtual void evaluate () { return; }
}
