package game.log
{
	/**
	 * 日志接口 
	 * @author chendong
	 * 
	 */	
	public interface ILogger
	{
		function log(type:int, message:String, ...params):void;
	}
}