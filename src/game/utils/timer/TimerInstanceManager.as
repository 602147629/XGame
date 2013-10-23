package game.utils.timer
{
	import flash.utils.Timer;

	/**
	 * 系统计时器 
	 * @author chendong
	 * 
	 */	
	public class TimerInstanceManager
	{
		public static function getInstance():TimerInstanceManager
		{
			if(!_instance)
				_instance = new TimerInstanceManager;
			return _instance;
		}
		
		public function setCommonTimer(delay:Number=1000,repeatCount:int=0):void
		{
			if(!_commonTimer)
				_commonTimer = new Timer(delay,repeatCount);
		}
		
		public function commonTimerStart():void
		{
			_commonTimer.start();
		}
		
		public function commonTimerStop():void
		{
			_commonTimer.reset();
		}
		
		public function get commonTimer():Timer
		{
			return _commonTimer;
		}
		
		
		public function setAnswersTimer(delay:Number=1000,repeatCount:int=0):void
		{
			if(!_answersTimer)
				_answersTimer = new Timer(delay,repeatCount);
		}
		
		public function answersTimerStart():void
		{
			_answersTimer.start();
		}
		
		public function answersTimerStop():void
		{
			_answersTimer.reset();
		}
		
		public function get answersTimer():Timer
		{
			return _answersTimer;
		}

		public function set delay(value:Number):void
		{
			_delay = value;
		}

		public function set repeatCount(value:int):void
		{
			_repeatCount = value;
		}

		private static var _instance:TimerInstanceManager;
		private var _answersTimer:Timer;
		private var _commonTimer:Timer;
		
		private var _delay:Number = 1000;
		private var _repeatCount:int = 0;
	}
}