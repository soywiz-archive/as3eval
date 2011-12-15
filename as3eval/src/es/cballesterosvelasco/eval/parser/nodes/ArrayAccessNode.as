package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class ArrayAccessNode extends Node
	{
		protected var leftNode:Node;
		protected var accessNode:Node
		
		public function ArrayAccessNode(leftNode:Node, accessNode:Node) 
		{
			this.leftNode = leftNode;
			this.accessNode = accessNode;
		}

		override public function eval(context:EvaluationContext):* 
		{
			var left:* = this.leftNode.eval(context);
			var access:* = this.accessNode.eval(context);
			
			return left[access];
		}
	}

}