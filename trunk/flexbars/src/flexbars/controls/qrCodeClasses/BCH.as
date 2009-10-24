package flexbars.controls.qrCodeClasses
{
	
public class BCH //Bose, Ray-Chaudhuri, Hocquenghem
{
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private static const G15:int = 0x0537;
	private static const G18:int = 0x1F25;
	private static const G15_MASK:int = 0x5412;
	
	private static const G15_RANK:int = getRank(G15);
	private static const G18_RANK:int = getRank(G18);
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  getRank
	//----------------------------------
	
	private static function getRank(data:int):int
	{
		var rank:int = 0;
		
		while (data != 0)
		{
			rank++;
			data >>>= 1;
		}
		
		return rank;
	}
	
	//----------------------------------
	//  getTypeInfo
	//----------------------------------
	
	public static function getTypeInfo(data:int):int
	{
		var d :int = data << 10;
		var delta:int = getRank(d) - G15_RANK;
		
		while (delta >= 0)
		{
			d ^= (G15 << delta);
			delta = getRank(d) - G15_RANK;
		}
		
		return ((data << 10) | d) ^ G15_MASK;
	}
	
	//----------------------------------
	//  getVersionInfo
	//----------------------------------
	
	public static function getVersionInfo(data:int):int
	{
		var d:int = data << 12;
		var delta:int = getRank(d) - G18_RANK;
		
		while (delta >= 0)
		{
			d ^= (G18 << delta);
			delta = getRank(d) - G18_RANK;
		}
		
		return (data << 12) | d;
	}
	
}

}