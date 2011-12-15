package es.cballesterosvelasco.eval.parser 
{
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class EvaluationDefaultFunctions 
	{
		static public function cos(value:*) { return Math.cos(value); }
		static public function sin(value:*) { return Math.sin(value); }
		static public function tan(value:*) { return Math.tan(value); }
		
		static public function floor(value:*) { return Math.floor(value); }
		static public function ceil(value:*) { return Math.ceil(value); }
		static public function round(value:*) { return Math.round(value); }
		
		static public function abs(value:*) { return Math.abs(value); }
		
		static public function clamp(value:*, minimum:*, maximum:*):*
		{
			if (value < minimum) return minimum;
			if (value > maximum) return maximum;
			return value;
		}
		
		static public function max(a:*, b:*) { return Math.max(a, b); }
		static public function min(a:*, b:*) { return Math.min(a, b); }
	}

}