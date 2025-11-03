package {
	import flash.media.Video;	
	import flash.media.Camera;	
	import flash.utils.Timer;		
	import flash.events.TimerEvent;	
	import flash.display.Graphics;	
	import flash.display.BitmapData;	
	import flash.display.Bitmap;
	import flash.display.Sprite;
			
	import gs.easing.Cubic;	
	import gs.TweenLite;	
	
	import jp.maaash.ObjectDetection.ObjectDetector;	
	import jp.maaash.ObjectDetection.ObjectDetectorEvent;	
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;	
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
    import flash.events.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	public class WebcamFaceDetector1 extends Sprite {
		
		//How long a rectangle will remain visible after no faces are found
		private const __noFaceTimeout : int = 500;
		
		//how often to analyze the webcam image
		private const __faceDetectInterval : int = 50;
		
		//color of the rectangle
		private const __rectColor : int = 0xff0000;

		private var _detector    :ObjectDetector;
		private var _options     :ObjectDetectorOptions;
		private var _bmpTarget   :Bitmap;

		private var _detectionTimer : Timer;
		
		private var _rects:Array;
		
		private var _video : Video;
		private var _noFaceTimer : Timer;
		
		public var cameraContainer : Sprite;
		private var my_loader:Loader = new Loader();
		private var _ldr:Loader = new Loader();
		private var SourceBitmapData:BitmapData;
		public function WebcamFaceDetector1() {
			
			//Timer for rectangles not being found
			_noFaceTimer = new Timer( __noFaceTimeout );
			_noFaceTimer.addEventListener( TimerEvent.TIMER , _noFaceTimer_timer);
			
			//Array of reusable rectangles
			_rects = new Array( );
			
			//timer for how often to detect
			_detectionTimer = new Timer( __faceDetectInterval );
			_detectionTimer.addEventListener( TimerEvent.TIMER , _detectionTimer_timer);
			//_detectionTimer.start();
			
			//initalize detector			
			_initDetector();
			
			//set up camera
			_setupCamera();
			
			//hook up detection complete
			_detector.addEventListener( ObjectDetectorEvent.DETECTION_COMPLETE , _detection_complete );
			trace("0000000");
			
			//SourceBitmapData =new BitmapData(SMc.width,SMc.height);
//			SourceBitmapData.draw(SMc);
			startLoading("0.jpg");
		}
		
		private function _setupCamera() : void{
			
			var camera : Camera;
			
			var index:int = 0;
			for ( var i : int = 0 ; i < Camera.names.length ; i ++ ) {
                
				if ( Camera.names[ i ] == "USB Video Class Video" ) {
					index = i;
				}
			}
			
			camera  = Camera.getCamera( String( index ) );
			camera.setMode(320, 240, 24);
            
			if (camera != null) {
				_video = new Video( camera.width , camera.height );
				_video.attachCamera( camera );
				//_video.alpha=.3;
				addChild( _video );
				
			} else {
				trace( "You need a camera." );
			}
			
		}

		/**
		 * Called when No faces are found after __noFaceTimeout time
		 */
		private function _noFaceTimer_timer (event : TimerEvent) : void {
			
			_noFaceTimer.stop();
			
			for (var i : int = 0; i < _rects.length; i++) {
					
					TweenLite.to( _rects[i] , .5, {
						alpha:0,
						x:_rects[i].x + _video.x, 
						y:_rects[i].y,
						ease:Cubic.easeOut	
					} );					

				}
			
		}

		/**
		 * Creates a rectangle
		 */
		private function _createRect() : Sprite{
			
			var rectContainer : Sprite = new Sprite();
			rectContainer.graphics.lineStyle( 2 , __rectColor , 1 );
			rectContainer.graphics.beginFill(0x000000,0);
			rectContainer.graphics.drawRect(0, 0, 100, 100);
			
			return rectContainer;
			
		}
		
		/**
		 * Evalutates the webcam video for faces on a timer
		 */		
		private function _detectionTimer_timer (event : TimerEvent) : void {
			trace("time..start");
			_bmpTarget = new Bitmap( new BitmapData( _video.width, _video.height, false ) );
			_bmpTarget.bitmapData.draw( _video );
			_detector.detect( _bmpTarget );
			
		}
		
		/**
		 * Fired when a detection is complete
		 */
		private function _detection_complete (event : ObjectDetectorEvent) : void {
			
			//no faces found
			trace("detectopn..." +event.rects.length );
			if(event.rects.length == 0) return;
			
			//stop the no-face timer and start back up again
			_noFaceTimer.stop( );
			_noFaceTimer.start();
			
			//loop through faces found			
			for (var i : int = 0; i < event.rects.length ; i++) {
				
				//create rectangles if needed
				if(_rects[i] == null){
					_rects[i] = _createRect();
					addChild(_rects[i]);
				}
				
				//Animate to new size
				_rects[i].x=event.rects[i].x*_video.scaleX + _video.x;
				_rects[i].y=event.rects[i].y*_video.scaleY;
				_rects[i].width=event.rects[i].width*_video.scaleX;
				_rects[i].height=event.rects[i].height*_video.scaleY;
				/*TweenLite.to( _rects[i] , .5, {
					alpha:1,
					x:event.rects[i].x*_video.scaleX + _video.x,
					y:event.rects[i].y*_video.scaleY,
					width:event.rects[i].width*_video.scaleX,
					height:event.rects[i].height*_video.scaleY,
					ease:Cubic.easeOut	
				} );*/
				
			}
			
			//hide the rest of the rectangles
			trace("event.rects.length.." + event.rects.length + ".." +_rects.length +".." + _rects[0].width);
			if(event.rects.length < _rects.length){
				/*var _rectangle1:Rectangle =new Rectangle(_rects[0].x,_rects[0].y,_rects[0].width,_rects[0].height);
					var _bmp:Bitmap=GetBimap(_bmpTarget,_rectangle1);
					addChild(_bmp);
					_bmp.x=300;
			   		_detector.removeEventListener( ObjectDetectorEvent.DETECTION_COMPLETE , _detection_complete );*/
				for (var j : int = event.rects.length; j < _rects.length; j++) {
					trace("x.." + _rects[j].x + ".." + _rects[j].y);
					
					TweenLite.to( _rects[j] , .5, {
						alpha:0,
						x:_rects[j].x,
						y:_rects[j].y,
						ease:Cubic.easeOut	
					} );					
				}
			}
			var _w,_h:int=5;
			var _rectangle1:Rectangle =new Rectangle(_rects[0].x-(_rects[0].width/2),_rects[0].y,_rects[0].width*2,_rects[0].height*2);
			//var _rectangle1:Rectangle =new Rectangle(_rects[0].x-(_rects[0].width/2),_rects[0].y,_rects[0].width*2,_rects[0].height*2);
			var _bmp:Bitmap=GetBimap(_bmpTarget,_rectangle1);
			var _square:Sprite=creatArea(_bmp.width,_bmp.height, 0xff0000);
			var _tempMc:MovieClip=new MovieClip();
			_tempMc.addChild(_bmp);
			_square.alpha=.2;
			_tempMc.addChild(_square);
			addChild(_tempMc);
			_square.x=_bmp.x=300;
			
			//startLoading("aa.jpg");
			//_detector.removeEventListener( ObjectDetectorEvent.DETECTION_COMPLETE , _detection_complete );
		}

		/**
		 * Initializes the detector
		 */
		private function _initDetector () : void {
			
			_detector = new ObjectDetector;
			_detector.options = getDetectorOptions( );
			_detector.loadHaarCascades( "face.zip" );
			
		}
		
		/**
		 * Gets dector options
		 */
		private function getDetectorOptions () : ObjectDetectorOptions {
			
			_options = new ObjectDetectorOptions;
			_options.min_size = 50;
			_options.startx = ObjectDetectorOptions.INVALID_POS;
			_options.starty = ObjectDetectorOptions.INVALID_POS;
			_options.endx = ObjectDetectorOptions.INVALID_POS;
			_options.endy = ObjectDetectorOptions.INVALID_POS;
			return _options;
			
		}
		private function GetBimap(_sourceBitmap:Bitmap,_rectangle:Rectangle):Bitmap{
			var _bmp:Bitmap;
			var _bmd:BitmapData =_sourceBitmap.bitmapData;
			//var copy_bmp:BitmapData;
			var copy_bmp:BitmapData =new BitmapData(_rectangle.width,_rectangle.height);
			var new_bmd:BitmapData =new BitmapData(_rectangle.width,_rectangle.height);
			
			copy_bmp.copyPixels(_bmd,_rectangle,new Point(0,0));
			//copy_bmp.bitmapData =new_bmd;
			trace("color.." + GetColor(copy_bmp));
			_bmp = new Bitmap(copy_bmp);
			
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE ,MouseMoveHandler);
			//stage.removeEventListener(MouseEvent.MOUSE_UP ,MouseUpHandler);
			return _bmp;
		}
		private function GetColor(_SourceBitmapData:BitmapData):uint{
			var _c:uint;
			var _count:int=0;
			var _bmp:Bitmap;
			var _bmd:BitmapData =new BitmapData(_SourceBitmapData.width,_SourceBitmapData.height);
			var _square:Sprite;
			var red:Number = 0, blue:Number = 0, green:Number = 0;
			for (var i:int=0; i<_SourceBitmapData.width-1; i++) {
      			for (var j:int=0; j<_SourceBitmapData.height-1; j++) {
					_count++;
					var pixel:Pixel = new Pixel(_SourceBitmapData.getPixel32(i, j));
        			red += pixel.getRed();
        			green += pixel.getGreen();
        			blue += pixel.getBlue();
      			}
			}
			var area:Number = _SourceBitmapData.width * _SourceBitmapData.height;
			var c:ColorTransform = new ColorTransform(1, 1, 1, 1,red/area, green/area , blue/area, 0);///
			trace("color..." + c.color.toString(16));
			_square=creatArea(_SourceBitmapData.width,_SourceBitmapData.height, c.color);
			addChild(_square);
			_square.x=400;

			return _c;
		}
		private function creatArea(_w:int,_h:int,_color:uint):Sprite {
			 var _square:Sprite = new Sprite();
            _square.graphics.beginFill(_color);
            _square.graphics.drawRoundRect(0, 0, _w, _h, 0, 0);
            _square.graphics.endFill();
			return _square;
		}
		private function startLoading(_url:String):void{
			var _ldr:Loader = new Loader();
			var _file:String="aa.jpg";

			//_ldr.load(new URLRequest(_file));
//			addChild(_ldr);
			my_loader.load(new URLRequest(_url));
			trace("load.." + _url);
			my_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, finishLoading);
			
			//var myLoader:Loader = new Loader();
				/*var myRequest:URLRequest = new URLRequest("aa.jpg");
				my_loader.load(myRequest);
				my_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, finishLoading);*/
		}
		private function finishLoading(loadEvent:Event):void{
			addChild(my_loader);
			my_loader.y=_video.height;
			SourceBitmapData =new BitmapData(my_loader.width,my_loader.height);
			SourceBitmapData.draw(my_loader);
			//_detectionTimer.start();
			my_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, finishLoading);
			//_detectionTimer.start();
			trace("load..." + my_loader.x + "..." + my_loader.y);
			//DrawPictue(SourceBitmapData);
		}
		private function DrawPictue(_bd:BitmapData):void{
			var red:Number = 0, blue:Number = 0, green:Number = 0;
			for (var i:int=0; i<_bd.width-1; i+=3) {
      			for (var j:int=0; j<_bd.height-1; j++) {
					var pixell:Pixel = new Pixel(_bd.getPixel32(i, j));
        			red += pixell.getRed();
        			green += pixell.getGreen();
        			blue += pixell.getBlue();
      			}
			}
			
		}
	}
}
