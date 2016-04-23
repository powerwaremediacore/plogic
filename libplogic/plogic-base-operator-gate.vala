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
using Gee;

public class Plog.BaseOperatorGate : Object, LogicObject, Operator, OperatorGate {
  protected Gee.HashMap<string,Input> _inputs = new Gee.HashMap<string,Input> ();
  protected bool _evaluated = false;
  protected Plog.Value _output = new Plog.Value ();

  public string name { get; set; default = "or";  }
  public bool enable { get; set; }
  public bool hold { get; set; }
  public Map<string,Input> inputs { get { return _inputs; } }
  public Value output { get { return _output; } }
  public bool evaluated { get { return _evaluated; } }
  public void reset () { _valuated = false; }
  public abstract void evaluate ();
  public virtual bool has_value_name (string name) {
    if (_output.name == name) return true;
    foreach (Input i in inputs) {
      if (i.name == name) return true;
    }
    return false;
  }
  public virtual void set_value_state (string name, bool state) {
    var i = inputs.get (name);
    if (i == null) return;
    i.state = state;
  }
}
