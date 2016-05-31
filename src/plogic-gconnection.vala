/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public class Plg.GConnection : Plg.GObject, Plg.Connection {
  public string operator { get; set; }
  public string value { get; set; }
}

public class Plg.GInternalConnection : GConnection, Plg.InternalConnection {}
