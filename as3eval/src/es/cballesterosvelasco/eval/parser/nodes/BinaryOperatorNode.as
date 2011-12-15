package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class BinaryOperatorNode extends Node
	{
		protected var leftNode:Node;
		protected var rightNode:Node;
		protected var operator:String;
		
		public function BinaryOperatorNode(leftNode:Node, rightNode:Node, operator:String) 
		{
			this.leftNode = leftNode;
			this.rightNode = rightNode;
			this.operator = operator;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			var leftValue:* = leftNode.eval(context);
			var rightValue:* = rightNode.eval(context);
			switch (operator) {
				case '+': return leftValue + rightValue;
				case '-': return leftValue - rightValue;
				case '*': return leftValue * rightValue;
				case '/': return leftValue / rightValue;
				case '%': return leftValue % rightValue;
				case '&': return leftValue & rightValue;
				case '|': return leftValue | rightValue;
				case '^': return leftValue ^ rightValue;
				case '&&': return leftValue && rightValue;
				case '||': return leftValue || rightValue;
				default: throw(new Error("Can't evaluate binary operator '" + operator + "'"));
			}
		}
	}

}