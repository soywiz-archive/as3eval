package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class IdentifierNode extends Node
	{
		protected var id:String;
		
		public function IdentifierNode(id:String) 
		{
			this.id = id;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			return context.variables[this.id];
		}
	}

}