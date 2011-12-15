package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class NumericLiteralNode extends LiteralNode
	{
		public function NumericLiteralNode(numberString:String) 
		{
			super(parseFloat(numberString));
		}
	}

}