#这个脚本用来对文件夹进行批量改名renamefolder20240226.ps1

$stringfile = dir -name .\a*\*\*.avi #通过ImageXpert我们得到了一个”墨水名_喷墨频率_对应的波形_3.50fps.avi"的文件。这条命令的作用是在给定的目录范围内找到扩展名为 “.avi” 的文件，并将结果存储在变量 $stringfile 中。获取想用的文件名，
$stringdir = dir -Path .\a*\*\*.avi | Split-Path -Parent # list the director of the avi files。用来存放要更改的文件名
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

	Rename-Item -Path $Stringdir[$m] -NewName $namebase[$m] -Confirm
	$m++
}
