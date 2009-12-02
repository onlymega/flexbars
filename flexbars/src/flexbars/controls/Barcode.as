package flexbars.controls
{

import flash.display.Sprite;
import flash.errors.IllegalOperationError;

import mx.core.UIComponent;

//--------------------------------------
//  Events
//--------------------------------------

//--------------------------------------
//  Styles
//--------------------------------------

[Style(name="barColor", type="uint", format="Color", inherit="yes")]
[Style(name="label", type="String", enumeration="yes,no", inherit="yes")]
[Style(name="quietBottom", type="uint", format="Length", inherit="yes")]
[Style(name="quietLeft", type="uint", format="Length", inherit="yes")]
[Style(name="quietRight", type="uint", format="Length", inherit="yes")]
[Style(name="quietTop", type="uint", format="Length", inherit="yes")]
[Style(name="spaceColor", type="uint", format="Color", inherit="yes")]

//--------------------------------------
//  Excluded APIs
//--------------------------------------

//--------------------------------------
//  Other metadata
//--------------------------------------

public class Barcode extends UIComponent
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function Barcode()
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
	
	protected var barsSprite:Sprite;
	
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
    	_code = value;
    	
    	encode();
    	invalidateSize();
    	invalidateDisplayList();
    }
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  updateDisplayList
    //----------------------------------
        
	override protected function updateDisplayList
		(unscaledWidth:Number, unscaledHeight:Number):void
	{
		graphics.clear();
		
		// background & quiet zones
		graphics.beginFill( getStyle("spaceColor") );
		graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
		graphics.endFill();
		
    	drawBars();
    	
    	if (barsSprite)
    	{
	    	barsSprite.x = getStyle("quietLeft");
	    	barsSprite.y = getStyle("quietTop");
    	}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  drawBars
    //----------------------------------
	
	protected function drawBars():void
	{
		throw new IllegalOperationError("Barcode drawBars unimplemented");
	}
	
    //----------------------------------
    //  encode
    //----------------------------------
	
	protected function encode():void
	{
		throw new IllegalOperationError("Barcode encode unimplemented");
	}
	
}

}