package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Node 
	{
		public function Node() 
		{
		}
		
		public function eval(context:EvaluationContext):*
		{
			throw(new Error("Must implement"));
		}
		
		public function optimize():Node {
			return this;
		}
	}

}