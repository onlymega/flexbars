package flexbars.controls.qrCodeClasses
{

import flexbars.controls.qrCodeClasses.gexp;
import flexbars.controls.qrCodeClasses.glog;

public class Polynomial
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	public function Polynomial(numbers:Array /* of int */, shift:int = 0)
	{
		var offset:int = 0;
		
		var n:int = numbers.length;
		while (offset < n && numbers[offset] == 0)
		{
			offset++;
		}

		this.numbers = new Array(numbers.length - offset + shift);
		
		n = numbers.length - offset;
		for (var i:int = 0; i < n; i++, offset++)
		{
		    this.numbers[i] = numbers[offset];
		}
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var numbers:Array /* of int */;
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  length (read-only)
	//----------------------------------
	
	public function get length():int
	{
		return numbers.length;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  getErrorCorrectionPolynomial
	//----------------------------------
	
	public static function getErrorCorrectionPolynomial(length:int):Polynomial
	{
		var p:Polynomial = new Polynomial( [1] );
		
		for (var i:int = 0; i < length; i++)
		{
			p = p.multiply( new Polynomial( [1, gexp(i)] ) );
		}
		
		return p;
	}
	
	//----------------------------------
	//  mod
	//----------------------------------
	
	public function mod(p:Polynomial):Polynomial
	{
		if (length < p.length)
			return this;
		
		var ratio:int = glog( valueAt(0) ) - glog( p.valueAt(0) );
		var numbers  : Array = new Array(length);
		
		var n:int = length;
		for (var i:int = 0; i < n; i++)
		{
			numbers[i] = valueAt(i);
		}
		
		n = p.length;
		for (i = 0; i < n; i++)
		{
			numbers[i] ^= gexp(glog( p.valueAt(i) ) + ratio);
		}
		
		return new Polynomial(numbers).mod(p);
	}
	
	//----------------------------------
	//  multiply
	//----------------------------------
	
	public function multiply(p:Polynomial):Polynomial
	{
		var numbers:Array = new Array(length + p.length - 1);
		
		var m:int = length;
		var n:int = p.length;
		for (var i:int = 0; i < m; i++)
		{
			for (var j:int = 0; j < n; j++)
			{
				numbers[i+j] ^= gexp( glog(valueAt(i)) + glog(p.valueAt(j)) );
			}
		}

		return new Polynomial(numbers);
	}
	
	//----------------------------------
	//  toLogString
	//----------------------------------
	
	public function toLogString():String
	{
		var string:String = "";
		
		var n:int = length;
		for (var i:int = 0; i < n; i++)
		{
			if (i > 0)
				string += ",";
			
			string += glog( valueAt(i) );
		}

		return string;
	}
	
	//----------------------------------
	//  toString
	//----------------------------------
	
	public function toString():String
	{
		var string:String = "";
		
		var n:int = length;
		for (var i:int = 0; i < n; i++)
		{
			if (i > 0)
				string += ",";
			
			string += valueAt(i);
		}

		return string;
	}
	
	//----------------------------------
	//  valueAt
	//----------------------------------
	
	public function valueAt(index:int):int {
		return numbers[index];
	}
}

}