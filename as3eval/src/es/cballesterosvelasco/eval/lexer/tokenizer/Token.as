package es.cballesterosvelasco.eval.lexer.tokenizer 
{
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Token 
	{
		public var value:String;
		public var type:String;
		
		public function Token(value:String, type:String)
		{
			this.value = value;
			this.type = type;
		}
		
		public function toString():String
		{
			return 'Token("' + value + '":' + type + ')';
		}
		
		public function valueIsAnyOf(...possibleValues):Boolean {
			for each (var possibleValue:String in possibleValues) {
				if (value == possibleValue) return true;
			}
			return false;
		}
	}
}