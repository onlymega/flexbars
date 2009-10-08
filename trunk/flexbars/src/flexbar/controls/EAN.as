package flexbar.controls
{

import flash.errors.IllegalOperationError;

import mx.core.UIComponent;

//--------------------------------------
//  Events
//--------------------------------------

//--------------------------------------
//  Styles
//--------------------------------------

//--------------------------------------
//  Excluded APIs
//--------------------------------------

//--------------------------------------
//  Other metadata
//--------------------------------------

internal class EAN extends UIComponent
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function EAN()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	protected const digitToBarEncoding:Array = 
	[
		[3, 2, 1, 1],
		[2, 2, 2, 1],
		[2, 1, 2, 2],
		[1, 4, 1, 1],
		[1, 1, 3, 2],
		[1, 2, 3, 1],
		[1, 1, 1, 4],
		[1, 3, 1, 2],
		[1, 2, 1, 3],
		[3, 1, 1, 2]
	];
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	protected var bars:Array /* of int */;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  code
    //----------------------------------
    
    private var _code:String;
    
    public function get code():String
    {
    	return _code;
    }
    
    public function set code(value:String):void
    {
    	_code = computeCheckDigit(value);
    }
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  computeCheckDigit
    //----------------------------------
	
	protected function computeCheckDigit(code:String):String
	{
		throw new IllegalOperationError("EAN computeCheckDigit");
	}
	
    //----------------------------------
    //  encode
    //----------------------------------
	
	protected function encode():void
	{
		throw new IllegalOperationError("EAN encode");
	}
	
    //----------------------------------
    //  encodeNormalGuard
    //----------------------------------
	
	protected function encodeNormalGuard():void
	{
		bars.push(1, 1, 1);
	}
	
    //----------------------------------
    //  encodeDigit
    //----------------------------------
	
	protected final function encodeDigit(digit:int, type:String):void
	{
		if (digit < 0 || digit > 9)
			throw new ArgumentError("EAN encodeDigit digit");
		
		switch(type)
		{
			case "A":
			case "C":
			{
				for each (var b:int in digitToBarEncoding[digit])
				{
					bars.push(b);
				}
				break;
			}
			case "B":
			{
				for (var i:int = 3; i >= 0; i--)
				{
					bars.push( digitToBarEncoding[digit][i] );
				}
				break;
			}
			default:
			{
				throw new ArgumentError("EAN encodeDigit type");
			}
		}
	}
	
    //----------------------------------
    //  encodeCentralGuard
    //----------------------------------
	
	protected function encodeCentralGuard():void
	{
		bars.push(1, 1, 1, 1, 1);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden event handlers
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Event handlers
	//
	//--------------------------------------------------------------------------
	
}

}