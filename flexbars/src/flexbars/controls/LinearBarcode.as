package flexbars.controls
{

import flash.display.Shape;
import flash.errors.IllegalOperationError;

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
    	drawBars();
    	drawLabel();
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
    //  drawBars
    //----------------------------------
	
	protected function drawBars():void
	{
		var barsShape:Shape = new Shape();
		
		barsShape.graphics.beginFill(0x000000);
		
		var x:int = 11;
		var n:int = bars.length;
		for (var i:int = 0; i < n; i++)
		{
			if ( (i & 1) == 0 )
				barsShape.graphics.drawRect(x, 0, bars[i], 40);
			
			x += bars[i];
		}
		
		barsShape.graphics.endFill();
		
		addChild(barsShape);
	}
	
    //----------------------------------
    //  drawLabel
    //----------------------------------
	
	protected function drawLabel():void
	{
		throw new IllegalOperationError("LinearBarcode drawLabel");
	}
	
    //----------------------------------
    //  encode
    //----------------------------------
	
	protected function encode():void
	{
		throw new IllegalOperationError("LinearBarcode encode");
	}
}

}