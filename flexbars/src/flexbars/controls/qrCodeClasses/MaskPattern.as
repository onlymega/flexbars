package flexbars.controls.qrCodeClasses
{

import flash.errors.IllegalOperationError;

public dynamic class MaskPattern
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function MaskPattern(pattern:Function)
	{
		if (nextIndex == MaskPatterns.length)
			throw new IllegalOperationError("Static Enumeration.");
		
		this.index = nextIndex;
		this.pattern = pattern;
		MaskPatterns[nextIndex++] = this;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Static Initializer
	//
	//--------------------------------------------------------------------------
	
	{
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return (i + j) % 2 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return i % 2 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return j % 3 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return (i + j) % 3 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return (int(i / 2) + int(j / 3) ) % 2 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return (i * j) % 2 + (i * j) % 3 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return ((i * j) % 2 + (i * j) % 3) % 2 == 0;
			}
		);
		new MaskPattern(
			function(i:int, j:int):Boolean
			{
				return ( (i * j) % 3 + (i + j) % 2) % 2 == 0;
			}
		);
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var index:int;
	private var pattern:Function;
	
	private static var nextIndex:int = 0;
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
    //  apply
    //----------------------------------
	
	public function apply(i:int, j:int):Boolean
	{
		return pattern.apply(null, [i, j]);
	}
	
	//----------------------------------
    //  valueOf
    //----------------------------------
	
	public function valueOf():int
	{
		return index;
	}
	
}

}