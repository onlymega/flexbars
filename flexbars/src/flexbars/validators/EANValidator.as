package flexbars.validators
{

import flexbars.utils.BarcodeUtil;

import mx.validators.ValidationResult;
import mx.validators.Validator;

internal class EANValidator extends Validator
{
	
	public function EANValidator()
	{
		super();
	}
	
	protected var codeLength:int = -1;
    
    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);        
        
        if (results.length > 0)
            return results;
        
        BarcodeUtil.computeMod10Digit(String(value), codeLength);
        
        return results;
    }
	
}

}