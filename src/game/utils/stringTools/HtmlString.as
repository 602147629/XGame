package game.utils.stringTools
{
	public class HtmlString
	{
		/**
		 *返回添加颜色的html字符串 
		 * @param str
		 * @param color 颜色值是16进制的
		 * @return 
		 * 
		 */		
		public static function getColorStr(str:String,color:uint):String
		{
			return "<font color=" + getHtmlColor(color)+">"+str + "</font>";
		}
		
		private static function getHtmlColor(color:uint):String
		{
			var colorStr:String = color.toString(16);
			return "'#"+colorStr+"'";
		}
		/**
		 * 返回指定字号大小的html字符串
		 * @param str
		 * @param size
		 * @return 
		 * 
		 */		
		public static function getSizeStr(str:String,size:int):String
		{
			return "<font size='" + size+"'>"+str + "</font>"
		}
		
		public static function getUnderLineStr(str:String):String
		{
			return "<u>"+str+"</u>";
		}
		
		public static function getEventText(str:String,eventStr:String):String
		{
			return "<a href = \"event:"+ eventStr +"\"/>"+getUnderLineStr(str)+"</a>";
		}
		
		/**
		 * 格式化html字符串 
		 * @param sourceString
		 * @return 
		 * 
		 */		
		public static function formatStringToHtmlTxt(sourceString:String):String
		{
			var resultStr:String = StringTool.replace(sourceString, "[", "<");
			resultStr  = StringTool.replace(resultStr, "]", ">");
			resultStr = StringTool.replace(resultStr, "||", "");
			resultStr  = StringTool.replace(resultStr, "^", "\"");
			resultStr  = StringTool.replace(resultStr, "{", "[");
			resultStr  = StringTool.replace(resultStr, "}", "]");
			resultStr  = StringTool.replace(resultStr, "@#", "");
			
			return resultStr;
		}
		
		/**
		 * 设置变量 
		 * @param valueStr
		 * @param variableStr
		 * @return 
		 * 
		 */		
		public static function setHtmlTextValue(sourceStr:String, valueStr:String, variableStr:String):String
		{
			var resultStr:String = "";
			if(null != sourceStr)
			{
				resultStr = sourceStr.replace(variableStr, valueStr);
			}
			
			return resultStr;
		}	
		
		/**
		 * 数字超长格式化显示 
		 * @param sourceCount
		 * @return 
		 * 
		 */		
		public static function countLenghtFormat(sourceCount:Number):String
		{
			var resultStr:String = sourceCount.toString();
			if(sourceCount > 999)
			{
				resultStr = 999 + "+";
			}
			return resultStr;
		}
	}
}