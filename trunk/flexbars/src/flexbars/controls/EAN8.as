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
		
		codeLength = 8;
		guardIndices = [0, 2, 20, 22, 40, 42];
		numberGroups =
		[
			[0, 4, 14],
			[4, 4, 47]
		];
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
    //  encode
    //----------------------------------
	
	override protected function encode():void
	{
		bars = [];
		
		encodeNormalGuard();
		
		var charIndex:int = 0;
		
		while (charIndex < 8)
		{
			encodeDigit( parseInt( code.charAt(charIndex++) ) );
			
			if (charIndex == 4)
				encodeCentralGuard();
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