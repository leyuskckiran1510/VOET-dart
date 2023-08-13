// import 'package:flutter/material.dart';


//flutter pub add flutter_ffmpeg
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

/// Represents a shape with position and dimensions relative to a background video.
///
/// Creates a [Shape] instance with the specified position and dimensions.
///
///         The [x] and [y] values should be in the range [0, 100] representing the
/// 
///         percentage of the background video's width and height, respectively.
/// 
/// ```dart
///     x =100, y=100;
///     means the overlayed video will be put at right bottom corner of the screen
///     x=0 , y=0;
///     means it will be put in the left top corner
///     --------------------------------
///     | 0,0                    100,0 |
///     |                              |
///     |       BackGround Video       |
///     |            50,50             |
///     |                              |
///     |                              |
///     | 0,100                100,100 |
///     --------------------------------
/// ```
/// 
///         The [w] and [h] values should be in the range [0, 100] representing the
/// 
///         percentage of the background video's width and height, respectively.
/// 
/// ```dart
///     w =100, h=100;
///     // means the overlay video will be 100% of it's original size
///     w=0 , h=0;
///     // means the overlay video will be of 0% of original video meanig no video
///     --------------------------------
///     | 0,0                    100,0 |
///     |                              |
///     |       Overlay Video          |
///     |            50,50             |
///     |                              |
///     |                              |
///     | 0,100                100,100 |
///     --------------------------------
/// ```
class Shape {
  final int x,y;
  final int w,h;
  Shape({required this.x, required this.y, required this.w, required this.h});
  @override
  String toString() {
    return 'Shape(x: $x, y: $y, w: $w, h: $h)';
  }
}

Future<void> OverLay(String vid1,String vid2,String output,Shape s)async{
    final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
    await _flutterFFmpeg.execute("-i $vid1 -vf  'movie=$vid2,scale=(iw*(${s.w}/100)):(ih*(${s.h}/100)),drawbox=0:0-t:(iw*(${s.w}/100))*2:(ih*(${s.h}/100))*2:color=red@1:t=3.5: -1 [inner]; [in][inner] overlay=(W*(${s.x}/100))-(w/2):(H*(${s.y}/100))-(h/2)' $output").then((rc) => print("FFmpeg process exited with rc $rc"));
}
void main() async {
    Shape shp  = Shape(x: 50,y:50,w:50,h:50);
    await OverLay("vid1.mp4","vid2.mp4","output.mp4",shp);
  return;
}
