package flexbars.controls
{

import flexbars.controls.qrCodeClasses.BCH;
import flexbars.controls.qrCodeClasses.ErrorCorrectionLevel;
import flexbars.controls.qrCodeClasses.MaskPattern;
import flexbars.controls.qrCodeClasses.MaskPatterns;
import flexbars.controls.qrCodeClasses.Polynomial;
import flexbars.controls.qrCodeClasses.QRCodeData;
import flexbars.controls.qrCodeClasses.QRCodeDataList;
import flexbars.controls.qrCodeClasses.ReedSolomonBlock;
import flexbars.utils.BitBuffer;

//--------------------------------------
//  Events
//--------------------------------------

//--------------------------------------
//  Styles
//--------------------------------------

//--------------------------------------
//  Excluded APIs
//--------------------------------------

//--------------------------------------
//  Other metadata
//--------------------------------------

[IconFile("QRCode.png")]

/**
 * 
 * 
 * @see http://www.swetake.com/qr/
 * @see http://www.swetake.com/qr/qr1_en.html
 * @see http://rqrcode.rubyforge.org/
 */
public class QRCode extends MatrixBarcode
{
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function QRCode()
	{
		super();
		
		_errorCorrectionLevel = ErrorCorrectionLevel.L;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	private static const PAD:Array /* of int */ = [0xEC, 0x11];
	
	public static const VERSION_AUTO:int = 0;
	public static const VERSION_MIN:int =  1;
	public static const VERSION_MAX:int = 40;

    	
	private static var POSITION_ADJUSTMENT_TABLE:Array /* int[][] */ =
	[
		[],
		[],
		[18],
		[22],
		[26],
		[30],
		[34],
		[6, 22, 38],
		[6, 24, 42],
		[6, 26, 46],
		[6, 28, 50],
		[6, 30, 54],		
		[6, 32, 58],
		[6, 34, 62],
		[6, 26, 46, 66],
		[6, 26, 48, 70],
		[6, 26, 50, 74],
		[6, 30, 54, 78],
		[6, 30, 56, 82],
		[6, 30, 58, 86],
		[6, 34, 62, 90],
		[6, 28, 50, 72, 94],
		[6, 26, 50, 74, 98],
		[6, 30, 54, 78, 102],
		[6, 28, 54, 80, 106],
		[6, 32, 58, 84, 110],
		[6, 30, 58, 86, 114],
		[6, 34, 62, 90, 118],
		[6, 26, 50, 74, 98, 122],
		[6, 30, 54, 78, 102, 126],
		[6, 26, 52, 78, 104, 130],
		[6, 30, 56, 82, 108, 134],
		[6, 34, 60, 86, 112, 138],
		[6, 30, 58, 86, 114, 142],
		[6, 34, 62, 90, 118, 146],
		[6, 30, 54, 78, 102, 126, 150],
		[6, 24, 50, 76, 102, 128, 154],
		[6, 28, 54, 80, 106, 132, 158],
		[6, 32, 58, 84, 110, 136, 162],
		[6, 26, 54, 82, 110, 138, 166],
		[6, 30, 58, 86, 114, 142, 170]
	];
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  code
	//----------------------------------
	
	override public function get code():String
	{
		var string:String = "";
		
		for each (var qrCodeData:QRCodeData in dataList)
		{
			string += qrCodeData.data;
		}
		
		return string;
	}
	
	override public function set code(value:String):void
	{
		dataList.clear();
		dataList.add(value);
		
		super.code = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  dataList (read-only)
	//----------------------------------
	
	private var _dataList:QRCodeDataList = new QRCodeDataList();
	
	public function get dataList():QRCodeDataList
	{
		return _dataList;
	}
	
	//----------------------------------
	//  errorCorrectionLevel
	//----------------------------------
	
	private var _errorCorrectionLevel:ErrorCorrectionLevel;
	
	public function get errorCorrectionLevel():String
	{
		return String(_errorCorrectionLevel);
	}
	
	public function set errorCorrectionLevel(value:String):void
	{
		try
		{
			_errorCorrectionLevel = ErrorCorrectionLevel[value];
		}
		catch(e:Error)
		{
			throw new ArgumentError("QRCode errorCorrectionLevel value.");
		}
	}
	
	//----------------------------------
	//  size (read-only)
	//----------------------------------
	
	private var _size:int;
	
	public function get size():int
	{
		return version == VERSION_AUTO ? 0 : 17 + 4 * version;
	}
	
	//----------------------------------
	//  version
	//----------------------------------
	
	private var _version:int = VERSION_AUTO;
	private var _actualVersion:Number = NaN;
	
	public function get version():int
	{
		return isNaN(_actualVersion) ? _version : _actualVersion;
	}
	
	public function set version(value:int):void
	{
		if(value < VERSION_AUTO || value > VERSION_MAX)
			throw new ArgumentError("QRCode version value.");
		
		_version = value;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  encode
	//----------------------------------
	
	override protected function encode():void
	{
		encodeData(findBestMaskPattern(), false);
	}
	
	//----------------------------------
	//  initializeMatrix
	//----------------------------------
	
	override protected function initializeMatrix(width:int, height:int):void
	{
		super.initializeMatrix(width, height);
		
		setupPositionDetectionPattern(3, 3);
		setupPositionDetectionPattern(size - 4, 3);
		setupPositionDetectionPattern(3, size - 4);
		
		setupPositionAdjustmentPatterns();
		setupTimingPatterns();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  createBytes
	//----------------------------------
	
	private static function createBytes
		(buffer:BitBuffer, rsBlocks:Array /* of ReedSolomonBlock */)
		:Array /* of int */
	{
		var offset:int = 0;
		
		var maxDataCodeBytes:int = 0;
		var maxErrorCodeBytes:int = 0;
		
		var dataCodes:Array = new Array(rsBlocks.length);
		var errorCodes:Array = new Array(rsBlocks.length);
		
		var rsBlocksLength:int = rsBlocks.length;
		for (var r:int = 0; r < rsBlocksLength; r++)
		{
			var dataCodeBytes:int = rsBlocks[r].dataBytes;
			var errorCodeBytes:int = rsBlocks[r].totalBytes - dataCodeBytes;
			
			maxDataCodeBytes = Math.max(maxDataCodeBytes, dataCodeBytes);
			maxErrorCodeBytes = Math.max(maxErrorCodeBytes, errorCodeBytes);
			
			dataCodes[r] = new Array(dataCodeBytes);
			for (var i:int = 0; i < dataCodeBytes; i++)
			{
				dataCodes[r][i] = 0xFF & buffer.byteAt(offset++);
			}
			
			var rsPoly:Polynomial = Polynomial.getErrorCorrectionPolynomial(errorCodeBytes);
			var rawPoly:Polynomial = new Polynomial(dataCodes[r], rsPoly.length - 1);
			
			var modPoly:Polynomial = rawPoly.mod(rsPoly);
			
			errorCodes[r] = new Array(rsPoly.length - 1);
			
			var n:int = errorCodes[r].length;
			var modIndex:int = modPoly.length - n;
			for (i = 0; i < n; i++)
			{
				errorCodes[r][i] = (modIndex >= 0)? modPoly.valueAt(modIndex) : 0;
				modIndex++;
			}
		}
		
		var totalCodeBytes:int = 0;
		for each (var block:ReedSolomonBlock in rsBlocks)
		{
			totalCodeBytes += block.totalBytes;
		}
		
		var bytes:Array /* of int */ = new Array(totalCodeBytes);
		var index:int = 0;
		
		for (i = 0; i < maxDataCodeBytes; i++)
		{
			for (r = 0; r < rsBlocksLength; r++)
			{
				if (i < dataCodes[r].length)
					bytes[index++] = dataCodes[r][i];
			}
		}
		
		for (i = 0; i < maxErrorCodeBytes; i++)
		{
			for (r = 0; r < rsBlocksLength; r++)
			{
				if (i < errorCodes[r].length)
					bytes[index++] = errorCodes[r][i];
			}
		}
		
		return bytes;
	}
	
	//----------------------------------
	//  createData
	//----------------------------------
	
	private static function createData
		(version:int, ecl:ErrorCorrectionLevel, dataList:QRCodeDataList)
		:Array /* of Object */
	{
		var rsBlocks:Array /* of ReedSolomonBlock */ =
			ReedSolomonBlock.getBlocks(version, ecl);
		var buffer:BitBuffer = new BitBuffer();
		
		var n:int = dataList.length;
		for (var i:int = 0; i < n; i++)
		{
			var data:QRCodeData = dataList.dataAt(i);
			
			buffer.pushBits(int(data.mode), 4);
			buffer.pushBits(data.length, data.getLengthInBits(version));
			
			data.encode(buffer);
		}
		
		var totalDataBytes:int = 0;
		for each (var block:ReedSolomonBlock in rsBlocks)
		{
			totalDataBytes += block.dataBytes;
		}
		
		var totalDataBits:int = totalDataBytes * 8;
		
		if (buffer.lengthInBits > totalDataBits)
			throw new Error("Data overflow");
		
		if (buffer.lengthInBits + 4 <= totalDataBits)
			buffer.pushBits(0, 4);
		
		if (buffer.lengthInBits % 8 != 0)
			buffer.pushBits(0, 8 - buffer.lengthInBits % 8);
		
		i = 0;
		
		while (buffer.lengthInBits < totalDataBits)
		{
			buffer.pushBits(PAD[i % 2], 8);
			i++;
		}
		
		return [buffer, rsBlocks];
	}
	
	//----------------------------------
	//  encodeData
	//----------------------------------
	
	private function encodeData(pattern:MaskPattern, patternTest:Boolean):void
	{
		var data:Array /* of int */;
		
		if (_version == VERSION_AUTO)
		{
			_actualVersion = 0;
			while (_actualVersion++ < VERSION_MAX)
			{
				try
				{
					data = createData(_actualVersion, _errorCorrectionLevel, dataList);
					break;
				}
				catch(e:Error)
				{
				}
			}
		}
		else
		{
			_actualVersion = NaN;
			data = createData(version, _errorCorrectionLevel, dataList);
		}
		
		if (data == null)
			throw new Error("Data overflow.");
		
		var bitBuffer:BitBuffer = data[0];
		var rsBlocks:Array /* of ReedSolomonBlock */ = data[1];
		
		var bytes:Array /* of int */ = createBytes(bitBuffer, rsBlocks);
		
		initializeMatrix(size, size);
		
		setupTypeInfo(pattern, patternTest);
		
		if (version >= 7)
			setupVersionInfo(patternTest);
		
		mapData(bytes, pattern);
	}
	
	//----------------------------------
	//  findBestPattern
	//----------------------------------
	
	private function findBestMaskPattern():MaskPattern
	{
		var bestPatternLostPoints:int = int.MAX_VALUE;
		var bestPattern:MaskPattern;
		
		for each (var pattern:MaskPattern in MaskPatterns)
		{
			encodeData(pattern, true);
			
			var lostPoints:int = getLostPoints();
			
			if (lostPoints < bestPatternLostPoints)
			{
				bestPatternLostPoints = lostPoints;
				bestPattern = pattern;
			}
		}
		
		return bestPattern;
	}
	
	//----------------------------------
	//  getLostPoints
	//----------------------------------
	
	private function getLostPoints():int
	{
		var lostPoints:int = 0;
		var barCount:int = 0;
		
		for (var y:int = 0; y < size; y++)
		{
			for (var x:int = 0; x < size; x++)
			{
				var bar:Boolean = new Boolean(matrix[x][y]);
				
				// level 4
				
				if (bar)
					barCount++;
				
				// level 1
				
				var sameNeighborCount:int = -5;
				
				for (var r:int = -1; r <= 1; r++)
				{
					if (y + r < 0 || y + r >= size)
						continue;
					
					for (var c:int = -1; c <= 1; c++)
					{
						if (r == 0 && c == 0)
							continue;
							
						if (x + c < 0 || x + c >= size)
							continue;
						
						if (new Boolean(matrix[x+c][y+r]) == bar)
							sameNeighborCount++;
					}
				}
				
				if (sameNeighborCount > 0)
					lostPoints += sameNeighborCount + 3;
				
				// level 2
				
				if (x < size-1 && y < size-1)
				{
					sameNeighborCount = 0;
					
					if (new Boolean(matrix[ x ][y+1]) == bar) sameNeighborCount++;
					if (new Boolean(matrix[x+1][ y ]) == bar) sameNeighborCount++;
					if (new Boolean(matrix[x+1][y+1]) == bar) sameNeighborCount++;
					
					if (sameNeighborCount == 3)
						lostPoints += 3;
				}
				
				// level 3
				
				if (x < size-6)
				{
					if (
						 matrix[ x ][y] &&
						!matrix[x+1][y] &&
						 matrix[x+2][y] &&
						 matrix[x+3][y] &&
						 matrix[x+4][y] &&
						!matrix[x+5][y] &&
						 matrix[x+6][y]
					)
						lostPoints += 40;
				}
				
				if (y < size-6)
				{
					if (
						 matrix[x][ y ] &&
						!matrix[x][y+1] &&
						 matrix[x][y+2] &&
						 matrix[x][y+3] &&
						 matrix[x][y+4] &&
						!matrix[x][y+5] &&
						 matrix[x][y+6]
					)
						lostPoints += 40;
				}
			}
		}
		
		var ratio:int = Math.abs(100 * barCount / (size * size) - 50) / 5;
		
		return lostPoints + ratio * 10;
	}
	
	//----------------------------------
	//  mapData
	//----------------------------------
	
	private function mapData(data:Array /* of int */, pattern:MaskPattern):void
	{
		var y:int = size - 1;
		var inc:int = -1;
		var bitIndex:int = 7;
		var byteIndex:int = 0;
		
		for (var x:int = size - 1; x > 0; x -= 2)
		{
			if (x == 6) x--;
			
			while (y >=0 && y < size)
			{
				for (var c : int = 0; c < 2; c++)
				{
					if (matrix[x - c][y] == null)
					{
						var dark : Boolean = false;
						
						if (byteIndex < data.length)
							dark = ( ( (data[byteIndex] >>> bitIndex) & 1) == 1);
						
						if ( pattern.apply(y, x - c) )
							dark = !dark;
						
						matrix[x - c][y] = dark;
						bitIndex--;
						
						if (bitIndex == -1)
						{
							byteIndex++;
							bitIndex = 7;
						}
					}
				}
				
				y += inc;
			}
			
			y -= inc;
			inc = -inc;
		}
	}
	
	//----------------------------------
	//  setupDot
	//----------------------------------
	
	private function setupDot(x:int, y:int, value:Boolean):void
	{
		if(x >= 0 && y >= 0 && x < size && y < size)
			matrix[x][y] = value;
	}
	
	//----------------------------------
	//  setupPositionAdjustmentPatterns
	//----------------------------------
	
	private function setupPositionAdjustmentPatterns():void
	{
		var patterns:Array /* of int */ = POSITION_ADJUSTMENT_TABLE[version];
		
		for each (var x:int in patterns)
		{
			for each (var y:int in patterns)
			{
				if( !matrix[x][y] )
				{
					matrix[x][y] = true;
					setupSquare(x, y, 1, false);
					setupSquare(x, y, 2, true);
				}
			}
		}
	}
	
	//----------------------------------
	//  setupPositionDetectionPattern
	//----------------------------------
	
	private function setupPositionDetectionPattern(x:int, y:int):void
	{
		matrix[x][y] = true;
		
		setupSquare(x, y, 1, true);
		setupSquare(x, y, 2, false);
		setupSquare(x, y, 3, true);
		setupSquare(x, y, 4, false);
	}
	
	//----------------------------------
	//  setupSquare
	//----------------------------------
	
	private function setupSquare(x:int, y:int, offset:uint, value:Boolean):void
	{
		for (var i:int = -offset; i <= offset; i++)
		{
			setupDot(x+i, y-offset, value);
			setupDot(x-offset, y+i, value);
			setupDot(x+i, y+offset, value);
			setupDot(x+offset, y+i, value);
		}
	}
	
	//----------------------------------
	//  setupTimingPatterns
	//----------------------------------
	
	private function setupTimingPatterns():void
	{
		var n:int = size - 8;
		for (var i:int = 8; i < n; i++)
		{
			matrix[i][6] = (i % 2) == 0;
			matrix[6][i] = matrix[i][6];
		}
	}
	
	//----------------------------------
	//  setupTypeInfo
	//----------------------------------
	
	private function setupTypeInfo(pattern:MaskPattern, patternTest:Boolean):void
	{
		var data:int = (int(_errorCorrectionLevel) << 3) | int(pattern);
		var bits:int = BCH.getTypeInfo(data);
		
		for (var i:int = 0; i < 15; i++)
		{
			var mod:Boolean = !patternTest && ((bits >> i) & 1) == 1;
			
			if (i < 6)
				matrix[8][i] = mod;
			else if (i < 8)
				matrix[8][i + 1] = mod;
			else
				matrix[8][size + i - 15] = mod;
			
			if (i < 8)
				matrix[size - i - 1][8] = mod;
			else if (i == 8)
				matrix[7][8] = mod;
			else
				matrix[14 - i][8] = mod;
		}
		
		matrix[8][size - 8] = !patternTest;
	}
	
	//----------------------------------
	//  setupVersionInfo
	//----------------------------------
	
	private function setupVersionInfo(patternTest:Boolean):void
	{
		var bits:int = BCH.getVersionInfo(version);
		
		for (var i:int = 0; i < 18; i++)
		{
			var mod:Boolean = !patternTest && ((bits >> i) & 1) == 1;
			
			var x:int = int(i / 3);
			var y:int = i % 3 + size - 11;
			
			matrix[x][y] = mod;
			matrix[y][x] = mod;
		}
	}
}

}