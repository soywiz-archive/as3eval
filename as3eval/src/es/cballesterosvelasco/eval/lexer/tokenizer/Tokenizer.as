package es.cballesterosvelasco.eval.lexer.tokenizer 
{
	import es.cballesterosvelasco.eval.lexer.CharType;
	import flash.events.WeakFunctionClosure;

	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Tokenizer 
	{
		protected var string:String;
		protected var tokens:Vector.<Token>;
		public var currentTokenIndex:int;
		static private var operators:Object = null;
		
		static private function addOperator(operator:String):void
		{
			operators[operator] = true;
		}

		static private function addOperators(...args):void
		{
			for each (var argument:String in args) {
				addOperator(argument);
			}
		}

		static private function hasOperator(operator:String):Boolean
		{
			return (operators[operator] !== undefined);
		}
		
		public function get current():Token {
			if (currentTokenIndex < 0 || currentTokenIndex >= tokens.length) throw(new Error("Invalid token index '" + currentTokenIndex + "'/'" + tokens.length + "' : " + this));
			var currentToken:Token = tokens[currentTokenIndex];
			if (currentToken == null) throw(new Error("Token is null at position '" + currentTokenIndex + "'/'" + tokens.length + "'"));
			return currentToken;
		}
		
		public function get hasMore():Boolean {
			return currentTokenIndex < tokens.length;
		}
		
		public function next():void {
			//trace("NEXT: " + currentTokenIndex);
			if (!hasMore) throw(new Error("No more tokens"));
			currentTokenIndex++;
		}

		public function prev():void {
			currentTokenIndex--;
		}

		public function Tokenizer(string:String)
		{
			if (operators == null) {
				operators = { };
				
				// Arithmetic.
				addOperators('+', '-', '*', '/', '%');
				// Logic.
				addOperators('&', '|', '^', "~");
				
				addOperators('&&', '||', '!');
				
				addOperators('==', '!=', '>=', '<=', '>', '<', '===', '!==');
				
				addOperators('(', ')');
				
				addOperators('[', ']');
				
				addOperators('?', ':');

				addOperators('.', ',');
			}
			
			this.string = string;
			this.tokens = new Vector.<Token>();
			tokenize();
		}
		
		private function tokenize():void 
		{
			var m:int;
			//var currentToken:String = '';
			
			var emitToken:Function = function(currentToken:String, type:String):void {
				tokens.push(new Token(currentToken, type));
			};
			
			for (var n:int = 0; n < string.length; ) {
				// A space character
				if (CharType.isSpace(string.charAt(n))) {
					n++;
					continue;
				}
				
				// Number.
				if (CharType.isNumeric(string.charAt(n))) {
					m = n++;
					while (n < string.length && (CharType.isNumeric(string.charAt(n)) || string.charAt(n) == '.')) n++;
					emitToken(string.substr(m, n - m), 'number');
					continue;
				}
				
				// A keyword, variable or name function.
				if (CharType.isAlpha(string.charAt(n))) {
					m = n++;
					while (n < string.length && CharType.isAlphaOrNumeric(string.charAt(n))) n++;
					emitToken(string.substr(m, n - m), 'id');
					continue;
				}

				// A symbol that can be an operator.
				if (!CharType.isAlpha(string.charAt(n))) {
					var op:String;
					if (hasOperator(op = string.substr(n, 3))) { n += 3; emitToken(op, 'operator'); continue; }
					if (hasOperator(op = string.substr(n, 2))) { n += 2; emitToken(op, 'operator'); continue; }
					if (hasOperator(op = string.substr(n, 1))) { n += 1; emitToken(op, 'operator'); continue; }
				}
				
				// A string.
				if (string.charAt(n) == '"' || string.charAt(n) == "'") {
					var openChar:String = string.charAt(n);
					m = n++;
					while (n < string.length) {
						if (string.charAt(n) == openChar) break;
						if (string.charAt(n) == '\\') {
							n++;
						}
						n++;
					}
					n++;
					emitToken(string.substr(m, n - m), 'string');
					continue;
				}
				
				throw(new Error("Invalid character '" + string.charAt(n) + "'!"));
				//n++;
			}

			emitToken('', 'eof');

			currentTokenIndex = 0;
			
			/*
			for each (var token:* in tokens) {
				trace(token);
			}
			*/
			//emitToken();
		}
		
		public function toString():String
		{
			var str:String = '';
			for each (var token:* in tokens) {
				if (str.length > 0) str += ',';
				str += '' + token;
			}
			return str;
		}

		public function checkAndMoveNext(string:String):Boolean
		{
			var that:Token = current;
			if (that.value != string) return false;
			next();
			return true;
		}

		public function expectAndMoveNext(string:String):Token
		{
			var that:Token = current;
			if (that.value != string) throw(new Error('Expecting token "' + string + '" but found "' + that.value + '"'));
			next();
			return that;
		}
	}

}