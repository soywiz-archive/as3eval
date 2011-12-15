package es.cballesterosvelasco.eval.parser 
{
	import flash.utils.describeType;
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
			if (functions == null) {
				functions = { };
				var methods:* = describeType(EvaluationDefaultFunctions).method;
				for each (var method:* in methods) {
					functions[method.@name] = EvaluationDefaultFunctions[method.@name];
				}
			}
			this.variables = variables;
			this.functions = functions;
		}
	}

}