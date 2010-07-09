package gCode {
	import qEngine.qMath.Vector2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface I_Asteroid {
		function canSplit():Boolean
		function split(vector:Vector2D):Asteroid
		//function 
	}
	
}