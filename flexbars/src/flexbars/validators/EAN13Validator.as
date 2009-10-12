package flexbars.validators
{

import flexbars.utils.BarcodeUtil;

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class EAN13Validator extends EANValidator
{
	
	public function EAN13Validator()
	{
		super();
		
		codeLength = 13;
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
        		new ValidationResult(true, null, "", "Invalid EAN13 code")
        	);
        }
        
        return results;
    }
	
}

}