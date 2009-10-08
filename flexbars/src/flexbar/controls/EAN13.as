package flexbar.controls
{

import flash.display.MovieClip;
import flash.display.Shape;

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

public class EAN13 extends EAN
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function EAN13()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private const guardPositions:Array = [0, 2, 46, 48, 92, 94];
	
	protected const leftHalfEncoding:Array = 
	[
		["A", "A", "A", "A", "A", "A"],
		["A", "A", "B", "A", "B", "B"],
		["A", "A", "B", "B", "A", "B"],
		["A", "A", "B", "B", "B", "A"],
		["A", "B", "A", "A", "B", "B"],
		["A", "B", "B", "A", "A", "B"],
		["A", "B", "B", "B", "A", "A"],
		["A", "B", "A", "B", "A", "B"],
		["A", "B", "A", "B", "B", "A"],
		["A", "B", "B", "A", "B", "A"]
	];
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
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
    
    override public function set code(value:String):void
    {
    	super.code = value;
    	
    	encode();
    	drawBars();
    }
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  computeCheckDigit
    //----------------------------------
	
	override protected function computeCheckDigit(code:String):String
	{
		if (code.length != 12 && code.length != 13)
			throw new ArgumentError("EAN13 computeCheckDigit code length");
		
		var sums:Array = [0, 0];
		
		for (var i:int = 0; i < 12; i++)
		{
			sums[i & 1] += parseInt( code.charAt(i) );
		}
		
		var sum:int = sums[0] + sums[1] * 3;
		var checkDigit:int = (10 - sum % 10) % 10;
		
		if (code.length == 12)
			return code + checkDigit;
		
		// code.length == 13
		if (parseInt( code.charAt(12) ) != checkDigit)
			throw new ArgumentError("EAN13 computeCheckDigit check digit");
		
		return code;
	}
	
    //----------------------------------
    //  encode
    //----------------------------------
	
	override protected function encode():void
	{
		bars = [];
		
		encodeNormalGuard();
		
		var firstDigit:int = parseInt( code.charAt(0) );
		var charIndex:int = 1;
		
		for each (var type:String in leftHalfEncoding[firstDigit])
		{
			encodeDigit(parseInt( code.charAt(charIndex++) ), type);
		}
		
		encodeCentralGuard();
		
		while (charIndex < 13)
		{
			encodeDigit(parseInt( code.charAt(charIndex++) ), "C");
		}
		
		encodeNormalGuard();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	protected function drawBars():void
	{
		var barsShape:Shape = new Shape();
		
		barsShape.graphics.beginFill(0x000000);
		
		var x:int = 0;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			if ( (i & 1) == 0 )
			{
				barsShape.graphics.drawRect(x, 0, bars[i], 64);
				
				if(guardPositions.indexOf(x) != -1)
					barsShape.graphics.drawRect(x, 64, bars[i], 5);
			}
			
			x += bars[i];
		}
		
		barsShape.graphics.endFill();
		
		addChild(barsShape);
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