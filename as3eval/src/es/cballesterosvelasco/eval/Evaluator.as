package es.cballesterosvelasco.eval 
{
	import es.cballesterosvelasco.eval.lexer.tokenizer.Tokenizer;
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	import es.cballesterosvelasco.eval.parser.Parser;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Evaluator 
	{
		/**
		 * Evaluates an expression.
		 * 
		 * @param	string
		 * @param	executionContext
		 * @return
		 */
		static public function eval(string:String, evaluationContext:EvaluationContext = null):* {
			var tokenizer:Tokenizer = new Tokenizer(string);
			var parser:Parser = new Parser(tokenizer);
			//trace(tokenizer);
			var expression:Node = parser.parse();
			if (evaluationContext == null) evaluationContext = new EvaluationContext();
			return expression.eval(evaluationContext);
		}
	}

}