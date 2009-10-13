package flexbars.validators
{

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class Code39Validator extends Validator
{
	
	public function Code39Validator()
	{
		super();
	}
	
	private var code39RegExp:RegExp = /^[A-Z0-9\-. $\/+%]+$/;
    
    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);        
        
        if (results.length > 0)
            return results;
        
        if ( !code39RegExp.test( String(value) ) )
        	results.push(
        		new ValidationResult(true, null, "", "Invalid Code39 code")
        	);
        
        return results;
    }
	
}

}