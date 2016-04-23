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

public interface Plog.BlockDefinition : Object, LogicObject, Block {
  protected Gee.HashMap<string,Input> _inputs = new Gee.HashMap<string,Input> ();
  protected Gee.HashMap<string,Output> _outputs = new Gee.HashMap<string,Output> ();
  protected Gee.HashMap<string,Value> _values = new Gee.HashMap<string,Value> ();
  protected Gee.HashMap<string,Gee.HashSet<string>> _connections = new Gee.HashMap<string,Gee.HashSet<string>> ();
  protected Gee.HashMap<string,Operator> _operators = new Gee.HashMap<string,Operator> ();

  public string name { get; set; }
  public bool enable { get; set; }
  public bool hold { get; set; }
  public Collection<Input> inputs { get { return _inputs; } }
  public Collection<Output> outputs { get { return _outputs; } }
  public bool evaluated { get; }
  
  public bool has_value_name (string name) {
    if (_outputs.has_key (input.name)
          || _inputs.has_key (input.name)
          || _values.has_key (input.name))
      return true;
    else {
      foreach (Operator op in _operators) {
        if (op.has_value_name (name)) return true;
      }
    }
    return false;
  }
  
  public void add_input (Input input) throws GLib.Error {
    if (!has_value_name (input.name))
      throw new BlockError.INVALID_INPUT_NAME ("invalid input name");
    _inputs.set (input.name, input);
  }

  public void add_output (Output output) throws GLib.Error {
    if (!has_value_name (input.name))
      throw new BlockError.INVALID_OUTPUT_NAME ("invalid output name");
    _outputs.set (output.name, input);
  }

  public void add_internal_value (Plog.Value val) throws GLib.Error {
    if (!has_value_name (input.name))
      throw new BlockError.INVALID_VALUE_NAME ("invalid value name");
    _values.set (val.name, val);
  }

  public void connect (string valsrc, string valdst) throws GLib.Error {
    if (valsrc == valdst) return;
    if (has_value_name (valsrc))
      throw new BlockError.INVALID_VALUE_NAME ("Source value name is invalid");
    if (has_value_name (valdst))
      throw new BlockError.INVALID_VALUE_NAME ("Destiny value name is invalid");

    if (_connections.has_key (valsrc)) {
      _connection.get (valsrc).add (valdst);
    else
      _connections.set (valdst, (new Gee.HashSet()).add (valdst));
  }

  public void add_operator (Operator op) throws GLib.Error {
    int i = 0;
    string name = op.name;
    while (_operators.has_key (name))
      name = op.name + i.to_string ();
    op.name = name;
    _operators.set (op.name, op);
  }
  public bool are_connected (string src, string dst) {
    if (!_connections.has_key (src)) return false;
    if (!_connections.get (src).contains (dst)) return false;
    return true;
  }
  public bool is_connected (string name) {
    if (_connections.has_key (name)) return true;
    foreach (HashSet s in _connections.values) {
      if (s.has_key (name)) return true;
    }
    return false;
  }
  public LogicObject get_object_from_value_name (string name) {
    if (_inputs.has_key (name)) return _inputs.get (name);
    if (_outputs.has_key (name)) return _outputs.get (name);
    foreach (Operator op in _operators.values) {
      if (op.has_value_name (name)) return op;
    }
  }
  public void set_value_state (string name, bool state) {
    _evaluated = false;
    if (!enable) return;
    if (_inputs.has_key (name)) {
      _inputs.get (name).state = state;
      return;
    }
    if (_outputs.has_key (name)) {
      _outputs.get (name).state = state;
      return;
    }
    if (_values.has_key (name)) {
      _inputs.get (name).state = state;
      return;
    }
    foreach (Operator op in _operators) {
      op.set_value_state (name);
    }
  }
  public void evaluate () {
    var eops = new HashSet<string> ();
    foreach (Operator op in _operators.values) {
      op.hold = false;
      foreach (Input iop in op.inputs.values) {
        if (is_connected (iop.name)) {
          iop.enable = true;
          var o = get_object_from_value_name (iop.name);
          if (!(o is Plog.Value)) {
            if (o.enable && o.hold) {
              iop.hold = true;
              op.hold = true;
              continue;
            }
          }
          if (!o.enable) continue;
          i
        }
        else
          iop.enable = false;
        if (op.hold) eops.add (op);
      }
    }
  }
}
