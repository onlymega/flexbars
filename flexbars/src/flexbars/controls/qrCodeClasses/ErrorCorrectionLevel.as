package flexbars.controls.qrCodeClasses
{

import flash.errors.IllegalOperationError;

public final class ErrorCorrectionLevel
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function ErrorCorrectionLevel(indicator:int, name:String)
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
	
	public static const L:ErrorCorrectionLevel = new ErrorCorrectionLevel(1, "L");
	public static const M:ErrorCorrectionLevel = new ErrorCorrectionLevel(0, "M");
	public static const Q:ErrorCorrectionLevel = new ErrorCorrectionLevel(3, "Q");
	public static const H:ErrorCorrectionLevel = new ErrorCorrectionLevel(2, "H");
	
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