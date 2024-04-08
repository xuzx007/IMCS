#这个脚本用来给对图片进行裁切，最后拼接成一张图。

$RunIM = "C:\Users\XuZ\Downloads\ImageMagick71121\" #ImageMagick的执行路径。*据情况更改*
$SourceDir = dir -Path C:\Users\XuZ\Downloads\ImageMagick71121\CS\task20240226\input\*\*\*.avi | Split-Path -Parent #找到源文件夹的绝对路径,这是个数组*据情况更改*
$OutDir = "C:\Users\XuZ\Downloads\ImageMagick71121\CS\task20240226\output20240226\" #定义输出文件的到那个目录，这个脚本好像要放到这个目录里。*据情况更改*

$RunMagick = $RunIM + "magick" #执行magick的完整路径

$NameBase = @('foo') * $SourceDir.Length

#外循环用来逐个扫描文件夹，肉循环用来扫描文件进行裁切。
for ($i = 0; $i -lt $SourceDir.Length) {
	
	$NameBase[$i] = $SourceDir[$i].Split("\")[-1]	#用反斜杠对文件路径进行分割，然后取文件最后一段保存到$NameBase里
	$OutSubDir = $NameBase[$i] 
	mkdir $OutSubDir #在output文件夹(运行命令胡当前文件夹下)下建立子文件夹用来，用来放TIF图片
	
	#循环剪切
	for ($j=1; $j -lt 30) { #裁切图片区间设定为1到30
		$Filenumber = "{0:d4}" -f $j
		$SourceName = $NameBase[$i] + "_" + $Filenumber + ".tif"
		$OutName = "crop_" + $SourceName #输出文件名与源文件同名
		
		$RunCrop = $RunMagick + " " + $SourceDir[$i] + "\" + $SourceName + " -crop 180x963+570+1 " + $OutDir + $OutSubDir + "\" + $OutName
		Invoke-expression $RunCrop #执行裁切
		
		$j = $j + 3 #裁切图片间隔
	
	}

	$RunStiching = $RunMagick + " convert +append " + $OutDir + $OutSubDir + "\*.tif " + "stiching_" + $NameBase[$i] + ".tif"
	Invoke-expression $RunStiching
	
	$i++
}
