$stringfile = dir -name .\Input\*\*\*.avi 
$stringdir = dir -Path .\Input\*\*\*.avi | Split-Path -Parent # list the director of the avi files。用来存放要更改的文件名
$nameseparator = "_3\." #确定"_3."作为分割符，斜杠只用于转意

$namearry = $stringfile -Split $nameseparator
$namebase = @('foo') * $stringfile.Length 

$j =0
for ($i = 0; $i -lt $namearry.Length) {

	$namebase[$j] = $namearry[$i]
	$i = $i + 2
	$j++
	
}

for ($m = 0; $m -lt $stringdir.Length) {

	Rename-Item -Path $Stringdir[$m] -NewName $namebase[$m] #-Confirm
	$m++
}