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

//--------------------------------------
//  Excluded APIs
//--------------------------------------

//--------------------------------------
//  Other metadata
//--------------------------------------

internal class Barcode extends UIComponent
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
		
		// background
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
		graphics.endFill();
		
    	drawBars();
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