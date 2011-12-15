package es.cballesterosvelasco.eval.lexer 
{
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	final public class CharType 
	{
		/**
		 * 
		 * @param	char
		 * @return
		 */
		static private function ordinal(char:String):int
		{
			if (char.length < 1) return -1;
			return int(char.charCodeAt(0));
		}
		
		/**
		 * 
		 * @param	char
		 * @return
		 */
		static public function isNumeric(char:String):Boolean
		{
			return (ordinal(char) >= ordinal('0') && ordinal(char) <= ordinal('9'));
		}
		
		/**
		 * 
		 * @param	char
		 * @return
		 */
		static public function isAlpha(char:String):Boolean
		{
			if (ordinal(char) >= ordinal('a') && ordinal(char) <= ordinal('z')) return true;
			if (ordinal(char) >= ordinal('A') && ordinal(char) <= ordinal('Z')) return true;
			switch (char) {
				case '_': return true;
			}
			return false;
		}

		/**
		 * 
		 * @param	char
		 * @return
		 */
		static public function isAlphaOrNumeric(char:String):Boolean
		{
			return isNumeric(char) || isAlpha(char);
		}

		/**
		 * 
		 * @param	charAt
		 */
		static public function isSpace(char:String):Boolean
		{
			if (ordinal(char) == ordinal(" ")) return true;
			if (ordinal(char) == ordinal("\t")) return true;
			if (ordinal(char) == ordinal("\r")) return true;
			if (ordinal(char) == ordinal("\n")) return true;
			return false;
		}
	}
}