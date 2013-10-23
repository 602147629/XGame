package game.utils.timer
{

	public class DoTimeFormat
	{
		
		[Local(collection="timer", key="minute")]
		private static var _minute:String = "minute";
		
		[Local(collection="timer", key="second")]
		private static var _second:String = "second";
		
		public function DoTimeFormat()
		{
		}

		/**
		 * 格式化时间 (23:52:45)
		 * @param seconds int 秒
		 */
		public static function digitalTime(seconds:int):String
		{
			if (seconds < 0)
				return "0";
			var s:int = int(seconds % 60);
			var m:int = int(seconds / 60 % 60);
			var h:int = int(seconds / 60 / 60);
			return digital(h) + ":" + digital(m) + ":" + digital(s);
		}
		/**
		 * 格式化时间
		 * @param seconds
		 * @return 
		 * 
		 */		
		public static function getDateString(seconds:Number):String
		{
			var date:Date = new Date;
			date.setTime(seconds *1000);
			var dYear:String = String(date.getFullYear());
			
			var dMouth:String = String((date.getMonth() + 1 < 10) ? "0" : "") + (date.getMonth() + 1);
			
			var dDate:String =String((date.getDate() < 10) ? "0" : "") + date.getDate();
			
			var ret:String = "";
			
			ret += /*dYear + "/" +*/ dMouth + "/" + dDate +" ";
			
			ret += ((date.getHours() < 10) ? "0" : "") + date.getHours();
			
			ret += ":" +((date.getMinutes() < 10) ? "0" : "") + date.getMinutes();
			
			// 想要获取秒的话，date.getSeconds() ，语句同小时、分
			return ret;
		}
		
		
		/**
		 * 计算成多少小时（23）
		 * @param seconds int 秒
		 * 
		 */
		public static function digitalHoursTime(seconds:int):int
		{
			if (seconds < 0) return 0;
			var h:int = Math.ceil(seconds / 60 / 60);
			return h;
		}
		
		/**
		 * 计算成多少分钟（23）
		 * @param seconds int 秒
		 * 
		 */
		public static function digitalMinitueTime(seconds:int):int
		{
			if (seconds < 0) return 0;
			var m:int = Math.ceil(seconds / 60 );
			return m;
		}
		
		/**
		 *计算成还剩余多长时间  (1分钟 或者 30秒) 
		 * @param seconds
		 * @return 
		 * 
		 */
		public static function digitalLeftTime(seconds:int):String
		{
			if (seconds < 0) return "0";
			var m:int = Math.floor(seconds / 60 );
			var str:String = m + _minute;
			if(m == 0)
			{
				str = seconds + _second;
			}
			return str;
		}
		
		/**
		 * 格式化时间 (52:45)
		 * @param seconds int 秒
		 */
		public static function digitalMaxMinTime(seconds:int):String
		{
			if (seconds < 0)
				return "0";
			var s:int = int(seconds % 60);
			var m:int = int(seconds / 60 % 60);

			return digital(m) + ":" + digital(s);
		}
		
		public static function addTime(date:Date, milliseconds:Number):void
		{
			var ns:int = int(milliseconds % 1000);
			var s:int = int(milliseconds / 1000 % 60);
			var m:int = int(milliseconds / 1000 / 60 % 60);
			var h:int = int(milliseconds / 1000 / 60 / 60);
			var d:int = int(milliseconds / 1000 / 60 / 60 / 24);
			date.setHours(date.hours + h, date.minutes + m, date.seconds + s, date.milliseconds + ns);
		}

		public static function subTime(date:Date, milliseconds:int):void
		{
			var ns:int = int(milliseconds % 1000);
			var s:int = int(milliseconds / 1000 % 60);
			var m:int = int(milliseconds / 1000 / 60 % 60);
			var h:int = int(milliseconds / 1000 / 60 / 60);
			var d:int = int(milliseconds / 1000 / 60 / 60 / 24);
			date.setHours(date.hours - h, date.minutes - m, date.seconds - s, date.milliseconds - ns);

		}

		public static function getMaxDate(date:Date):int
		{
			//	[1, 2 ,3, 4 ,5 ,6 ,7 ,8 ,9 ,10,11,12]
			var maxDate:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			if ((date.getFullYear() % 400) || (date.getFullYear() % 4 == 0 && date.getFullYear() % 100 != 0)) //是闰年
				maxDate = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
			return maxDate[date.month];

		}

		public static function getTimeSpan(fromTime:Date, targetTime:Date):Number
		{
			var span:Number = Date.UTC(targetTime.fullYear, targetTime.month, targetTime.date, targetTime.hours, targetTime.minutes, targetTime.seconds, targetTime.milliseconds) - Date.UTC(fromTime.fullYear, fromTime.month, fromTime.date, fromTime.hours, fromTime.minutes, fromTime.seconds, fromTime.milliseconds);
			return span;
		}

		//将一位的数字前面加0 补足两位
		private static function digital(num:int):String
		{
			return num < 10 ? ("0" + String(num)) : String(num);
		}

		/**
		 *Convert server timer like "2009-12-9 12:32:20.234" to a Number
		 * @param serverTimer
		 * @return
		 *
		 */
		public static function ServerTimerToSecond(serverTimer:String):Number
		{

			if (null == serverTimer)
			{
				return 0;
			}
			var arr:Array = serverTimer.split(/-|:|\s/g);


			return new Date(int(arr[0]), (int(arr[1]) - 1) < 0 ? 0 : (int(arr[1]) - 1), int(arr[2]), int(arr[3]), int(arr[4]), int(arr[5]), int(arr[6])).getTime();
		}

		/**
		 * format time
		 * @param serverTime
		 * @return
		 *
		 */
		public static function formatServerTime(serverTime:String):String
		{
			var time:Number = ServerTimerToSecond(serverTime);
			time = Math.round(time / 1000);
			return digitalTime(int(time));
		}

		/**
		 *format date to  specify formatting..
		 * @param date
		 * @param type
		 * @return
		 *
		 */
		public static function formatDateString(date:Date, type:int = 0):String
		{

			var str:String

			switch (type)
			{
				case -1:
					str = date.getFullYear() + "-" + digital(date.getMonth() + 1) + "-" + digital(date.getDate());
					break;
				case 0:
					str = date.getFullYear() + "-" + digital(date.getMonth() + 1) + "-" + digital(date.getDate()) + " " + digital(date.getHours()) + ":" + digital(date.getMinutes()) + ":" + digital(date.getSeconds());
					break;
				case 1:
					str = digital(date.getMonth()) + "-" + digital(date.getDate()) + " " + digital(date.getHours()) + ":" + digital(date.getMinutes()) + ":" + digital(date.getSeconds())
					break;
				case 2:
					str = digital(date.getMonth() + 1) + "-" + digital(date.getDate()) + " " + digital(date.getHours()) + ":" + digital(date.getMinutes()) + ":" + digital(date.getSeconds())
					break
			}

			return str;
		}

		/**
		 * @param seconds
		 * 通过秒数得到时间串
		 */
		public static function getDateBySeconds(seconds:int):String
		{
			var date:Date = new Date;
			date.setTime(seconds * 1000);

			return formatDateString(date);
		}

		/**
		 * 转换为xx天xx小时xx分xx秒
		 * @param seconds
		 * @param fullFormats ["天","小时","分","秒"]
		 * @return String
		 *
		 */
		public static function getChineseFomartStr(seconds:Number, fullFormats:Array):String
		{
			if (seconds < 0)
				seconds = 0;
			var s:int = int(seconds % 60);
			var m:int = int(seconds / 60 % 60);
			var h:int = int(seconds / 60 / 60);

			var day:int = int(h / 24);
			h = int(h % 24);

			if (fullFormats.length == 4)
			{
				return day + fullFormats[0] + h + fullFormats[1] + m + fullFormats[2] + s + fullFormats[3];
			}

			return '--'
		}
		/**
		 * 
		 * @param timeStr 格式 00:00:00
		 * @return 
		 * 
		 */		
		public static function getTimeSeconds(timeStr:String):int
		{
			var arr:Array = timeStr.split(":");
			return int(arr[0])*60*60 + int(arr[1])*60 + int(arr[2]);
		}

		/**
		 *
		 * @param nSeconds
		 * @param isFullFormat 完全格式：00:00:00
		 * @return
		 *
		 */
		public static function getTimeStr(nSeconds:Number, isFullFormat:Boolean = true):String
		{
			var seconds:String = (int(nSeconds % 60)).toString();
			var minutes:String = (int(nSeconds / 60 % 60)).toString();
			var hours:String = (int(nSeconds / 60 / 60)).toString();
			var str:String;
			if (isFullFormat)
			{
				str = int(hours) == 0 ? "00" : digital(int(hours));
				str += ":";
				str += int(minutes) == 0 ? "00" : digital(int(minutes));
				str += ":";
				str += int(seconds) == 0 ? "00" : digital(int(seconds));
			}
			else
			{
				if (int(hours) == 0 && int(minutes) != 0)
				{
					str = digital(int(hours)) + ":" + digital(int(minutes)) + ":" + digital(int(seconds)); //add by wanpingping 修仙院修炼时间格式为00:00:00
				}
				else if (int(minutes) == 0 && int(hours) == 0)
				{
					str = digital(int(hours)) + ":" + digital(int(minutes)) + ":" + digital(int(seconds)); //add by wanpingping 修仙院修炼时间格式为00:00:00
				}
				else
				{
					str = digital(int(hours)) + ":" + digital(int(minutes)) + ":" + digital(int(seconds)); //add by wanpingping 修仙院修炼时间格式为00:00:00

				}
			}
			return str;
		}

		public static function getTimeDHMS(nSeconds:int):Object
		{
			if (nSeconds < 0)
			{
				nSeconds = 0
			}
			var leftSecond:int = nSeconds;
			var day:int = int(leftSecond / 60 / 60 / 24);
			leftSecond = leftSecond - day * 3600 * 24;
			var hours:int = int(leftSecond / 60 / 60);
			leftSecond = leftSecond - hours * 3600;
			var minutes:int = int(leftSecond / 60 % 60);
			leftSecond = leftSecond - minutes * 60;
			var seconds:int = int(nSeconds % 60);

			var result:Object = new Object()
			result.Day = day
			result.Hour = hours
			result.Minute = minutes
			result.Second = seconds
			return result
		}

		public static function getTimeTotal(day:int, hour:int, min:int, second:int):Number
		{
			return day * 24 * 60 * 60 + hour * 60 * 60 + min * 60 + second;
		}

		public static function getTimeFromServerTime(str:String):String
		{
			return str.substr(0, str.lastIndexOf("."))
		}

		public static function getFormatSecond(str:String):Object
		{
			var datetime:Object = new Object();
			var arr:Array = str.split(/-|:|\s/g);
			datetime.year = int(arr[0]);
			datetime.month = int(arr[1]);
			datetime.day = int(arr[2]);
			datetime.hour = int(arr[3]);
			datetime.minutinus = int(arr[4]);
			datetime.second = int(arr[5]);
			datetime.minSecond = int(arr[6]);
			return datetime;
		}
		/**
		 * 从小时开始计时 
		 * @param arr
		 * @return 
		 * 
		 */		
		public static function getSevSecendTime(arr:Array):Number
		{
			var sevD:Date = TimeSource.getInstance().nowDateTime;
			sevD.setHours(arr[0]);
			sevD.setMinutes(arr[1]);
			sevD.setSeconds(arr[2]);
			
			var second:Number = sevD.getTime()/1000;
			return second;
			
		}
		
		/**
		 * 生成年月日 时分秒生成的日期
		 * @return 
		 * 
		 */		
		public static function getAllDataTime(d:Array):Date
		{
			var sd:Date = new Date;
			sd.setFullYear(d[0])
			sd.setMonth(int(d[1]) - 1);
			sd.setDate(int(d[2]))
				
			sd.setHours(d[3]);
			sd.setMinutes(d[4]);
			sd.setSeconds(d[5]);
			
			return sd;
		}


		public static function getLastUpDate(dateTime:String):String
		{

			var time:String = (dateTime.match(/[0-9]*:/)).toString();
			var dateDay:String = (dateTime.match(/[0-9]*-[0-9]*-[0-9][0-9]/)).toString();
			dateDay = dateDay.replace(/-/g, "");
			var myDate:Object = {};
			myDate.year = int(dateDay.substr(0, 4)), myDate.month = int(dateDay.substr(4, 2)) - 1, myDate.date = int(dateDay.substr(6, 2));
			var hasDate:Boolean = true;
			var tempTime:String = "";
			if (myDate.date == 1)
			{
				if (myDate.month != 0)
					myDate.month -= 1
				else
					myDate.month = 11;
				myDate.date = 33;
				while (hasDate)
				{
					var date:Date = new Date(myDate.year, myDate.month, myDate.date);
					if (myDate.date == date.getDate())
					{
						myDate.date = date.getDate(), hasDate = false;
					}
					else
					{
						myDate.date -= 1;
					}
				}
			}
			else
			{
				myDate.date -= 1;
			}
			tempTime = myDate.year + "-" + myDate.month + "-" + myDate.date + " "
			var timeT:String = (int(time.substr(0, 2)) >= 12) ? "12:00:00" : "00:00:00";
			tempTime = tempTime + timeT
			return tempTime;
		}

		public static function cloneDate(d:Date):Date
		{
			return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getMinutes());
		}
		
		/**
		 * 获取当前时间是否为今天
		 * @param boolean
		 */
		public static function dateIsToday(seconds:Number):Boolean
		{
			if(seconds == 0) return false;
			var sData:Date = new Date(seconds * 1000);
			var s1:String = sData.fullYear+"/"+(sData.month+1)+"/"+sData.date;
			
			var s2Data:Date = new Date(TimeSource.getInstance().nowDateTime.getTime())
			var s2:String = s2Data.fullYear+"/"+(s2Data.month+1)+"/"+s2Data.date;
			
			var oneDay:Boolean = s1 == s2;
			return oneDay;
		}
		

		public static function convertDateStr(dateStr:String):String
		{
			var strArr:Array = dateStr.split(" ");
			var fStr:String = "{0} {1} {2}";
			return format(fStr, (strArr[0] as String).split("-").join("/"), strArr[1], "GMT");
		}
		
		public static function format(str:String, ...args):String
		{
			for(var i:int = 0; i<args.length; i++)
			{
				str = str.replace(new RegExp("\\{" + i + "\\}", "gm"), args[i]);
			}
			return str;
		}
	}
}