package flexbars.controls.qrCodeClasses
{

public class QRCodeDataList
{
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var list:Array /* of QRCodeData */ = [];
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
    //  length
    //----------------------------------
	
	public function get length():int
	{
		return list.length;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
    //  add
    //----------------------------------
	
	public function add(data:String, mode:Mode = null):void
	{
		list.push( createQRCodeData(data, mode) );
	}
	
	//----------------------------------
    //  clear
    //----------------------------------
	
	public function clear():void
	{
		list = [];
	}
	
	//----------------------------------
    //  createQRCodeData
    //----------------------------------
	
	public static function createQRCodeData(data:String, mode:Mode):QRCodeData
	{
		switch (mode)
		{
			case Mode.NUMERIC:
			{
				return new NumericData(data);
			}
			case Mode.ALPHANUMERIC:
			{
				return new AlphanumericData(data);
			}
			case Mode.BINARY:
			{
				return new BinaryData(data);
			}
			case Mode.KANJI:
			{
				return new KanjiData(data);
			}
			default:
			{
				return createQRCodeData( data, Mode.getMode(data) );
			}
		}
	}
	
	//----------------------------------
    //  dataAt
    //----------------------------------
	
	public function dataAt(index:int):QRCodeData
	{
		return list[index];
	}
}

}