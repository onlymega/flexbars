package flexbars.validators
{

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class Code25Validator extends Validator
{
	
	public function Code25Validator()
	{
		super();
	}
	
	private var digitsOnlyRegExp:RegExp = /^\d+$/;
    
    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);        
        
        if (results.length > 0)
            return results;
        
        if ( !digitsOnlyRegExp.test( String(value) ) )
        	results.push(
        		new ValidationResult(true, null, "", "Invalid Code25 code")
        	);
        
        return results;
    }
	
}

}