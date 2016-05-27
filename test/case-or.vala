/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 2; tab-width: 2 -*-  */
/*
 * Copyright (C) 2016 Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Plg;

public class PlogicTest.CaseOr
{
	public static void add_funcs ()
	{
		Test.add_func ("/plogic/case/or",
		() => {
			var op = new Plg.GOr ();
			assert (op.enable);
			assert (op.name == "OR1");
			var i1 = new Plg.GInput ();
			i1.name = "Input1";
			var i2 = new Plg.GInput ();
			i1.name = "Input2";
			op.get_inputs ().set (i1.name, i1);
			op.get_inputs ().set (i2.name, i2);
			assert (op.get_inputs ().size == 2);
			op.evaluate ();
			assert (i1.state);
			assert (i1.enable);
			assert (i2.state);
			assert (i2.enable);
			assert (op.get_parent () == null);
			assert (op.get_output ().state == true);
			i1.state = false;
			assert (i1.state == false);
			op.evaluate (null);
			assert (op.get_output ().state == true);
			i1.state = true;
			i2.state = false;
			op.evaluate (null);
			assert (op.get_output ().state == true);
			i1.state = false;
			i2.state = false;
			op.evaluate (null);
			assert (op.get_output ().state == false);
		});
	}
}
