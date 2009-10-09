package flexbars.controls
{

import flash.display.Shape;
import flash.errors.IllegalOperationError;
import flash.text.TextField;

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

internal class EAN extends LinearBarcode
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
	
	protected var codeLength:int;
	protected var guardIndices:Array /* of int */ = null;
	protected var numberGroups:Array = null;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  code
    //----------------------------------
    
    override public function set code(value:String):void
    {
    	super.code = computeCheckDigit(value);
    }
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  drawBars
    //----------------------------------
	
	override protected function drawBars():void
	{
		var barsShape:Shape = new Shape();
		
		barsShape.graphics.beginFill(0x000000);
		
		var x:int = 11;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			if ( (i & 1) == 0 )
			{
				var height:int = (guardIndices.indexOf(i) == -1) ? 64 : 69;
				barsShape.graphics.drawRect(x, 0, bars[i], height);
			}
			
			x += bars[i];
		}
		
		barsShape.graphics.endFill();
		
		addChild(barsShape);
	}
	
    //----------------------------------
    //  drawLabel
    //----------------------------------
	
	override protected function drawLabel():void
	{
		for each (var group:Array in numberGroups)
		{
			var textField:TextField = new TextField();
			
			textField.text = code.substr(group[0], group[1]);
			textField.x = group[2];
			textField.y = 60;
			
			addChild(textField);
		}
	}
	
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
		var codeLengthWithoutKey:int = codeLength - 1;
		
		if (code.length != codeLengthWithoutKey && code.length != codeLength)
			throw new ArgumentError("EAN computeCheckDigit code length");
		
		var sums:Array = [0, 0];
		
		for (var i:int = 0; i < codeLengthWithoutKey; i++)
		{
			sums[i & 1] += parseInt( code.charAt(i) );
		}
		
		var sum:int = codeLength & 1 ? sums[0] + sums[1]*3 : sums[0]*3 + sums[1];
		
		var checkDigit:int = (10 - sum % 10) % 10;
		
		if (code.length == codeLengthWithoutKey)
			return code + checkDigit;
		
		if (parseInt( code.charAt(codeLength - 1) ) != checkDigit)
			throw new ArgumentError("EAN computeCheckDigit check digit");
		
		return code;
	}
	
    //----------------------------------
    //  encodeCentralGuard
    //----------------------------------
	
	protected function encodeCentralGuard():void
	{
		bars.push(1, 1, 1, 1, 1);
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
			{
				for each (var bar:int in digitToBarEncoding[digit])
				{
					bars.push(bar);
				}
				break;
			}
			case "B":
			{
				for (var i:int = 3; i >= 0; i--)
				{
					bars.push(digitToBarEncoding[digit][i]);
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
    //  encodeNormalGuard
    //----------------------------------
	
	protected function encodeNormalGuard():void
	{
		bars.push(1, 1, 1);
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