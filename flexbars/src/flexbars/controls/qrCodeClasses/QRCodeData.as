package flexbars.controls.qrCodeClasses
{

import flash.errors.IllegalOperationError;

import flexbars.utils.BitBuffer;

public class QRCodeData
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function QRCodeData()
	{
		if (_data == null || _mode == null)
			throw new IllegalOperationError("QRCodeData is abstract.");
		
		if (Mode.getMode(_data) != _mode)
			throw new ArgumentError("QRCodeData invalid data.");
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
    
    private static const LENGTH_IN_BITS:Object = {
    	_1_9: {
    		NUMERIC: 10,
    		ALPHANUMERIC: 9,
    		BINARY: 8,
    		KANJI: 8
    	},
    	_10_26: {
    		NUMERIC: 12,
    		ALPHANUMERIC: 11,
    		BINARY: 16,
    		KANJI: 10
    	},
    	_27_40: {
    		NUMERIC: 14,
    		ALPHANUMERIC: 13,
    		BINARY: 16,
    		KANJI: 12
    	}
    };
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  data (read-only)
    //----------------------------------
    
    protected var _data:String;
    
    public function get data():String
    {
    	return _data;
    }
	
    //----------------------------------
    //  length (read-only)
    //----------------------------------
    
    public function get length():int
    {
    	throw new IllegalOperationError("QRCodeData length not implemented.");
    }
	
    //----------------------------------
    //  mode (read-only)
    //----------------------------------
    
    protected var _mode:Mode = null;
    
    public function get mode():Mode
    {
    	return _mode;
    }
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
    //  encode
    //----------------------------------
    	
	public function encode(buffer:BitBuffer):void
	{
    	throw new IllegalOperationError("QRCodeData encode not implemented.");
	}
	
	//----------------------------------
    //  getLengthInBits
    //----------------------------------
    
    public function getLengthInBits(version:int):int
    {
    	try
    	{
    		if(version >= 1 && version <= 9)
    			return LENGTH_IN_BITS._1_9[String(_mode)];
    		
    		if(version >= 10 && version <= 26)
    			return LENGTH_IN_BITS._10_26[String(_mode)];
    		
    		if(version >= 27 && version <= 40)
    			return LENGTH_IN_BITS._27_40[String(_mode)];
    	}
    	catch(e:Error)
    	{
    		throw new Error("QRCodeData getLengthInBits unsupported mode.");
    	}
    	
    	throw new ArgumentError("QRCodeData getLengthInBits version.");
    }
}

}