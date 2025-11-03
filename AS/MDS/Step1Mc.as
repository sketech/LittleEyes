package AS {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	import flash.events.TextEvent;
	import flash.utils.ByteArray;
	import caurina.transitions.Tweener;
	import com.myEvent.MyEvent;
	import com.button.ButtonUtil;
	import qnx.ui.listClasses.ScrollPane;
    import qnx.ui.listClasses.ScrollDirection;//AS.Step1
	public class Step1Mc extends MovieClip{
		private var Main_Array:Array;
		private var scrollPane:ScrollPane;
		private var Step1Timer:Timer;
		private var Step1Count:int =0;
		public function Step1Mc(){
			//this.stop();
			//this.gotoAndStop(2);
			
			
			Init();
		}
		private function Init():void{
			AddEvent(Main_Array);
			Tweener.addTween(this, {time:1,onComplete:function():void{
				ScrollBarInstall();
				GotoMove();
				Step1Timer = new Timer(1000);				    
				Step1Timer.addEventListener(TimerEvent.TIMER, Step1TimerHandler);
				Step1Timer.start();

				Step1Count = 0 ;

				Main_Array = new Array(MC_1,MC_2,MC_3,MC_4);
				AddEvent(Main_Array);
			}});	
		}
		private function Step1Close():void{
/*			State = 0;
			myOpening.visible=true;
			Tweener.addTween(myOpening, {alpha:1, time:1,transition:"linear",onComplete:function():void{
				trace("Step1Close:" + myOpening.alpha + "  visible:" + myOpening.visible  + "  yy:" + myOpening.y );
				myOpening.Play();
				myOpening.addEventListener(MyEvent.OBJECK_CLICK, Object3D_Click);
				//用「numChildren-1」找到母影片片段(parent)的最高深度
				var highestDepth:uint=myOpening.parent.numChildren-1;
				//用setChildIndex來設置最高深度
				myOpening.parent.setChildIndex(myOpening,highestDepth);
				//new Tween(Bg, "_x",Regular.easeIn, 20,500,40,false);
			}});*/
		}
		private function Step1TimerHandler(e:TimerEvent):void{
              Step1Count++;
			
			if(Step1Count == 10){
				Step1Close();
				Step1Count = 0;
			}
			trace("Step1TimerHandle:" + Step1Count);
        }
		private function ScrollBarInstall():Boolean{
			if(scrollPane) { scrollPane.setPosition(0,0);return true;}
			scrollPane = new ScrollPane();
		    addChild(scrollPane);
		    scrollPane.setSize(1920, 1080);
		    scrollPane.setPosition(0,0);
		    scrollPane.setScrollContent(this);
		    //scrollPane.scrollDirection = ScrollDirection.VERTICAL; //horizontal
			scrollPane.scrollDirection = ScrollDirection.HORIZONTAL; 
			return false;
		}
		private function GotoMove():void{
			for(var i=0; i < Main_Array.length; i++){
				var NNN:int =Math.ceil(Math.random()*60); /*產生1~8亂數整數*/
				Main_Array[i].gotoAndPlay(NNN);
			}
		}
		private function MouseEventHandle(e:Event):void{
			//delayBTN(MovieClip(e.target));
			trace("mouse..clicl"+ e.target.name);
			if(!ButtonUtil.SetBrightness(DisplayObject(e.target))) return;
			e.target.play();
			switch (e.target.name) {
             
				case "MC_1" :  break;
				case "MC_" : e.target.visible = true;  break;
				case "Smc" : {
					// Smc.Clear();
					/* Tweener.addTween(Smc, {alpha:0, time:.5,transition:"easeOutExpo",onComplete:function():void{
						//Smc.x=-Smc.width;
						
					 }});	*/
					break;}
			}
		}
		private function AddEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				_array[i]..buttonMode = true;
				_array[i]..mouseChildren = false
				_array[i].addEventListener(MouseEvent.CLICK,MouseEventHandle);
			}
		}
		private function RemoveEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				_array[i].removeEventListener(MouseEvent.CLICK,MouseEventHandle);
			}
		}
		
		private function trim( s:String ):String
		{
  			return s.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
		}
		//****************************************************************
		//****************************************************************
		public function Quit():void{
			RemoveEvent(Main_Array);
			//MyName.Txt.removeEventListener(TextEvent.TEXT_INPUT, onTextInput);
			this.visible=false;
		}
		public function set dispose(value:String):void{
			RemoveEvent(Main_Array);
		}
		
	}
}