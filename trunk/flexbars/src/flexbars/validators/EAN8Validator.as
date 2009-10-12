package flexbars.validators
{

import flexbars.utils.BarcodeUtil;

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class EAN8Validator extends EANValidator
{
	
	public function EAN8Validator()
	{
		super();
		
		codeLength = 8;
	}
    
    override protected function doValidation(value:Object):Array
    {
    	var results:Array = [];
    	
    	try
    	{
       		results = super.doValidation(value);        
     	}
        catch(error:ArgumentError)
        {
        	results.push(
        		new ValidationResult(true, null, "", "Invalid EAN8 code")
        	);
        }
        
        return results;
    }
	
}

}