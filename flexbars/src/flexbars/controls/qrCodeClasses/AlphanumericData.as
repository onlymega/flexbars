package flexbars.controls.qrCodeClasses
{

import flexbars.utils.BitBuffer;

public class AlphanumericData extends QRCodeData
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function AlphanumericData(data:String)
	{
		super(this);
		_data = data;
		_mode = Mode.ALPHANUMERIC;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private static const CHARSET:String =
		"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:";
	
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
    	
    	while (i + 1 < n)
    	{
    		buffer.pushBits(getCode(i) * 45 + getCode(i+1), 11);
    		i += 2;
    	}
    	
    	if (i < n)
    		buffer.pushBits(getCode(i), 6);
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
    	var code:int = CHARSET.indexOf( data.charAt(index) );
    	
		if (code == -1)
			throw new ArgumentError("AlphanumericData encode data");
		
		return code;
    }
}

}