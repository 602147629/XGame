package game.WebGameConfig
{
	public class WebGameConfig
	{
		/**
		 * 解析XML
		 * @param	data	XML	XML数据
		 */
		public static function parse(data:XML):void
		{
			
		}

		/**
		 * 主机地址 
		 */
		public static function get HOST():String
		{
			return _HOST;
		}

		/**
		 * @private
		 */
		public static function set HOST(value:String):void
		{
			_HOST = value;
		}

		/**
		 * 端口号 
		 */
		public static function get PORT():uint
		{
			return _PORT;
		}

		/**
		 * @private
		 */
		public static function set PORT(value:uint):void
		{
			_PORT = value;
		}

		/**
		 * 所有可能的端口号
		 */
		public static function get PORT_LIST():Array
		{
			return _PORT_LIST;
		}

		/**
		 * @private
		 */
		public static function set PORT_LIST(value:Array):void
		{
			_PORT_LIST = value;
		}

		/**
		 * 所有可能的主机地址 
		 */
		public static function get IP_LIST():Array
		{
			return _IP_LIST;
		}

		/**
		 * @private
		 */
		public static function set IP_LIST(value:Array):void
		{
			_IP_LIST = value;
		}

		/**
		 * 所有可能的服务器组列表 
		 */
		public static function get groupList():Array
		{
			return _groupList;
		}

		/**
		 * @private
		 */
		public static function set groupList(value:Array):void
		{
			_groupList = value;
		}

		/**
		 * 主页地址 
		 */
		public static function get HOME_PAGE():String
		{
			return _HOME_PAGE;
		}

		/**
		 * @private
		 */
		public static function set HOME_PAGE(value:String):void
		{
			_HOME_PAGE = value;
		}

		/**
		 * 防沉迷认证界面URL
		 */
		public static function get AO_VALIDATE_PAGE_URL():String
		{
			return _AO_VALIDATE_PAGE_URL;
		}

		/**
		 * @private
		 */
		public static function set AO_VALIDATE_PAGE_URL(value:String):void
		{
			_AO_VALIDATE_PAGE_URL = value;
		}

		/**
		 * vip充值地址  
		 */
		public static function get vipUrl():String
		{
			return _vipUrl;
		}

		/**
		 * @private
		 */
		public static function set vipUrl(value:String):void
		{
			_vipUrl = value;
		}

		/**
		 * 玩家的注册名 
		 */
		public static function get uname():String
		{
			return _uname;
		}

		/**
		 * @private
		 */
		public static function set uname(value:String):void
		{
			_uname = value;
		}

		
		private static var _HOST:String = "127.0.0.1";
		private static var _PORT:uint = 10000;
		private static var _PORT_LIST:Array = [];
		private static var _IP_LIST:Array = [];
		private static var _groupList:Array = [];
		private static var _HOME_PAGE:String;
		private static var _AO_VALIDATE_PAGE_URL:String;
		private static var _vipUrl:String;
		private static var _uname:String;
	}
}