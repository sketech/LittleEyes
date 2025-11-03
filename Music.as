package {
	import flash.display.Sprite;
    import flash.events.*;
    import flash.media.Sound;
    import flash.media.SoundChannel;
	 import flash.media.SoundTransform;
    import flash.net.URLRequest;
	public class Music{
		public var n:int;
        public var song:SoundChannel=new SoundChannel();
 		public var soundFactory:Sound = new Sound();
		public var transform1:SoundTransform ;
		
		public var vvv:Number;
		
        public function Music(url:String,n1:int,v:Number) {
           n=n1;
		   vvv=v;
		   var request:URLRequest = new URLRequest(url);
          
            soundFactory.addEventListener(Event.COMPLETE, completeHandler);
            soundFactory.addEventListener(Event.ID3, id3Handler);
            soundFactory.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            soundFactory.addEventListener(ProgressEvent.PROGRESS, progressHandler);
           
			soundFactory.load(request);
			
            transform1= new SoundTransform(v, 0);
        }
		public function v_Mute(){
			transform1.volume=0;
			song.soundTransform = transform1;
		}
		public function v_gogo(){
			transform1.volume=vvv;
			song.soundTransform = transform1;
		}
		public function SetVolume(_v:Number){
			transform1.volume=_v;
			song.soundTransform = transform1;
		}
		public function playGo(){
			song = soundFactory.play(0,n);
			song.soundTransform = transform1;
			//trace("play.***********************");
		}
		public function stopGo(){
			song.stop();
		}
        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
        }

        private function id3Handler(event:Event):void {
            trace("id3Handler: " + event);
        }

        private function ioErrorHandler(event:Event):void {
            trace("ioErrorHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: " + event);
        }
		
		
	}	
}