package 
{
	import es.cballesterosvelasco.eval.Evaluator;
	import es.cballesterosvelasco.eval.lexer.tokenizer.Tokenizer;
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			setTimeout(function():void {
				main();
			}, 10);
		}
		
		private function main():void {
			var tokenizer:Tokenizer = new Tokenizer('12+(34+56)');
			
			if (tokenizer.toString() != 'Token("12":number),Token("+":operator),Token("(":operator),Token("34":number),Token("+":operator),Token("56":number),Token(")":operator),Token("":eof)') {
				trace('error! : ' + tokenizer.toString());
			}
			
			trace(Evaluator.eval('(values[2] & 3) == 7', new EvaluationContext({ 'values' : ['a', 'b', 7] })));
			trace(Evaluator.eval('1 * (1 + -2) - 4 + a + max(100, -10000) + values[2]', new EvaluationContext({ 'values' : [1,-9999999,3], 'a' : 999 }, { 'max' : Math.max } )));
		}
		
	}
	
}