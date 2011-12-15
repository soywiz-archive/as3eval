package es.cballesterosvelasco.eval.parser.nodes 
{
	import es.cballesterosvelasco.eval.parser.EvaluationContext;
	import es.cballesterosvelasco.eval.parser.nodes.Node;
	
	/**
	 * ...
	 * @author Carlos Ballesteros Velasco
	 */
	public class FunctionCallNode extends Node
	{
		protected var callFunctionNode:Node;
		protected var callArgumentNodes:Vector.<Node>
		
		public function FunctionCallNode(callFunctionNode:Node, callArgumentNodes:Vector.<Node>) 
		{
			this.callFunctionNode = callFunctionNode;
			this.callArgumentNodes = callArgumentNodes;
		}
		
		override public function eval(context:EvaluationContext):* 
		{
			var callFunction:Function;
			var callArgumentValues = new Array();
			for each (var callArgumentNode:Node in callArgumentNodes) {
				callArgumentValues.push(callArgumentNode.eval(context));
			}

			callFunction = callFunctionNode.eval(context);
			
			return callFunction.apply(null, callArgumentValues);
		}
	}

}