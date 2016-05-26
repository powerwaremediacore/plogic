/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public interface Plg.GConnection : Object, Plg.Connection {
  public string operator { get; set; }
  public string value { get; set; }
}
