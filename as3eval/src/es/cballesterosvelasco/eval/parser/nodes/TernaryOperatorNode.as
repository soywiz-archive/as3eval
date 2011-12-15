package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class TernaryOperatorNode extends Node
	{
		protected var conditionNode:Node;
		protected var trueNode:Node;
		protected var falseNode:Node;
		
		public function TernaryOperatorNode(conditionNode:Node, trueNode:Node, falseNode:Node) 
		{
			this.conditionNode = conditionNode;
			this.trueNode = trueNode;
			this.falseNode = falseNode;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			if (this.conditionNode.eval(context)) {
				return this.trueNode.eval(context);
			} else {
				return this.falseNode.eval(context);
			}
		}
	}

}