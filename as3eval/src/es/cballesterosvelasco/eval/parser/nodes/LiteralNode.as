package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class LiteralNode extends Node
	{
		protected var value:String;
		
		public function LiteralNode(value:String) 
		{
			this.value = value;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			return value;
		}
	}

}