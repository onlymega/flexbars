package flexbars.controls.qrCodeClasses
{

internal class GaloisTables
{
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
    
	internal static const GEXP:Array = new Array(256);
	internal static const GLOG:Array = new Array(256);
	
	//--------------------------------------------------------------------------
	//
	//  Static Initializer
	//
	//--------------------------------------------------------------------------
	
	{
		initializeGaloisTables();
	}

	private static function initializeGaloisTables():void
	{
		for (var i:int = 0; i < 8; i++)
		{
			GEXP[i] = 1 << i;
			GLOG[ GEXP[i] ] = i;
		}

		for (i = 8; i < 256; i++)
		{
			GEXP[i] = GEXP[i-4] ^ GEXP[i-5] ^ GEXP[i-6] ^ GEXP[i-8];
			GLOG[ GEXP[i] ] = i;
		}
		
		GLOG[1] = 0;
	}
}

}