Add-Type -AssemblyName System.Drawing

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function New-Point([float] $x, [float] $y) {
  return [System.Drawing.PointF]::new($x, $y)
}

function Add-RoundedRectangle(
  [System.Drawing.Drawing2D.GraphicsPath] $path,
  [float] $x,
  [float] $y,
  [float] $width,
  [float] $height,
  [float] $radius
) {
  $diameter = $radius * 2
  $path.StartFigure()
  $path.AddArc($x, $y, $diameter, $diameter, 180, 90)
  $path.AddArc($x + $width - $diameter, $y, $diameter, $diameter, 270, 90)
  $path.AddArc($x + $width - $diameter, $y + $height - $diameter, $diameter, $diameter, 0, 90)
  $path.AddArc($x, $y + $height - $diameter, $diameter, $diameter, 90, 90)
  $path.CloseFigure()
}

function New-FittedFont(
  [System.Drawing.Graphics] $graphics,
  [string] $familyName,
  [System.Drawing.FontStyle] $style,
  [string] $text,
  [float] $maxWidth,
  [float] $maxHeight,
  [int] $startSize
) {
  for ($size = $startSize; $size -ge 12; $size--) {
    $font = [System.Drawing.Font]::new($familyName, $size, $style, [System.Drawing.GraphicsUnit]::Pixel)
    $measure = $graphics.MeasureString($text, $font)
    if ($measure.Width -le $maxWidth -and $measure.Height -le $maxHeight) {
      return $font
    }

    $font.Dispose()
  }

  return [System.Drawing.Font]::new($familyName, 12, $style, [System.Drawing.GraphicsUnit]::Pixel)
}

function Draw-Curve(
  [System.Drawing.Graphics] $graphics,
  [System.Drawing.Color] $color,
  [float] $width,
  [System.Drawing.PointF[]] $points
) {
  $pen = [System.Drawing.Pen]::new($color, $width)
  $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
  $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
  $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
  $graphics.DrawCurve($pen, $points)
  $pen.Dispose()
}

function Resize-And-Save(
  [System.Drawing.Bitmap] $source,
  [int] $size,
  [string] $path
) {
  $bitmap = [System.Drawing.Bitmap]::new($size, $size)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
  $graphics.Clear([System.Drawing.Color]::White)
  $graphics.DrawImage($source, 0, 0, $size, $size)

  $directory = Split-Path -Parent $path
  if (-not [string]::IsNullOrWhiteSpace($directory)) {
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
  }

  $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $graphics.Dispose()
  $bitmap.Dispose()
}

$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptDirectory

$canvasSize = 1024
$bitmap = [System.Drawing.Bitmap]::new($canvasSize, $canvasSize)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.Clear([System.Drawing.Color]::White)

$deepBlue = [System.Drawing.Color]::FromArgb(15, 61, 145)
$royalBlue = [System.Drawing.Color]::FromArgb(29, 78, 216)
$brightRed = [System.Drawing.Color]::FromArgb(230, 33, 41)
$warmRed = [System.Drawing.Color]::FromArgb(250, 25, 37)
$gold = [System.Drawing.Color]::FromArgb(242, 193, 72)
$warmWhite = [System.Drawing.Color]::FromArgb(250, 251, 253)
$outlineBlue = [System.Drawing.Color]::FromArgb(16, 63, 142)

$iconLeft = 83
$iconTop = 82
$iconSize = 858
$iconRadius = 152

$shadowPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $shadowPath ($iconLeft + 10) ($iconTop + 16) $iconSize $iconSize $iconRadius
$shadowBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(28, 15, 61, 145))
$graphics.FillPath($shadowBrush, $shadowPath)
$shadowBrush.Dispose()
$shadowPath.Dispose()

$iconPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
Add-RoundedRectangle $iconPath $iconLeft $iconTop $iconSize $iconSize $iconRadius
$baseGradient = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.PointF]::new($iconLeft, $iconTop),
  [System.Drawing.PointF]::new($iconLeft + $iconSize, $iconTop + $iconSize),
  $royalBlue,
  $deepBlue
)
$graphics.FillPath($baseGradient, $iconPath)
$baseGradient.Dispose()

$graphics.SetClip($iconPath)

$topBand = [System.Drawing.RectangleF]::new(83, 84, 858, 172)
$topBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.PointF]::new($topBand.Left, $topBand.Top),
  [System.Drawing.PointF]::new($topBand.Right, $topBand.Bottom),
  [System.Drawing.Color]::FromArgb(23, 78, 186),
  $deepBlue
)
$graphics.FillRectangle($topBrush, $topBand)
$topBrush.Dispose()

$middleRect = [System.Drawing.RectangleF]::new(83, 254, 858, 504)
$graphics.FillRectangle([System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(15, 61, 145)), 83, 254, 286, 504)
$graphics.FillRectangle([System.Drawing.SolidBrush]::new($warmWhite), 369, 254, 286, 504)
$graphics.FillRectangle([System.Drawing.SolidBrush]::new($brightRed), 655, 254, 286, 504)

$wavePenWhite = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(54, 255, 255, 255), 28)
$wavePenWhite.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$wavePenWhite.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$wavePenWhite.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 72 296), (New-Point 188 350), (New-Point 290 256), (New-Point 396 330)
  ))
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 54 386), (New-Point 178 452), (New-Point 298 356), (New-Point 398 430)
  ))
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 64 508), (New-Point 188 568), (New-Point 314 474), (New-Point 424 548)
  ))
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 650 286), (New-Point 754 342), (New-Point 864 250), (New-Point 982 326)
  ))
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 636 398), (New-Point 764 460), (New-Point 866 370), (New-Point 964 446)
  ))
$graphics.DrawCurve($wavePenWhite, [System.Drawing.PointF[]] @(
    (New-Point 638 528), (New-Point 756 592), (New-Point 854 498), (New-Point 972 576)
  ))
$wavePenWhite.Dispose()

$foldBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.PointF]::new(460, 254),
  [System.Drawing.PointF]::new(594, 758),
  [System.Drawing.Color]::FromArgb(22, 30, 41, 59),
  [System.Drawing.Color]::FromArgb(0, 30, 41, 59)
)
$graphics.FillEllipse($foldBrush, 424, 250, 170, 524)
$foldBrush.Dispose()

$bottomBand = [System.Drawing.RectangleF]::new(83, 758, 858, 182)
$bottomBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
  [System.Drawing.PointF]::new($bottomBand.Left, $bottomBand.Top),
  [System.Drawing.PointF]::new($bottomBand.Right, $bottomBand.Bottom),
  $deepBlue,
  [System.Drawing.Color]::FromArgb(20, 84, 194)
)
$graphics.FillRectangle($bottomBrush, $bottomBand)
$bottomBrush.Dispose()

$polePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(227, 192, 92), 8)
$polePen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$polePen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$graphics.DrawLine($polePen, 165, 672, 182, 438)
$polePen.Dispose()
$goldBrush = [System.Drawing.SolidBrush]::new($gold)
$graphics.FillEllipse($goldBrush, 153, 423, 28, 28)
$graphics.FillEllipse($goldBrush, 158, 430, 22, 22)
$goldBrush.Dispose()

$hairBack = [System.Drawing.Drawing2D.GraphicsPath]::new()
$hairBack.StartFigure()
$hairBack.AddBezier((New-Point 150 664), (New-Point 136 540), (New-Point 246 434), (New-Point 398 360))
$hairBack.AddBezier((New-Point 398 360), (New-Point 454 336), (New-Point 512 324), (New-Point 568 336))
$hairBack.AddBezier((New-Point 568 336), (New-Point 500 422), (New-Point 436 562), (New-Point 350 720))
$hairBack.AddBezier((New-Point 350 720), (New-Point 268 748), (New-Point 190 734), (New-Point 150 664))
$hairBack.CloseFigure()
$hairBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(12, 50, 123))
$graphics.FillPath($hairBrush, $hairBack)
$hairBrush.Dispose()
$hairBack.Dispose()

$shoulder = [System.Drawing.Drawing2D.GraphicsPath]::new()
$shoulder.StartFigure()
$shoulder.AddBezier((New-Point 430 720), (New-Point 486 708), (New-Point 560 702), (New-Point 616 712))
$shoulder.AddBezier((New-Point 616 712), (New-Point 596 760), (New-Point 502 786), (New-Point 410 770))
$shoulder.AddBezier((New-Point 410 770), (New-Point 394 748), (New-Point 400 730), (New-Point 430 720))
$shoulder.CloseFigure()
$graphics.FillPath([System.Drawing.SolidBrush]::new($warmWhite), $shoulder)
$shoulderPen = [System.Drawing.Pen]::new($outlineBlue, 8)
$shoulderPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$graphics.DrawPath($shoulderPen, $shoulder)
$shoulderPen.Dispose()
$shoulder.Dispose()

$face = [System.Drawing.Drawing2D.GraphicsPath]::new()
$face.StartFigure()
$face.AddBezier((New-Point 523 350), (New-Point 586 336), (New-Point 664 362), (New-Point 701 412))
$face.AddBezier((New-Point 701 412), (New-Point 716 430), (New-Point 720 454), (New-Point 710 482))
$face.AddBezier((New-Point 710 482), (New-Point 696 494), (New-Point 688 514), (New-Point 696 540))
$face.AddBezier((New-Point 696 540), (New-Point 680 570), (New-Point 638 604), (New-Point 584 616))
$face.AddBezier((New-Point 584 616), (New-Point 552 618), (New-Point 528 602), (New-Point 516 568))
$face.AddBezier((New-Point 516 568), (New-Point 506 500), (New-Point 494 430), (New-Point 523 350))
$face.CloseFigure()
$faceBrush = [System.Drawing.SolidBrush]::new($warmWhite)
$graphics.FillPath($faceBrush, $face)
$faceBrush.Dispose()
$facePen = [System.Drawing.Pen]::new($outlineBlue, 8)
$facePen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$graphics.DrawPath($facePen, $face)
$facePen.Dispose()
$face.Dispose()

$neck = [System.Drawing.Drawing2D.GraphicsPath]::new()
$neck.StartFigure()
$neck.AddBezier((New-Point 542 598), (New-Point 558 648), (New-Point 548 702), (New-Point 510 740))
$neck.AddBezier((New-Point 510 740), (New-Point 560 742), (New-Point 606 720), (New-Point 622 684))
$neck.AddBezier((New-Point 622 684), (New-Point 600 642), (New-Point 570 616), (New-Point 542 598))
$neck.CloseFigure()
$neckBrush = [System.Drawing.SolidBrush]::new($warmWhite)
$graphics.FillPath($neckBrush, $neck)
$neckBrush.Dispose()
$neckPen = [System.Drawing.Pen]::new($outlineBlue, 8)
$neckPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$graphics.DrawPath($neckPen, $neck)
$neckPen.Dispose()
$neck.Dispose()

$cap = [System.Drawing.Drawing2D.GraphicsPath]::new()
$cap.StartFigure()
$cap.AddBezier((New-Point 386 334), (New-Point 442 252), (New-Point 610 234), (New-Point 708 274))
$cap.AddBezier((New-Point 708 274), (New-Point 734 290), (New-Point 742 336), (New-Point 710 354))
$cap.AddBezier((New-Point 710 354), (New-Point 644 382), (New-Point 548 382), (New-Point 460 354))
$cap.AddBezier((New-Point 460 354), (New-Point 420 352), (New-Point 394 350), (New-Point 386 334))
$cap.CloseFigure()
$capBrush = [System.Drawing.SolidBrush]::new($warmRed)
$graphics.FillPath($capBrush, $cap)
$capBrush.Dispose()
$capShadePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(154, 170, 14, 26), 12)
$capShadePen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$capShadePen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$graphics.DrawCurve($capShadePen, [System.Drawing.PointF[]] @(
    (New-Point 434 346), (New-Point 520 324), (New-Point 620 330), (New-Point 694 352)
  ))
$capShadePen.Dispose()
$cap.Dispose()

$cockadeCenterX = 416
$cockadeCenterY = 386
$cockadeOuter = [System.Drawing.SolidBrush]::new($gold)
$cockadeRed = [System.Drawing.SolidBrush]::new($brightRed)
$cockadeWhite = [System.Drawing.SolidBrush]::new($warmWhite)
$cockadeBlue = [System.Drawing.SolidBrush]::new($royalBlue)
$graphics.FillEllipse($cockadeOuter, $cockadeCenterX - 56, $cockadeCenterY - 56, 112, 112)
$graphics.FillEllipse($cockadeRed, $cockadeCenterX - 46, $cockadeCenterY - 46, 92, 92)
$graphics.FillEllipse($cockadeWhite, $cockadeCenterX - 34, $cockadeCenterY - 34, 68, 68)
$graphics.FillEllipse($cockadeBlue, $cockadeCenterX - 20, $cockadeCenterY - 20, 40, 40)
$cockadeOuter.Dispose()
$cockadeRed.Dispose()
$cockadeWhite.Dispose()
$cockadeBlue.Dispose()

Draw-Curve $graphics $brightRed 30 ([System.Drawing.PointF[]] @(
    (New-Point 442 366), (New-Point 498 328), (New-Point 572 314), (New-Point 652 326)
  ))
Draw-Curve $graphics $gold 14 ([System.Drawing.PointF[]] @(
    (New-Point 452 372), (New-Point 512 342), (New-Point 576 334), (New-Point 646 348)
  ))
Draw-Curve $graphics $warmWhite 12 ([System.Drawing.PointF[]] @(
    (New-Point 462 378), (New-Point 520 356), (New-Point 578 352), (New-Point 632 364)
  ))

Draw-Curve $graphics ([System.Drawing.Color]::FromArgb(10, 58, 141)) 46 ([System.Drawing.PointF[]] @(
    (New-Point 164 650), (New-Point 242 566), (New-Point 356 500), (New-Point 500 476)
  ))
Draw-Curve $graphics $warmWhite 24 ([System.Drawing.PointF[]] @(
    (New-Point 156 646), (New-Point 234 562), (New-Point 344 496), (New-Point 490 476)
  ))
Draw-Curve $graphics ([System.Drawing.Color]::FromArgb(12, 50, 123)) 34 ([System.Drawing.PointF[]] @(
    (New-Point 172 694), (New-Point 270 620), (New-Point 366 574), (New-Point 468 564)
  ))
Draw-Curve $graphics $warmWhite 16 ([System.Drawing.PointF[]] @(
    (New-Point 166 692), (New-Point 258 624), (New-Point 360 584), (New-Point 468 574)
  ))
Draw-Curve $graphics ([System.Drawing.Color]::FromArgb(12, 50, 123)) 26 ([System.Drawing.PointF[]] @(
    (New-Point 210 742), (New-Point 304 686), (New-Point 394 662), (New-Point 492 658)
  ))
Draw-Curve $graphics $warmWhite 12 ([System.Drawing.PointF[]] @(
    (New-Point 204 742), (New-Point 294 690), (New-Point 392 668), (New-Point 494 664)
  ))
Draw-Curve $graphics ([System.Drawing.Color]::FromArgb(12, 50, 123)) 22 ([System.Drawing.PointF[]] @(
    (New-Point 308 442), (New-Point 380 430), (New-Point 454 438), (New-Point 530 456)
  ))
Draw-Curve $graphics $warmWhite 12 ([System.Drawing.PointF[]] @(
    (New-Point 316 444), (New-Point 384 440), (New-Point 454 448), (New-Point 524 466)
  ))

$profilePen = [System.Drawing.Pen]::new($outlineBlue, 8)
$profilePen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$profilePen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$profilePen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 578 418), (New-Point 624 402), (New-Point 666 406), (New-Point 694 424)
  ))
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 680 454), (New-Point 692 460), (New-Point 694 476), (New-Point 682 494)
  ))
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 648 522), (New-Point 676 530), (New-Point 684 548), (New-Point 670 566)
  ))
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 590 444), (New-Point 614 438), (New-Point 632 440), (New-Point 646 450)
  ))
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 564 620), (New-Point 614 622), (New-Point 654 608), (New-Point 688 576)
  ))
$graphics.DrawCurve($profilePen, [System.Drawing.PointF[]] @(
    (New-Point 496 410), (New-Point 526 390), (New-Point 560 380), (New-Point 590 382)
  ))
$profilePen.Dispose()

$innerStrokePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(196, 255, 255, 255), 5)
$innerStrokePen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$innerStrokePen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
$graphics.DrawCurve($innerStrokePen, [System.Drawing.PointF[]] @(
    (New-Point 514 392), (New-Point 544 374), (New-Point 586 366), (New-Point 628 372)
  ))
$innerStrokePen.Dispose()

$topTextRect = [System.Drawing.RectangleF]::new(122, 114, 780, 110)
$bottomTextRect = [System.Drawing.RectangleF]::new(122, 790, 780, 120)
$stringFormat = [System.Drawing.StringFormat]::new()
$stringFormat.Alignment = [System.Drawing.StringAlignment]::Center
$stringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

$topFont = New-FittedFont $graphics 'Segoe UI' ([System.Drawing.FontStyle]::Bold) 'EXAMEN CIVIQUE' 780 110 92
$bottomFont = New-FittedFont $graphics 'Segoe UI' ([System.Drawing.FontStyle]::Bold) 'FR 2026' 780 120 114
$shadowBrushText = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(72, 10, 23, 58))
$textBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)

$shadowTop = [System.Drawing.RectangleF]::new($topTextRect.X, $topTextRect.Y + 8, $topTextRect.Width, $topTextRect.Height)
$shadowBottom = [System.Drawing.RectangleF]::new($bottomTextRect.X, $bottomTextRect.Y + 8, $bottomTextRect.Width, $bottomTextRect.Height)
$graphics.DrawString('EXAMEN CIVIQUE', $topFont, $shadowBrushText, $shadowTop, $stringFormat)
$graphics.DrawString('FR 2026', $bottomFont, $shadowBrushText, $shadowBottom, $stringFormat)
$graphics.DrawString('EXAMEN CIVIQUE', $topFont, $textBrush, $topTextRect, $stringFormat)
$graphics.DrawString('FR 2026', $bottomFont, $textBrush, $bottomTextRect, $stringFormat)

$topFont.Dispose()
$bottomFont.Dispose()
$shadowBrushText.Dispose()
$textBrush.Dispose()
$stringFormat.Dispose()

$outlinePen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(28, 255, 255, 255), 4)
$outlinePen.Alignment = [System.Drawing.Drawing2D.PenAlignment]::Inset
$graphics.DrawPath($outlinePen, $iconPath)
$outlinePen.Dispose()

$graphics.ResetClip()

$iconPath.Dispose()

$assetIconPath = Join-Path $repoRoot 'assets/icon.png'
$assetDirectory = Split-Path -Parent $assetIconPath
if (-not [string]::IsNullOrWhiteSpace($assetDirectory)) {
  New-Item -ItemType Directory -Force -Path $assetDirectory | Out-Null
}

$bitmap.Save($assetIconPath, [System.Drawing.Imaging.ImageFormat]::Png)

$targets = @(
  @{ Size = 32; Path = Join-Path $repoRoot 'web/favicon.png' },
  @{ Size = 192; Path = Join-Path $repoRoot 'web/icons/Icon-192.png' },
  @{ Size = 512; Path = Join-Path $repoRoot 'web/icons/Icon-512.png' },
  @{ Size = 192; Path = Join-Path $repoRoot 'web/icons/Icon-maskable-192.png' },
  @{ Size = 512; Path = Join-Path $repoRoot 'web/icons/Icon-maskable-512.png' },
  @{ Size = 48; Path = Join-Path $repoRoot 'android/app/src/main/res/mipmap-mdpi/ic_launcher.png' },
  @{ Size = 72; Path = Join-Path $repoRoot 'android/app/src/main/res/mipmap-hdpi/ic_launcher.png' },
  @{ Size = 96; Path = Join-Path $repoRoot 'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png' },
  @{ Size = 144; Path = Join-Path $repoRoot 'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png' },
  @{ Size = 192; Path = Join-Path $repoRoot 'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png' }
)

foreach ($target in $targets) {
  Resize-And-Save $bitmap $target.Size $target.Path
}

$graphics.Dispose()
$bitmap.Dispose()

Write-Output 'Brand assets generated.'
