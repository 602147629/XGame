package game.utils.log
{
	/**
	 * log(LoggerType.COST,"{0},吃饭了。叫上{0}","a","b")
	 * @author cdr
	 */	
	public class Logger implements ILogger
	{
		
		public function log(type:int, message:String, ...params):void
		{
			for (var i:int = 0; i < params.length; i++)
			{
				message = message.replace(new RegExp("\\{" + i + "\\}", "g"), params[i]);
			}
			trace(message);
		}
	}
}