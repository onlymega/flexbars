package flexbars.controls
{

import flash.display.Sprite;

//--------------------------------------
//  Events
//--------------------------------------

//--------------------------------------
//  Styles
//--------------------------------------

//--------------------------------------
//  Excluded APIs
//--------------------------------------

// excule [Style(name="label", type="String", enumeration="yes,no", inherit="yes")]

//--------------------------------------
//  Other metadata
//--------------------------------------

public class MatrixBarcode extends Barcode
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function MatrixBarcode()
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
	
	protected var matrix:Array /* Boolean[][] */;
	
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
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  measure
    //----------------------------------
	
	override protected function measure():void
    {
    	if (!matrix)
    		return super.measure();
    	
    	var width:int = matrix.length;
    	var height:int = matrix[0].length;
    	
    	width  += getStyle("quietLeft") + getStyle("quietRight");
    	height += getStyle("quietTop") + getStyle("quietBottom");
    	
        measuredMinWidth = width;
        measuredMinHeight = height;
        measuredWidth = width;
        measuredHeight = height;
    }
	
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
		if (!matrix)
			return;
		
		if (barsSprite)
			removeChild(barsSprite);
		
		barsSprite = new Sprite();
		
		barsSprite.graphics.beginFill( getStyle("barColor") );
		
		var m:int = matrix.length;
		for (var x:int = 0; x < m; x++)
		{
			var n:int = matrix[x].length;
			for (var y:int = 0; y < n; y++)
			{
				if ( matrix[x][y] )
					barsSprite.graphics.drawRect(x, y, 1, 1);
			}
		}
		
		barsSprite.graphics.endFill();
		
		addChild(barsSprite);
	}
	
	//----------------------------------
    //  initializeMatrix
    //----------------------------------
	
	protected function initializeMatrix(width:int, height:int):void
	{
		if (width <= 0 || height <= 0)
			throw new ArgumentError("MatrixBarcode initializeMatrix size");
		
		matrix = new Array(width);
		
		for(var i:int = 0; i < width; i++)
		{
			matrix[i] = new Array(height);
		}
	}
}

}