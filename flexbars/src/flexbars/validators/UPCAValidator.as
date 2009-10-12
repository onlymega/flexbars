package flexbars.validators
{

import flexbars.utils.BarcodeUtil;

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class UPCAValidator extends EANValidator
{
	
	public function UPCAValidator()
	{
		super();
		
		codeLength = 12;
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
        		new ValidationResult(true, null, "", "Invalid UPC-A code")
        	);
        }
        
        return results;
    }
	
}

}