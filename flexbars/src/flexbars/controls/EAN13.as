package flexbars.controls
{

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
		
		codeLength = 13;
		guardIndices = [0, 2, 28, 30, 56, 58];
		numberGroups =
		[
			[0, 1, -9],
			[1, 6,  4],
			[7, 6, 51]
		];
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	protected const leftHalfEncoding:Array = 
	[
		[false, false, false, false, false, false],
		[false, false, true, false, true, true],
		[false, false, true, true, false, true],
		[false, false, true, true, true, false],
		[false, true, false, false, true, true],
		[false, true, true, false, false, true],
		[false, true, true, true, false, false],
		[false, true, false, true, false, true],
		[false, true, false, true, true, false],
		[false, true, true, false, true, false],
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
		super.drawBars();
		
		barsSprite.x = 9;
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
		
		for each (var reverse:Boolean in leftHalfEncoding[firstDigit])
		{
			encodeDigit(parseInt( code.charAt(charIndex++) ), reverse);
		}
		
		encodeCentralGuard();
		
		while (charIndex < 13)
		{
			encodeDigit( parseInt( code.charAt(charIndex++) ) );
		}
		
		encodeNormalGuard();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
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