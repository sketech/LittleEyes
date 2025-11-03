package  {
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
	public class Step2Mc extends MovieClip{
		private var Main_Array:Array;
		private var scrollPane:ScrollPane;
		private var Step1Timer:Timer;
		private var CountDTimer:Timer;
		private var Step1Count:int =0;
		public var Item:String="";
		public function Step2Mc(_item:String = "1"){
			//this.stop();
			//this.gotoAndStop(2);
			
			Item = _item;
			Init();
		}
		private function Init():void{

	
				trace("Step2Mc  in:" + Item);
				/*Main_Array = new Array(MC_1,MC_2,MC_3,MC_4,MC_5,MC_6,MC_7,MC_8,MC_9,MC_10,MC_11,MC_12,MC_13,MC_14);
				GotoMove();*/
				Step1Timer = new Timer(1000);				    
				Step1Timer.addEventListener(TimerEvent.TIMER, Step1TimerHandler);
				Step1Timer.start();

				Step1Count = 0 ;
				CountDTimer = new Timer(1000);				    
				CountDTimer.addEventListener(TimerEvent.TIMER, CountDTimerHandler);
				CountDTimer.start();
		}
		public function GoBackFun():void{
			trace("GoBackFun....");
			 //MovieClip(parent).Step1Close();
			 CountDown.text =""+30;
		}
		public function QuitFun():void{
			trace("QuitFun....");
			 MovieClip(parent).Step1Close();
			
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
		private function CountDTimerHandler(e:TimerEvent):void{
             var _CountDownTxt:Number = Number(CountDown.text);
			 _CountDownTxt--;
			 CountDown.text = "" + _CountDownTxt;
			 if(_CountDownTxt <= 0) {
				 CountDTimer.stop();
				 if(Q1.Step == "1" && Item == "14") MovieClip(root).Step2Close(Item,"1");
				 else if(Q1.Step == "2") MovieClip(root).Step2Close(Item,"1");
				 else  MovieClip(root).Step2Close(Item,"0");
			 }
			//trace("CountDTimerHandler:" + _CountDownTxt);
        }
		private function Step1TimerHandler(e:TimerEvent):void{
              Step1Count++;
			
			if(Step1Count == 60){
				
				Step1Count = 0;
				//MovieClip(root).Step1Close();
			}
			//trace("Step1TimerHandle:" + Step1Count);
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
				trace("AddEvent..." + i);
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
			Step1Timer.stop();
			CountDTimer.stop();
			Step1Timer.removeEventListener(TimerEvent.TIMER, Step1TimerHandler);
			CountDTimer.removeEventListener(TimerEvent.TIMER, CountDTimerHandler);
			//this.visible=false;
		}
		public function set dispose(value:String):void{
			RemoveEvent(Main_Array);
		}
		
	}
}