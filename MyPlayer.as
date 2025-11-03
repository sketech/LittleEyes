package  {
	import fl.video.FLVPlayback;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Sprite;
	import fl.video.MetadataEvent;
	import fl.video.VideoEvent;
	import flash.events.AsyncErrorEvent;  
    import com.myEvent.MyEvent;
	public class MyPlayer extends MovieClip {
		private var myWidth:Number;
		private var myHeight:Number;
		private var myPLayer:FLVPlayback;
		private var playSource:String;
		private var AutoPlay:Boolean;
		public var TotalTime:Number;
		public var PlayheadTime:Number;
		public var Name:String;
		public var isLoop:Boolean=false;
		public var Volume:Number=1;
		public var Type:String = "Video";
		public var State:String = "Null";
		public function MyPlayer(_w:Number=100,_h:Number=100,_source:String="",_isAutoPlay:Boolean= false,_isLoop:Boolean=false,_name:String="V1",_volume:Number=1) {
			// constructor code
			myWidth=_w;
			myHeight=_h;
			playSource=_source;
			AutoPlay=_isAutoPlay;
			Name= _name;
			isLoop= _isLoop;
			Volume = _volume;
			CreateBg();
			CreateVideo();
		}
		private function CreateBg():void
		{
			var _square:Sprite = creatArea(myWidth,myHeight,0x000000,0);
			this.addChild(_square);
		}
		private function CreateVideo():void
		{
			myPLayer=new FLVPlayback();
			myPLayer.width=myWidth;
			myPLayer.height=myHeight;
			//myPLayer.source = playSource;
			myPLayer.load(playSource);

			myPLayer.autoPlay =AutoPlay;   //開始時是否PLay
			myPLayer.fullScreenTakeOver = false;
			myPLayer.autoRewind = isLoop;  //true 播完時回覆至第一楨 ,default=false 停在最後一楨
			myPLayer.getVideoPlayer(myPLayer.activeVideoPlayerIndex).smoothing = true;
			myPLayer.volume = Volume;
			this.addChild(myPLayer);
	
			myPLayer.addEventListener(fl.video.VideoEvent.COMPLETE,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.VideoEvent.READY,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.MetadataEvent.CUE_POINT,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.VideoEvent.AUTO_REWOUND, PlayerEventHandle ); //配合loop
			//trace("aa:" +myPLayer.progressInterval);
			var cuePt:Object = new Object();
			cuePt.time = 5.1;
			cuePt.name = "elapsed_time";
			cuePt.type = "actionscript";
			myPLayer.addASCuePoint(cuePt);
			////////myPLayer.framerate
		}
		public function SetVolume(_v:Number):void{
			myPLayer.volume = _v;
		}
		public function Play(){
			myPLayer.play();
		}
		public function Stop(){
			trace("myplayer Stop..." + Name);
			myPLayer.stop();
		}
		public function Pause(){
			myPLayer.pause();
			trace("myplayer Pause..." + Name);
		}
	/*	public function GetFrameRate():String{
			return myPLayer.framerate().toString();
		}*/
		public function RSource(str:String,_isPlay:Boolean = true){
			//myPLayer.source=str;
			//trace("resource.." + str);
			myPLayer.activeVideoPlayerIndex=0;
			myPLayer.visibleVideoPlayerIndex=0;
			myPLayer.load(str);
			ClearEvent();
			//var cuePt:Object = new Object();
			//cuePt.time = 3.1;
			//cuePt.name = "elapsed_time";
			//cuePt.type = "actionscript";
			//myPLayer.addASCuePoint(cuePt);
			myPLayer.addEventListener(fl.video.VideoEvent.COMPLETE,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.VideoEvent.READY,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.MetadataEvent.CUE_POINT,PlayerEventHandle);
			myPLayer.addEventListener(fl.video.VideoEvent.AUTO_REWOUND, PlayerEventHandle );
			
			
			
			//playheadTime
			if(_isPlay) myPLayer.play();
			//myPLayer.seek(1);
		}
		public function Seek(_n:Number):void
		{
			myPLayer.stop();
			myPLayer.seek(_n);
			myPLayer.play();
			//trace("seek:" + _n);
		}
		private function ClearEvent():void
		{
			if(myPLayer.hasEventListener(fl.video.VideoEvent.COMPLETE)) myPLayer.removeEventListener(fl.video.VideoEvent.COMPLETE,PlayerEventHandle);
			if(myPLayer.hasEventListener(fl.video.VideoEvent.READY)) myPLayer.removeEventListener(fl.video.VideoEvent.READY,PlayerEventHandle);
			if(myPLayer.hasEventListener(fl.video.MetadataEvent.CUE_POINT)) myPLayer.removeEventListener(fl.video.MetadataEvent.CUE_POINT,PlayerEventHandle);
			if(myPLayer.hasEventListener(fl.video.VideoEvent.AUTO_REWOUND)) myPLayer.removeEventListener(fl.video.VideoEvent.AUTO_REWOUND,PlayerEventHandle);
			//if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			//trace("Myplayer ClearEvent");
		}
		public function Clear(){
			myPLayer.stop();
			myPLayer.load("");
			myPLayer.closeVideoPlayer(1);
			ClearEvent();
			this.removeChild(myPLayer);
			//this.removeChild(_square);
			myPLayer = null;
			trace("Myplayer Clear...all" + myPLayer);
		}
		private function PlayerEventHandle(e:Event):void
		{
			var _type:String=e.type.toString();
			//trace("Handle.." + myPLayer.progressInterval);
			switch (_type) {
             
				case "ready" : break;           //首頁
				case "cuePoint"  : break; 
				case "autoRewound" : if(isLoop){ e.target.play();}  break;         //首頁
				case "complete"  : break; 
			}
			//MovieClip(root).VideoEventHandle(_type,e.target);
			var eve:MyEvent = new MyEvent(MyEvent.OBJECK_CLICK);
      		
			eve.data = _type;
			eve.state = "Video";
			//else  eve.state = "Video-Stop";
      		dispatchEvent(eve);
      		eve = null;
		}
		private function mycue_pint(e:Event):void
		{
			//trace("mymycue_pint.." + e.type);
		}
		private function myListener(e:Event) {
 			Clear();
			MovieClip(root).VidComplete(Name);
		}
		//************** Tool ********************
		private function creatArea(_w:int,_h:int,_color:Number,_r):Sprite {
			 var _square:Sprite = new Sprite();
            _square.graphics.beginFill(_color);
            _square.graphics.drawRoundRect(0, 0, _w, _h, _r, _r);
            _square.graphics.endFill();
			return _square;
		}
	}
	
}
