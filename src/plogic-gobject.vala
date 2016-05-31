/* -*- Mode: vala; indent-tabs-mode: nil; c-basic-offset: 0; tab-width: 2 -*- */
/*
 * Copyright (C) 2016  Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */

public class Plg.GObject : GXml.SerializableObjectModel {
  public override string node_name ()
  {
    string nname = get_type ().name ();
    if ("PlgG" in nname)
      nname = nname.replace ("PlgG","");
    return nname;
  }
  public override bool property_use_nick () { return true; }
  public override string to_string () { return get_type ().name (); }
}
