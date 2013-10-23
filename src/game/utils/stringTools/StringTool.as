package game.utils.stringTools
{
	import flash.text.TextField;
	import flash.utils.ByteArray;

	/**
	 * 字符串工具
	 * @author songdu
	 *
	 */
	public class StringTool
	{
		/**
		 * 中文全角字符的空格
		 */
		private static const FULL_WIDTH_BLANK_CHAR:String = String.fromCharCode(12288);
		/**
		 * 半角的空格字符
		 */
		private static const HALF_WIDTH_BLANK_CHAR:String = " ";
		
		private static var _tempText:TextField = new TextField;
		
		/**
		 * 将 类似 aaa{0}bbb{1} 类型的字符串根据 params 数组格式化.
		 * @param content 原字符串
		 * @param params 参数
		 * @return 格式化后的字符串
		 *
		 */
		public static function formatParams(content:String, ... params):String
		{
			if (params.length)
			{
				for (var i:int = 0; i < params.length; i++)
				{
					content = content.replace(new RegExp("\\{" + i + "\\}", "g"), params[i]);
				}
			}

			return content;
		}

		public static function replace(s:String, o:String, n:String):String
		{
			//字符替换函数 把s中o替换成n 
			return s = s.split(o).join(n);
		}
		/**
		 * 整合textField，长于 width 的部分用 ... 号表示 
		 * @param textField 目标textField
		 * @param dotString 用于省略的String
		 * @param width 指定宽度
		 * 
		 */		
		public static function layoutTextWidth(textField:TextField, dotString:String = "...", width:Number = NaN):void
		{
			var text:String = textField.text;
			var clipText:String = text;
			var tempTextField:TextField = new TextField();
			tempTextField.defaultTextFormat = textField.defaultTextFormat;
			tempTextField.text = dotString;
			var dotWidth:int = tempTextField.textWidth;
			tempTextField.text = text;
			width = isNaN(width) ? textField.width : width;
			var w:Number = tempTextField.textWidth;
			if (w > width)
			{
				var index:int = tempTextField.getCharIndexAtPoint(width - dotWidth, 10);
				textField.text = text.substr(0, index) + dotString;
			}
		}
		/**
		 * 字符替换只要用于提示信息的%s替换 (任务)
		 * @param desStr 原字符串
		 * @param conStr 所替换的内容
		 */		
		public static function StrReplace_s( desStr:String, conStr:String ):String
		{
			var str:String = desStr;
			if( null == str || str.length <= 0 )
				return str;
			
			var rep:RegExp = /%s/i;
			str = str.replace( rep, conStr );
			return str;
		}
		
		/**
		 * 过滤HTML标签
		 * @param html
		 * @return
		 *
		 */
		public static function filterHtmlTag(html:String):String
		{
			_tempText.htmlText = html;
			return _tempText.text;
		}
		
		/**
		 * 去掉空格
		 * @param myString
		 * @return
		 *
		 */
		public static function trim(myString:String):String
		{ //过滤前后空格 
			if (myString.indexOf(HALF_WIDTH_BLANK_CHAR) == -1 && myString.indexOf(FULL_WIDTH_BLANK_CHAR) == -1)
			{ //如果字符串内没有空格直接返回 
				return myString;
			}
			var omyString:String = myString; //把原始字符串保存下来 
			myString = replace(myString, FULL_WIDTH_BLANK_CHAR, HALF_WIDTH_BLANK_CHAR); //把全角空格替换成普通空格，方便处理 
			var lblanknum:Number = 0; //开始位置的空格数量 
			var rblanknum:Number = 0; //结束位置的空格数量 
			//计算开始位置的空格数量 
			for (var i:Number = 0; i < myString.length; i++)
			{
				if (myString.charAt(i) != HALF_WIDTH_BLANK_CHAR)
				{
					break;
				}
				else
				{
					lblanknum++;
				}
			}
			//计算结束位置的空格数量 
			for (i = (myString.length - 1); i > 0; i--)
			{
				if (myString.charAt(i) != HALF_WIDTH_BLANK_CHAR)
				{
					break;
				}
				else
				{
					rblanknum++;
				}
			}
			return omyString.substring(lblanknum, omyString.length - rblanknum);
		}
		
		public static function replace(s:String, o:String, n:String):String
		{
			//字符替换函数 把s中o替换成n 
			return s = s.split(o).join(n);
		}
		
		/**
		 * 替换 sourceStr中的变量
		 * @param sourceStr
		 * @param variableStr
		 * @param value
		 * @return
		 *
		 */
		public static function replaceAllVariable(sourceStr:String, variableStr:String, value:String):String
		{
			var reg:RegExp = new RegExp(variableStr, "g");
			sourceStr = sourceStr.replace(reg, value);
			return sourceStr;
		}
		
		
		//去掉字符串所有空格
		public static function trimStrAllSpace(str:String):String
		{
			var regex:RegExp = /\s/g;
			var resStr:String = str.replace(regex, "")
			return resStr;
		}
		
		//检查出字符长度
		public static function checkOutStringNum(str:String):int
		{
			var strLen:int = 0;
			var myString:String = str;
			for (var i:int = 0; i < myString.length; i++)
			{
				var a:uint = myString.charCodeAt(i);
				var myString2:String = myString.charAt(i);
				if ((a >= 32) && (a <= 126))
					strLen += 1
				else
					strLen += 2
			}
			return strLen;
		}
		
		/**
		 * 过滤特殊字符
		 * @param inputStr
		 * @return
		 *
		 */
		public static function filtecharacter(inputStr:String):Boolean
		{
			var regExp:RegExp = /[\`\~\!\！\……\￥\@\#\$\%\^\&\*\(\)\+\\\]\[\}\{\'\;\:\"\/\.\,\>\<\]\s\|\=\-\?]/g;
			return regExp.test(inputStr);
		}
		
		/**
		 * 获取文本的字节长度
		 * @param value
		 * @return
		 *
		 */
		public static function checkStringByteLength(value:String):int
		{
			if (value == null || value == "")
				return 0;
			var temp:ByteArray = new ByteArray;
			temp.writeMultiByte(value, "gb2312");
			return temp.length;
		}
		
		/**
		 * 截取指定长度字节的字符窜
		 * @param src
		 * @param len
		 * @return
		 *
		 */
		public static function substrByByteLength(src:String, len:uint):String
		{
			var byte:ByteArray = new ByteArray;
			byte.writeMultiByte(src, "gb2312");
			if (byte.length > len)
			{
				byte.position = 0;
				src = byte.readMultiByte(len, "gb2312");
			}
			return src;
		}
		
		/**
		 *分隔字数串 (如:1,000,000 )
		 * @param str 需要分割的字符串
		 * @param len 每多少个字分割. 
		 * @return 返回格式化后的string
		 * 
		 */		
		public static function spiltStr(str:String, len:int):String
		{
			if (str.length <= len)
			{
				return str;
			}
			var str1:String="";
			var strArr:Array=new Array;
			var index1:int=str.length % len;
			var strLen:int=str.length / len;
			for (var i:int=0; i < strLen; i++)
			{
				str1=str.substring(str.length - len * (i + 1), str.length - len * (i));
				if (str1)
				{
					strArr.push(str1);
					if (i < strLen - 1)
						strArr.push(",");
				}
			}
			if (index1 != 0)
			{
				strArr.push(",");
				str1=str.substring(0, index1);
				strArr.push(str1);
			}
			else
			{
				str1=str.substring(0, index1);
			}
			var str2:String="";
			for (var j:int=strArr.length - 1; j >= 0; j--)
			{
				str2+=strArr[j];
			}
			
			return str2;
		}
		/**
		 *带逗号分割的数字类型字符串(1000,000).
		 * 注意,一定是数字.没做特殊处理也没有遍历处理是英文字符还是汉子.
		 * 只做了数字的,如果字符串中包含除数字外的其他字符.
		 * 可能返回数值不正确,或者是0; 
		 * @param str 需要转换的字符串
		 * @return  注意返回的是uint类型;
		 * 
		 */		
		public static function stringToUint( str:String ):uint
		{
			var str:String = str;
			var myPattern:RegExp = /,/g;
			str = str.replace(myPattern, ""); 
			var val:uint = uint( str );
			return val;
		}
		/**
		 *格式化时间  月"日"时"分"
		 * @param str
		 * @return 
		 * 
		 */		
		public static function setTime(  str:String ):String
		{
			var str1:String = str;
			var arr:Array = [];
			var i:int = 0;
			for( i = 0; i<3; ++i )
			{
				arr[i] = str1.substr( str1.length - 2, str1.length );
				str1 = str1.slice( 0, str1.length -2 );
			}
			arr[i] = str1;
			var s0:String = "";
			s0 = arr[3] +"-"+ arr[2]  + " " + arr[1]  + ":" + arr[0] ;
			return s0;
		}
		/**
		 *秒单位的格式化 返回格式3:30:05; 
		 * @param time 以秒为单位的数值
		 * @return 格式化后的字符串
		 * 
		 */		
		public static function secondToTimer( time:uint ):String
		{
			var curtime:uint =time%3600%60;
			var hour:int = time / 3600;
			var format:String = "00:00:00";
			var minute:int = int( time%3600/60 );
			var minute_s:String = (minute < 10) ? ("0"+minute) : minute.toString();
			var second:int =curtime % (60);
			var second_s:String = (second < 10) ? ("0"+second) : second.toString();
			if ( hour <= 0 )
			{
				format = minute_s + ":" + second_s;
			}
			else
			{
				format = hour + ":" + minute_s + ":" + second_s;
			}
			return format;
		}
		/**
		 *格式化时间 
		 * 返回单个单位的字符串, 比如满一天就返回1天
		 */		
		public static function stringToTime( time:uint, size:Number = 0.001 ):String
		{
			var curtime:uint = time*size;
			
			var hour:int = curtime / 3600;
			var day:int = hour / 3600/24;
			if( day > 0 )
			{
				return day+"天";
			}
			if( hour > 0 )
			{
				return hour+"小时";
			}
			var minute:int = int( curtime%3600/60 );
			if( minute > 0 )
			{
				return minute+"分";
			}
			var second:int = curtime % (60);
			if( second > 0 )
			{
				return second+"秒";
			}
			return "0";
		}
		/**
		 * 字符替换只要用于提示信息的%s/%d替换,如果返回是空可能是填写的类型不对
		 * @param desStr 原字符串
		 * @param conStr的数组 所替换的内容
		 */		
		public static function forEachStrReplace( desStr:String, conStrArr:Array):String
		{
			var str:String = desStr;
			if( null == str || str.length <= 0 || null == conStrArr)
				return str;
			var rep:RegExp = /%s/i;
			for(var i:int =0; i<conStrArr.length; ++i)
			{
				str = str.replace( rep, conStrArr[i].toString() );
			}
			
			return str;
		}
		/**
		 * 字符替换只要用于提示信息的%s替换 (任务)
		 * @param desStr 原字符串
		 * @param conStr 所替换的内容
		 */		
		public static function StrReplace_s( desStr:String, conStr:String ):String
		{
			var str:String = desStr;
			if( null == str || str.length <= 0 )
				return str;
			
			var rep:RegExp = /%s/i;
			str = str.replace( rep, conStr );
			return str;
		}
		
		/**
		 *解析 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function disassemblelink( str:String ):Array
		{
			return  str.split("|");
		}
		
		public static function numStrToArray(str:String):Array
		{
			return str.split('');
		}
	}
}