package game.utils.timer
{
	import flash.utils.getTimer;

	/**
	 * 服务器时间模拟器
	 * @author chenshi
	 *
	 */
	public class TimeSource
	{
		private static var _instance:TimeSource = null;

		public static function getInstance():TimeSource
		{
			if (_instance == null)
			{
				_instance = new TimeSource();
			}
			return _instance;
		}

		public function TimeSource()
		{
			
		}

		private var _localStartTime:Date; //本地起始时间
		private var _localStartPlayerTime:Number;
		
		private var _serverStartTime:Date; //服务器起始时间
		
		public function flushServerTime(serverTimer:Number):void
		{
			_serverStartTime = new Date;
			_serverStartTime.setTime(serverTimer);
			
			_localStartTime = new Date();
			_localStartPlayerTime = getTimer();
		}

		/**
		 * 获得剩余时间 参数为服务器到达时间 秒数 
		 * @param time 秒数
		 * @return 秒数
		 * 
		 */		
		public function getLeavTime(time:Number):Number
		{
			var tt:Number = time - (nowDateTime.getTime() / 1000);
			return tt;
		}
		
		/**
		 * 距离最近的hour的日期，
		 * 比如传入9，当前是上午1：00， 则返回今日的9：00，
		 * 如果当前是9：00以后，则返回第2天9：00.
		 * @param hour
		 * @return 
		 * 
		 */		
		public function getDownToDate(hour:Number):Date
		{
			var addday:int = nowDateTime.hours >= hour ? 1 : 0;
			var date:Date = addDay(addday);
			
			date.hours = hour;
			date.minutes = 0;
			date.seconds = 0;
			
			return date
		}
		
		/**
		 *  距离最近的hour的时间差（秒）
		 * @param hour 0 - 23
		 * @return 
		 * 
		 */		
		public function getGap(hour:Number):Number
		{
			var date2:Date = TimeSource.getInstance().getDownToDate(hour);
			var gap:Number = (date2.valueOf() - nowDateTime.valueOf()) / 1000;
			
			return gap;
		}
		
		/**
		 * 给指定的日期增加一个天数 
		 * @param day
		 * @return 
		 * 
		 */		
		public function addDay(day:int):Date
		{
			var d:Date = new Date(nowDateTime.time);
			d['date'] += day;
			
			return d;
		}

		/**
		 * 获取本地时间 
		 * @return 
		 * 
		 */		
		public function get localStartTime():Number
		{
			return _localStartTime.getTime();
		}

		/**
		 * 所经历的 秒 数字 
		 * @return 
		 * 
		 */		
		public function get now():Number
		{
			return timeTick * 0.001;
		}

		/**
		 * 获取当前同步的服务器时间 
		 * @return 
		 * 
		 */		
		public function get nowDateTime():Date
		{
			var reDate:Date = new Date();
			reDate.setTime(serverTime);
			return reDate;
		}

		/**
		 * 获取当前同步的服务器时间的字符串格式 
		 * @return 
		 * 
		 */		
		public function get nowToString():String
		{
			return DoTimeFormat.formatDateString(nowDateTime);
		}

		/**
		 * 所经历的 毫秒秒 数字 
		 * @return 
		 * 
		 */		
		public function get timeTick():Number
		{
			return getTimer() - _localStartPlayerTime;
		}

		/**
		 * 服务器的当前毫秒 
		 * @return 
		 * 
		 */		
		public function get serverTime():Number
		{
			return _serverStartTime.getTime() + timeTick;
		}
		
		//刷新时间
		private function formatToDate(timeStr:String):Date
		{
			var arr:Array = timeStr.split(/-|:|\s/g);
			return new Date(int(arr[0]), (int(arr[1]) - 1) < 0 ? 0 : (int(arr[1]) - 1), int(arr[2]), int(arr[3]), int(arr[4]), int(arr[5]), int(arr[6]));
		}
	}
}