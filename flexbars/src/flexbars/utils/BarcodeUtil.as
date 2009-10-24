package flexbars.utils
{

public class BarcodeUtil
{
    
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------
	
    //----------------------------------
    //  computeCheckDigit
    //----------------------------------
	
	public static function computeMod10Digit(code:String, codeLength:int):String
	{
		var codeLengthWithoutKey:int = codeLength - 1;
		
		if (code.length != codeLengthWithoutKey && code.length != codeLength)
			throw new ArgumentError("BarcodeUtil checkMod10Digit code length");
		
		var checkDigit:int = mod10(code, codeLengthWithoutKey);
		
		if (code.length == codeLengthWithoutKey)
			return code + checkDigit;
		
		if (parseInt( code.charAt(codeLength - 1) ) != checkDigit)
			throw new ArgumentError("BarcodeUtil checkMod10Digit invalid check digit");
		
		return code;
	}
	
    //----------------------------------
    //  mod10
    //----------------------------------
	
	public static function mod10(code:String, length:int = 0):int
	{
		if (length == 0)
			length = code.length;
		
		if (length <= 0)
			throw new ArgumentError("BarcodeUtil mod10");
		
		var sums:Array = [0, 0];
		
		for (var i:int = 0; i < length; i++)
		{
			sums[i & 1] += parseInt( code.charAt(i) );
		}
		
		var sum:int = length & 1 ? sums[0] * 3 + sums[1] : sums[0] + sums[1] * 3;
		
		return (10 - sum % 10) % 10;
	}
	
}

}