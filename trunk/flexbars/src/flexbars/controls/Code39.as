package flexbars.controls
{

import flash.display.Sprite;
import flash.text.TextField;

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

public class Code39 extends LinearBarcode
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function Code39()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	protected const charset:String =
		"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%";
	
	private const characterToBarEncoding:Array = 
	[
		[1, 1, 1, 2, 2, 1, 2, 1, 1, 1],
		[2, 1, 1, 2, 1, 1, 1, 1, 2, 1],
		[1, 1, 2, 2, 1, 1, 1, 1, 2, 1],
		[2, 1, 2, 2, 1, 1, 1, 1, 1, 1],
		[1, 1, 1, 2, 2, 1, 1, 1, 2, 1],
		[2, 1, 1, 2, 2, 1, 1, 1, 1, 1],
		[1, 1, 2, 2, 2, 1, 1, 1, 1, 1],
		[1, 1, 1, 2, 1, 1, 2, 1, 2, 1],
		[2, 1, 1, 2, 1, 1, 2, 1, 1, 1],
		[1, 1, 2, 2, 1, 1, 2, 1, 1, 1],
		[2, 1, 1, 1, 1, 2, 1, 1, 2, 1],
		[1, 1, 2, 1, 1, 2, 1, 1, 2, 1],
		[2, 1, 2, 1, 1, 2, 1, 1, 1, 1],
		[1, 1, 1, 1, 2, 2, 1, 1, 2, 1],
		[2, 1, 1, 1, 2, 2, 1, 1, 1, 1],
		[1, 1, 2, 1, 2, 2, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 2, 2, 1, 2, 1],
		[2, 1, 1, 1, 1, 2, 2, 1, 1, 1],
		[1, 1, 2, 1, 1, 2, 2, 1, 1, 1],
		[1, 1, 1, 1, 2, 2, 2, 1, 1, 1],
		[2, 1, 1, 1, 1, 1, 1, 2, 2, 1],
		[1, 1, 2, 1, 1, 1, 1, 2, 2, 1],
		[2, 1, 2, 1, 1, 1, 1, 2, 1, 1],
		[1, 1, 1, 1, 2, 1, 1, 2, 2, 1],
		[2, 1, 1, 1, 2, 1, 1, 2, 1, 1],
		[1, 1, 2, 1, 2, 1, 1, 2, 1, 1],
		[1, 1, 1, 1, 1, 1, 2, 2, 2, 1],
		[2, 1, 1, 1, 1, 1, 2, 2, 1, 1],
		[1, 1, 2, 1, 1, 1, 2, 2, 1, 1],
		[1, 1, 1, 1, 2, 1, 2, 2, 1, 1],
		[2, 2, 1, 1, 1, 1, 1, 1, 2, 1],
		[1, 2, 2, 1, 1, 1, 1, 1, 2, 1],
		[2, 2, 2, 1, 1, 1, 1, 1, 1, 1],
		[1, 2, 1, 1, 2, 1, 1, 1, 2, 1],
		[2, 2, 1, 1, 2, 1, 1, 1, 1, 1],
		[1, 2, 2, 1, 2, 1, 1, 1, 1, 1],
		[1, 2, 1, 1, 1, 1, 2, 1, 2, 1],
		[2, 2, 1, 1, 1, 1, 2, 1, 1, 1],
		[1, 2, 2, 1, 1, 1, 2, 1, 1, 1],
		[1, 2, 1, 2, 1, 2, 1, 1, 1, 1],
		[1, 2, 1, 2, 1, 1, 1, 2, 1, 1],
		[1, 2, 1, 1, 1, 2, 1, 2, 1, 1],
		[1, 1, 1, 2, 1, 2, 1, 2, 1, 1]
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
    //  encode
    //----------------------------------
	
	override protected function encode():void
	{
		bars = [];
		
		// start sequence
		encodeStar();
		
		var n:int = code.length;
		for (var i:int = 0; i < n; i ++)
		{
			encodeCharacter( code.charAt(i) );
		}
		
		// end sequence
		encodeStar()
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  encodeCharacter
    //----------------------------------
	
	protected function encodeCharacter(character:String):void
	{
		if (character == "*")
			return encodeStar();
		
		var characterIndex:int = charset.indexOf(character);
		
		if (characterIndex == -1)
			throw new ArgumentError("Code39 encodeCharacter char");
		
		var encoding:Array = characterToBarEncoding[characterIndex];
		
		for each (var bar:int in encoding)
		{
			bars.push(bar);
		}
	}
	
    //----------------------------------
    //  encodeStar
    //----------------------------------
	
	protected function encodeStar():void
	{
		bars.push(1, 2, 1, 1, 2, 1, 2, 1, 1, 1);
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