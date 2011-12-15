package es.cballesterosvelasco.eval.parser 
{
	import es.cballesterosvelasco.eval.lexer.tokenizer.Token;
	import es.cballesterosvelasco.eval.lexer.tokenizer.Tokenizer;
	import es.cballesterosvelasco.eval.parser.nodes.ArrayAccessNode;
	import es.cballesterosvelasco.eval.parser.nodes.BinaryOperatorNode;
	import es.cballesterosvelasco.eval.parser.nodes.FunctionCallNode;
	import es.cballesterosvelasco.eval.parser.nodes.FunctionNode;
	import es.cballesterosvelasco.eval.parser.nodes.IdentifierNode;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	import es.cballesterosvelasco.eval.parser.nodes.NumericLiteralNode;
	import es.cballesterosvelasco.eval.parser.nodes.StringLiteralNode;
	import es.cballesterosvelasco.eval.parser.nodes.TernaryOperatorNode;
	import es.cballesterosvelasco.eval.parser.nodes.UnaryOperatorNode;
	import es.cballesterosvelasco.eval.parser.nodes.VariableNode;
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class Parser 
	{
		protected var tokenizer:Tokenizer;
		
		public function Parser(tokenizer:Tokenizer)
		{
			this.tokenizer = tokenizer;
		}
		
		public function parse():Node {
			var node:Node = parseExpression();
			if (tokenizer.current.type != 'eof') throw(new Error("Expression not completed"));
			return node;
		}
		
		public function parseIdentifier():Node {
			var currentNode:Token = tokenizer.current;
			
			// Identifier.
			// ID
			if (currentNode.type == 'id') {
				tokenizer.next();
				return new IdentifierNode(currentNode.value);
			}
			
			/*
			if (currentNode.type == 'number') {
				tokenizer.next();
				return new NumericNode(currentNode.value);
			}
			*/
			
			throw(new Error("Not an identifier : " + currentNode));
		}
		
		public function parseLiteralUnary():Node {
			var currentNode:Token = tokenizer.current;
			
			// '(' <expression> ')'
			if (tokenizer.checkAndMoveNext('(')) {
				var subExpression:Node = parseExpression();
				tokenizer.expectAndMoveNext(')');
				return subExpression;
			}

			// Unary operator.
			if (currentNode.valueIsAnyOf('-', '+', '~', '!')) {
				tokenizer.next();
				return new UnaryOperatorNode(parseLiteralUnary(), currentNode.value);
			}
			
			// Numeric literal.
			if (currentNode.type == 'number') {
				tokenizer.next();
				return new NumericLiteralNode(currentNode.value);
			}

			// String literal.
			if (currentNode.type == 'string') {
				tokenizer.next();
				return new StringLiteralNode(currentNode.value);
			}

			// Function call.
			// ID '(' call_arguments ')'
			if (currentNode.type == 'id') {
				//trace(tokenizer.current);
				tokenizer.next();
				//trace(tokenizer.current);
				
				var leftNode:Node = null;
				
				var currentType:String = '';
				if (tokenizer.current.valueIsAnyOf('(', '[', '.')) {
					switch (tokenizer.current.value) {
						case '(':
							leftNode = new FunctionNode(currentNode.value);
							break;
						case '[':
						case '.':
							leftNode = new IdentifierNode(currentNode.value);
							break;
						default:
							throw(new Error("Unexpected!"));
					}
					
					while (tokenizer.current.valueIsAnyOf('(', '[', '.')) {
						currentType = tokenizer.current.value;
						//throw(new Error("Not implemented function call"));
						var callArguments:Vector.<Node> = new Vector.<Node>();

						tokenizer.next();
						while (true) {
							if (currentType == '.') {
								callArguments.push(parseIdentifier());
								//tokenizer.next();
								break;
							}
							
							//trace(tokenizer.current);
							var callArgument:Node = parseExpression();
							callArguments.push(callArgument);
							
							if (currentType == '(') {
								if (tokenizer.current.value == ')') {
									tokenizer.next();
									break;
								}

								if (tokenizer.current.value == ',') {
									tokenizer.next();
									continue;
								}
							} else if (currentType == '[') {
								if (tokenizer.current.value == ']') {
									tokenizer.next();
									break;
								}
							} else {
								throw(new Error("Unexpected currentType! : " + currentType));
							}

							throw(new Error("Invalid function call. " + tokenizer.current + ' not expected.'));
						}
						
						if (currentType == '(') {
							leftNode = new FunctionCallNode(leftNode, callArguments);
						} else if (currentType == '[' || currentType == '.') {
							leftNode = new ArrayAccessNode(leftNode, callArguments[0]);
						} else {
							throw(new Error("Unexpected!"));
						}
					}
				}
				
				//trace(leftNode);
				
				// Call or access
				if (leftNode != null) {
					return leftNode;
				}
				
				tokenizer.prev();
			}
			
			// Variable.
			// ID
			if (currentNode.type == 'id') {
				tokenizer.next();
				return new VariableNode(currentNode.value);
			}
			
			throw(new Error("Invalid token on parseLiteralUnary : " + currentNode));
		}

		public function parseTernary():Node {
			var left:Node = parseLiteralUnary();
			if (tokenizer.current.value == '?') {
				tokenizer.next();
				var middle:Node = parseExpression();
				tokenizer.expectAndMoveNext(':');
				var right:Node = parseExpression();
				
				left = new TernaryOperatorNode(left, middle, right);
			}
			return left;
		}

		public function parseLogicOr():Node {
			return parseBinary('parseLogicOr', parseTernary, '||');
		}

		public function parseLogicAnd():Node {
			return parseBinary('parseLogicAnd', parseLogicOr, '&&');
		}

		public function parseBitOr():Node {
			return parseBinary('parseBitOr', parseLogicAnd, '|');
		}

		public function parseBitXor():Node {
			return parseBinary('parseBitXor', parseBitOr, '^');
		}

		public function parseBitAnd():Node {
			return parseBinary('parseBitAnd', parseBitXor, '&');
		}

		public function parseCompare():Node {
			return parseBinary('parseCompare', parseBitAnd, '==', '!=', '>=', '<=', '>', '<', '===', '!==');
		}

		public function parseAddSub():Node {
			return parseBinary('parseAddSub', parseCompare, '+', '-');
		}
		
		public function parseMulDiv():Node {
			return parseBinary('parseMulDiv', parseAddSub, '*', '/', '%');
		}

		public function parseExpression():Node {
			return parseMulDiv();
		}
		
		private function parseBinary(levelName:String, nextParseLevel:Function, ...validOperators):Node {
			var leftNode:Node = nextParseLevel();
			var rightNode:Node;
			var currentOperator:String;
			
			while (tokenizer.hasMore) {

				var foundValidOperator:Boolean = false;
				for each (var validOperator:* in validOperators) {
					if (tokenizer.current.value == validOperator) {
						foundValidOperator = true;
						currentOperator = tokenizer.current.value;
						tokenizer.next();
						break;
					}
				}
				
				if (!foundValidOperator) {
					break;
				}
				
				rightNode = nextParseLevel();
				leftNode = new BinaryOperatorNode(leftNode, rightNode, currentOperator);
			}
			
			return leftNode;
		}
	}

}