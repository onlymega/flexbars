package flexbars.controls
{

import flash.display.Sprite;
import flash.text.TextField;

import flexbars.utils.BarcodeUtil;

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

public class EAN extends LinearBarcode
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
    	super.code = BarcodeUtil.computeMod10Digit(value, codeLength);
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
		if (barsSprite)
			removeChild(barsSprite);
		
		barsSprite = new Sprite();
		
		barsSprite.graphics.beginFill(0x000000);
		
		var x:int = 0;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			if ( (i & 1) == 0 )
			{
				var height:int = (guardIndices.indexOf(i) == -1) ? 64 : 69;
				barsSprite.graphics.drawRect(x, 0, bars[i], height);
			}
			
			x += bars[i];
		}
		
		barsSprite.graphics.endFill();
		
		addChild(barsSprite);
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
			textField.selectable = false;
			textField.x = group[2];
			textField.y = 60;
			
			barsSprite.addChild(textField);
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
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
	
	protected final function encodeDigit(digit:int, reverse:Boolean = false):void
	{
		if (digit < 0 || digit > 9)
			throw new ArgumentError("EAN encodeDigit digit");
		
		var encoding:Array = digitToBarEncoding[digit];
		
		if (reverse)
			encoding = encoding.concat().reverse();
		
		for each (var bar:int in encoding)
		{
			bars.push(bar);
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