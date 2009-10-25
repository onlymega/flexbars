package flexbars.controls.qrCodeClasses
{

import flexbars.utils.BitBuffer;

public class NumericData extends QRCodeData
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function NumericData(data:String)
	{
		_data = data;
		_mode = Mode.NUMERIC;
		
		super();
	}
	
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
    	return data.length;
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
    	var i:int = 0;
    	var n:int = data.length;
    	
    	while (i + 2 < n)
    	{
    		buffer.pushBits(parseInt( data.substr(i, 3) ), 10);
    		i += 3;
    	}
    	
    	if (i + 2 == n)
    		buffer.pushBits(parseInt( data.substr(i, 2) ), 7);
    	else if (i + 1 == n)
    		buffer.pushBits(parseInt( data.substr(i, 1) ), 4);
    }
}

}