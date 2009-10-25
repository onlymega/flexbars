package flexbars.controls.qrCodeClasses
{

import flash.utils.ByteArray;

import flexbars.utils.BitBuffer;

public class BinaryData extends QRCodeData
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function BinaryData(data:String)
	{
		_data = data;
		_mode = Mode.BINARY;
		
		super();
		
		bytes.writeMultiByte(_data, "utf-8");
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
		for (var i:int = 0; i < n; i++)
		{
			buffer.pushBits(bytes[i], 8);
		}
	}
}

}