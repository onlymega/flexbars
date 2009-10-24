package flexbars.controls
{

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

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

[IconFile("LinearBarcode.png")]

internal class LinearBarcode extends Barcode
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function LinearBarcode()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
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
	
	//----------------------------------
	//  code
	//----------------------------------
	
	override public function set code(value:String):void
	{
		super.code = value;
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
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  drawBars
    //----------------------------------
	
	override protected function drawBars():void
	{
		if (!bars)
			return;
		
		if (barsSprite)
			removeChild(barsSprite);
		
		barsSprite = new Sprite();
		
		barsSprite.graphics.beginFill(0x000000);
		
		var x:int = 0;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			if ( (i & 1) == 0 )
				barsSprite.graphics.drawRect(x, 0, bars[i], 40);
			
			x += bars[i];
		}
		
		barsSprite.graphics.endFill();
		
		addChild(barsSprite);
		
		drawLabel();
	}
	
    //----------------------------------
    //  drawLabel
    //----------------------------------
	
	protected function drawLabel():void
	{
		var textField:TextField = new TextField();
		
		textField.text = code;
		textField.selectable = false;
		textField.x = 0;
		textField.y = 36;
		
		var width:int = 0;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			width += bars[i];
		}
		
		textField.width = width;
		textField.autoSize = TextFieldAutoSize.CENTER;
		
		barsSprite.addChild(textField);
	}
}

}