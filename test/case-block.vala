/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 2; tab-width: 2 -*-  */
/*
 * Copyright (C) 2016 Daniel Espinosa <daniel.espinosa@pwmc.mx>
 */
using Plg;

public class PlogicTest.CaseBlock
{
	public static void add_funcs ()
	{
		Test.add_func ("/plogic/case/block-or/no-evaluation",
		() => {
			var b = new Plg.GBlock ();
			assert (b.name == "Block1");
			var op = new Plg.GOr ();
			assert (op.enable);
			assert (op.name == "OR1");
			assert (b.get_operators ().size == 0);
			b.add_operator (op);
			assert (b.get_operators ().size == 1);
			var i1 = new Plg.GInput ();
			i1.name = "Input1";
			var i2 = new Plg.GInput ();
			i1.name = "Input2";
			op.get_inputs ().set (i1.name, i1);
			op.get_inputs ().set (i2.name, i2);
			assert (op.get_inputs ().size == 2);
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (i1.state);
			assert (i1.enable);
			assert (i2.state);
			assert (i2.enable);
			assert (op.get_parent () != null);
			assert (op.get_parent ().name == "Block1");
			assert (op.get_output ().state == false);
			i1.state = false;
			assert (i1.state == false);
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == false);
			i1.state = true;
			i2.state = false;
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == false);
			i1.state = false;
			i2.state = false;
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == false);
		});
		Test.add_func ("/plogic/case/block-or/connect",
		() => {
			var b = new Plg.GBlock ();
			assert (b.name == "Block1");
			var op = new Plg.GOr ();
			assert (op.enable);
			assert (op.name == "OR1");
			assert (b.get_operators ().size == 0);
			b.add_operator (op);
			assert (b.get_operators ().size == 1);
			var i1 = new Plg.GInput ();
			i1.name = "Input1";
			var i2 = new Plg.GInput ();
			i1.name = "Input2";
			op.get_inputs ().set (i1.name, i1);
			op.get_inputs ().set (i2.name, i2);
			assert (op.get_inputs ().size == 2);
			var bi1 = new Plg.GInput ();
			bi1.name = "Input1";
			b.get_inputs ().set (bi1.name, bi1);
			assert (bi1.state == true);
			assert (bi1.enable == true);
			var bi2 = new Plg.GInput ();
			bi2.name = "Input2";
			assert (bi2.state == true);
			assert (bi2.enable == true);
			b.get_inputs ().set (bi2.name, bi2);
			assert (b.get_inputs ().size == 2);
			var c1 = new GConnection ();
			c1.value = "Input1"; // Block.Input2
			op.get_inputs ().get ("Input1").connection = c1;
			var c2 = new GConnection ();
			c2.value = "Input2"; // Block.Input2
			op.get_inputs ().get ("Input2").connection = c2;
			var bo1 = new Plg.GOutput ();
			assert (bo1.name == "Output1");
			b.get_outputs ().set (bo1.name, bo1);
			var c3 = new GConnection ();
			c3.value = "Output1";
			op.get_output ().connections.add (c3);
			b.evaluate ();
			assert (op.get_evaluated ());
			assert (b.get_outputs ().get ("Output1").state == true);
			bi1.state = false;
			b.evaluate ();
			assert (op.get_evaluated ());
			assert (b.get_outputs ().get ("Output1").state == true);
			bi2.state = false;
			b.evaluate ();
			assert (op.get_evaluated ());
			assert (op.get_output ().state == false);
			assert (b.get_outputs ().get ("Output1").state == false);
		});
		Test.add_func ("/plogic/case/block-and/no-evaluation",
		() => {
			var b = new Plg.GBlock ();
			assert (b.name == "Block1");
			var op = new Plg.GAnd ();
			assert (op.enable);
			assert (op.name == "AND1");
			assert (b.get_operators ().size == 0);
			b.add_operator (op);
			assert (b.get_operators ().size == 1);
			var i1 = new Plg.GInput ();
			i1.name = "Input1";
			var i2 = new Plg.GInput ();
			i1.name = "Input2";
			op.get_inputs ().set (i1.name, i1);
			op.get_inputs ().set (i2.name, i2);
			assert (op.get_inputs ().size == 2);
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (i1.state);
			assert (i1.enable);
			assert (i2.state);
			assert (i2.enable);
			assert (op.get_parent () != null);
			assert (op.get_parent ().name == "Block1");
			assert (op.get_output ().state == true);
			i1.state = false;
			assert (i1.state == false);
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == true);
			i1.state = true;
			i2.state = false;
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == true);
			i1.state = false;
			i2.state = false;
			op.evaluate ();
			assert (!op.get_evaluated ());
			assert (op.get_output ().state == true);
		});
	}
}
