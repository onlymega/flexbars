package flexbar.controls
{

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

public class EAN8 extends EAN
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function EAN8()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private const guardPositions:Array = [0, 2, 32, 34, 64, 66];
	
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
		if (code.length != 7 && code.length != 8)
			throw new ArgumentError("EAN8 computeCheckDigit code length");
		
		var sums:Array = [0, 0];
		
		for (var i:int = 0; i < 7; i++)
		{
			sums[i & 1] += parseInt( code.charAt(i) );
		}
		
		var sum:int = 3 * sums[0] + sums[1];
		var checkDigit:int = (10 - sum % 10) % 10;
		
		if (code.length == 7)
			return code + checkDigit;
		
		// code.length == 8
		if (parseInt( code.charAt(7) ) != checkDigit)
			throw new ArgumentError("EAN8 computeCheckDigit check digit");
		
		return code;
	}
	
    //----------------------------------
    //  encode
    //----------------------------------
	
	override protected function encode():void
	{
		bars = [];
		
		encodeNormalGuard();
		
		var charIndex:int = 0;
		
		while (charIndex < 4)
		{
			encodeDigit(parseInt( code.charAt(charIndex++) ), "A");
		}
		
		encodeCentralGuard();
		
		while (charIndex < 8)
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
			if ((i & 1) == 0)
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