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
		
		private function checkEquals(expected:*, real:*):void {
			if (expected !== real) {
				trace('Unexpected result :: ' + expected + ' != ' + real);
			}
		}
		
		private function main():void {
			checkEquals(
				'Token("12":number),Token("+":operator),Token("(":operator),Token("34":number),Token("+":operator),Token("56":number),Token(")":operator),Token("":eof)',
				new Tokenizer('12+(34+56)').toString()
			);
			
			checkEquals('true', Evaluator.eval("1 ? 'true' : 'false'"));
			checkEquals('false for real', Evaluator.eval("0 ? 'true' : 'false' + ' for real'"));
			checkEquals(true, Evaluator.eval('(6 + 1) == 7'));
			checkEquals(false, Evaluator.eval('(values[2][2 - 1] & 3) == max(3, 7)', new EvaluationContext({ 'values' : ['a', 'b', [0, 7]] })));
			checkEquals(1097, Evaluator.eval('1 * (1 + -2) - 4 + a + max(100, -10000) + values[2]', new EvaluationContext( { 'values' : [1, -9999999, 3], 'a' : 999 }, { 'max' : Math.max } )));
			checkEquals(true, Evaluator.eval('-2 < -1'));
			checkEquals(false, Evaluator.eval('2 > 2'));
		}
		
	}
	
}