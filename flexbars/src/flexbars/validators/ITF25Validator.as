package flexbars.validators
{

import mx.validators.ValidationResult;

public class ITF25Validator extends Code25Validator
{
	
	public function ITF25Validator()
	{
		super();
	}
	
	private var digitsOnlyRegExp:RegExp = /\d{+}/;
    
    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);        
        
        if (results.length > 0)
            return results;
        
        if (String(value).length % 2 != 0)
        	results.push(
        		new ValidationResult(true, null, "", "Invalid ITF25 code")
        	);
        
        return results;
    }
	
}

}