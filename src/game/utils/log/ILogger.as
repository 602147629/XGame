package game.utils.log
{
	/**
	 * 日志接口 
	 * @author cdr
	 * 
	 */	
	public interface ILogger
	{
		function log(type:int, message:String, ...params):void;
	}
}