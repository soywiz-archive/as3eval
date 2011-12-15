package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class NumericNode extends Node
	{
		protected var number:Number;
		
		public function NumericNode(numberString:String) 
		{
			this.number = parseFloat(numberString);
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			return number;
		}
	}

}