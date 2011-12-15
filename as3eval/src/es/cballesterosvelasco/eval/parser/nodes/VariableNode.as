package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class VariableNode extends Node
	{
		protected var name:String;
		
		public function VariableNode(name:String) 
		{
			this.name = name;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			var value:* = context.variables[this.name];
			if (value === undefined) throw(new Error("Can't find variable '" + this.name + "'"));
			return value;
		}
	}

}