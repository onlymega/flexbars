package flexbars.controls.qrCodeClasses
{

import flash.utils.ByteArray;

import flexbars.utils.BitBuffer;

public class KanjiData extends QRCodeData
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function KanjiData(data:String)
	{
		_data = data;
		_mode = Mode.KANJI;
		
		super();
		
		bytes.writeMultiByte(_data, "shift_jis");
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var bytes:ByteArray = new ByteArray();
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  length (read-only)
	//----------------------------------
	
	override public function get length():int
	{
		return bytes.length;
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  encode
	//----------------------------------
	
	override public function encode(buffer:BitBuffer):void
	{
		var n:int = bytes.length;
		for (var i:int = 0; i + 1 < n; i += 2)
		{
			buffer.pushBits(getCode(i), 13);
		}
		
		if (i < n)
			throw new ArgumentError("KanjiData encode data");
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  getCode
    //----------------------------------
    
    private function getCode(index:int):int
    {
		var code:int;
		var character:int = (bytes[index] << 8) | bytes[index + 1];
		
		if (character >= 0x8140 && character <= 0x9FFC)
			code = character - 0x8140;
		else if (character >= 0xE040 && character <= 0xEBBF)
			code = character - 0xC140;
		else
			throw new ArgumentError("KanjiData getCode data");
		
		code = ((code >> 8) & 0xFF) * 0xC0 + (code & 0xFF);
		
		return code;
    }
}

}