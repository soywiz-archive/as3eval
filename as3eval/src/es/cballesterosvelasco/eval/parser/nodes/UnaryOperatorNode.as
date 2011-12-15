package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class UnaryOperatorNode extends Node
	{
		protected var rightNode:Node;
		protected var operator:String
		
		public function UnaryOperatorNode(rightNode:Node, operator:String) 
		{
			this.rightNode = rightNode;
			this.operator = operator;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			var rightValue:* = rightNode.eval(context);
			
			switch (operator) {
				case '!': return !rightValue;
				case '~': return ~rightValue;
				case '-': return -rightValue;
				case '+': return +rightValue;
				default: throw(new Error("Can't evaluate unary operator '" + operator + "'"));
			}
		}
	}

}