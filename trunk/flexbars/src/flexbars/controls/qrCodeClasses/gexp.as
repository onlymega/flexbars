package flexbars.controls.qrCodeClasses
{

public function gexp(n:int):int
{
	return GaloisTables.GEXP[(n %= 255) < 0 ? n + 255 : n];
}

}