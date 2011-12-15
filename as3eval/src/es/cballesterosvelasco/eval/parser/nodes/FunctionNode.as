package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class FunctionNode extends Node
	{
		protected var name:String;
		
		public function FunctionNode(name:String) 
		{
			this.name = name;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			var value:* = context.functions[this.name];
			if (value === undefined) throw(new Error("Can't find function '" + this.name + "'"));
			return value;
		}
	}

}