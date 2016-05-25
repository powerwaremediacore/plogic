/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *      Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public class Plg.ValueHolder : Object, Plg.LogicObject, Plg.Value {
  protected Plg.Operator _operator = null;
  public string name { get; set; }
  public bool enable { get; set; }
  public bool hold { get; set; }
  public bool state { get; set; default = true; }
  public Operator get_operator () { return _operator; }
  public ValueHolder.with_operator (Plg.Operator op) { _operator = op; }
}

public class Plg.InputValue : Plg.ValueHolder, Input {
  public InputValue.with_operator (Plg.Operator op) { _operator = op; }
}

public class Plg.OutputValue : Plg.ValueHolder, Output {
  public OutputValue.with_operator (Plg.Operator op) { _operator = op; }
}
