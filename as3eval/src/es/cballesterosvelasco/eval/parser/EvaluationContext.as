package es.cballesterosvelasco.eval.parser 
{
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class EvaluationContext 
	{
		public var variables:Object;
		public var functions:Object;
		
		public function EvaluationContext(variables:Object = null, functions:Object = null) {
			if (variables == null) variables = { };
			if (functions == null) functions = { };
			this.variables = variables;
			this.functions = functions;
		}
	}

}