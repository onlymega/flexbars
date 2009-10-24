package flexbars.utils
{

public class BitBuffer
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function BitBuffer()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private static const zeros:String = "0000000000000000000000000000000";
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
    //----------------------------------
    //  buffer (read-only)
    //----------------------------------
	
	private var _buffer:Array /* of int */ = [];
	
	public function get buffer():Array {
		return _buffer.slice();
	}
	
    //----------------------------------
    //  length (read-only)
    //----------------------------------
	
	private var _lengthInBits:uint = 0;
		
	public function get lengthInBits():uint
	{
		return _lengthInBits;
	}
	
	//--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------
	
    //----------------------------------
    //  bitAt
    //----------------------------------

	public function bitAt(index:uint):Boolean
	{
		if (index >= lengthInBits)
			throw new ArgumentError("BitBuffer index out of bounds.");
		
		return ( (_buffer[uint(index / 32)] >>> (31 - index % 32) ) & 1) == 1;
	}
	
    //----------------------------------
    //  byteAt
    //----------------------------------

	public function byteAt(indexInBytes:uint):int
	{
		if (indexInBytes >= int(lengthInBits / 8))
			throw new ArgumentError("BitBuffer index out of bounds.");
		
		var index:int = int(indexInBytes / 4);
		var shift:int = (3 - indexInBytes % 4) * 8;
		
		return (_buffer[index] >>> shift) & 0xFF;
	}
	
    //----------------------------------
    //  pushBits
    //----------------------------------
    
	public function pushBits(bits:int, length:uint):void
	{
		while (length > 0)
		{
			length--;
			pushBit( ( (bits >>> length) & 1) == 1);
		}
	}
	
    //----------------------------------
    //  pushBit
    //----------------------------------
	
	public function pushBit(bit:Boolean):void
	{
		if (_lengthInBits == _buffer.length * 32)
			_buffer.push( new int(0) );
		
		if (bit)
			_buffer[uint(_lengthInBits / 32)] |= (0x80000000 >>> (_lengthInBits % 32));
		
		_lengthInBits++;
	}
	
    //----------------------------------
    //  toString
    //----------------------------------
	
	public function toString():String
	{
		var string:String = "";
		
		var n:int = lengthInBits;
		var i:int = 0;
		
		while (n >= 32)
		{
			var temp:String = uint(_buffer[i++]).toString(2);
			string += zeros.substr(0, 32 - temp.length) + temp;
			n -= 32;
		}
		
		if (n > 0)
		{
			temp = uint(_buffer[i] >>> (31 - n)).toString(2);
			string += zeros.substr(0, n - temp.length) + temp;
		}
		
		return string;
	}
	
}

}