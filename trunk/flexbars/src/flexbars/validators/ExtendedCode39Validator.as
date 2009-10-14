package flexbars.validators
{

import mx.validators.ValidationResult;
import mx.validators.Validator;

public class ExtendedCode39Validator extends Validator
{
	
	public function ExtendedCode39Validator()
	{
		super();
	}
	
	private static const extendedCode39RegExp:RegExp = /^[\x00-\x7F]+$/;
    
    override protected function doValidation(value:Object):Array
    {
        var results:Array = super.doValidation(value);        
        
        if (results.length > 0)
            return results;
        
        if ( !extendedCode39RegExp.test( String(value) ) )
        	results.push(
        		new ValidationResult(true, null, "", "Invalid ExtendedCode39 code")
        	);
        
        return results;
    }
	
}

}