package flexbars.controls.qrCodeClasses
{
   
public function glog(n:int):int
{
	if (n < 1 || n > 255)
		throw new ArgumentError("GaloisTables glog n");
	
	return GaloisTables.GLOG[n];
}

}