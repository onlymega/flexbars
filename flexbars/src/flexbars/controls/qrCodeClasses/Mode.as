package flexbars.controls.qrCodeClasses
{

import flash.errors.IllegalOperationError;

public final class Mode
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function Mode(indicator:int, name:String)
	{
		if (initialized)
			throw new IllegalOperationError("Static Enumeration.");
		
		this.indicator = indicator;
		this.name = name;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	public static const AUTO:Mode         = new Mode(0, "AUTO");
	public static const NUMERIC:Mode      = new Mode(1, "NUMERIC");
	public static const ALPHANUMERIC:Mode = new Mode(2, "ALPHANUMERIC");
	public static const BINARY:Mode       = new Mode(4, "BINARY");
	public static const KANJI:Mode        = new Mode(8, "KANJI");
	
    public static const MODE_REGEXP:Object = {
    	NUMERIC : /^[0-9]+$/,
    	ALPHANUMERIC : /^[A-Z0-9- $%*+.\/:]+$/,
    	BINARY : /^[\x00-\xFF]+$/,
    	KANJI : /^[\u8140-\u9FFC\uE040-\uEBBF]+$/
    };
	
	//--------------------------------------------------------------------------
	//
	//  Static Initializer
	//
	//--------------------------------------------------------------------------
	
	private static var initialized:Boolean = false;
	
	{
		initialized = true;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
    
    private var indicator:int;
    private var name:String;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
    //  getMode
    //----------------------------------
	
	public static function getMode(data:String):Mode
	{
		if(data.length == 0)
			throw new ArgumentError("Mode getMode data");
		
		if ( isMode(data, Mode.NUMERIC) )
			return Mode.NUMERIC;
		
		if ( isMode(data, Mode.ALPHANUMERIC) )
			return Mode.ALPHANUMERIC;
		
		if ( isMode(data, Mode.KANJI) )
			return Mode.KANJI;
		
		return Mode.BINARY
	}
	
	//----------------------------------
    //  isMode
    //----------------------------------
	
	public static function isMode(data:String, mode:Mode):Boolean
	{
		return RegExp( MODE_REGEXP[String(mode)] ).test(data);
	}
	
	//----------------------------------
    //  toString
    //----------------------------------
	
	public function toString():String
	{
		return name;
	}
	
	//----------------------------------
    //  valueOf
    //----------------------------------
	
	public function valueOf():int
	{
		return indicator;
	}
}

}