package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class StringLiteralNode extends LiteralNode
	{
		public function StringLiteralNode(value:*) 
		{
			super(stripSlashes(value));
		}
		
		static protected function stripSlashes(string:String):String {
			if (
				(string.substr(0, 1) == "'" && string.substr( -1, 1) == "'") ||
				(string.substr(0, 1) == '"' && string.substr( -1, 1) == '"')
			) {
				return _stripSlashes(string.substr(1, string.length - 2));
			}
			throw(new Error("Invalid string literal : " + string));
		}

		static protected function _stripSlashes(string:String):String {
			var out:String = '';
			for (var n:int = 0; n < string.length; n++) {
				if (string.charAt(n) == '\\') {
					var escapeSequence:String = string.substr(n, 2);
					switch (escapeSequence) {
						case "\\n": out += "\n"; break;
						case "\\r": out += "\r"; break;
						case "\\t": out += "\t"; break;
						default: throw(new Error("Invalid escape sequence '" + escapeSequence + "' @ '" + string + "'"));
					}
					n++;
				} else {
					out += string.charAt(n);
				}
			}
			return out;
		}
	}

}