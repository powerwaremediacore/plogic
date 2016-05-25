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

public class Plg.BlockDefinition : BaseOperator, Plg.Block {
  protected Output.Map _outputs = new Output.Map ();
  protected Plg.Value.Map _values = new Value.Map ();
  protected Operator.Map _operators = new Operator.Map ();

  public Output.Map get_outputs () { return _outputs; }
  public Plg.Operator.Map get_operators () { return _operators; }
  public Plg.Value.Map get_values () { return _values; }

  public override void evaluate (GLib.Cancellable? cancellable = null) {
    _evaluated = true;
    foreach (Operator op in get_operators ().values) {
      op.evaluate (null);
    }
  }
}
