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

public class Plog.And : Plog.BaseOperator {
  public override void evaluate () {
    _evaluated = false;
    if (!enable) return;
    bool s = true;
    foreach (Input input in inputs.values) {
      if (!input.enable) continue;
      s = s && input.state;
      if (!s) break;
    }
    _output.state = s;
    if (!hold)
      _evaluated = true;
  }
}
