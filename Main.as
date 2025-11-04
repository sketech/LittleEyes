package  {
	
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.net.URLLoader;
	import flash.net.*;
	import flash.events.*;
	import caurina.transitions.Tweener;
	import flash.net.URLRequest;
	import flash.filters.*;
	import flash.system.*; 
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.*;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.myEvent.MyEvent;
	import MyPlayer;
	import qnx.ui.listClasses.ScrollPane;
    import qnx.ui.listClasses.ScrollDirection;
	import com.button.ButtonUtil;
	import Music;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/*import mx.transitions.Tween;
    import mx.transitions.easing.*;*/
	
	public class Main extends MovieClip {
		
		private var myOpening:MovieClip;
		private var ScreenShowTimer:Timer = new Timer(2000);
		public var scrollPane:ScrollPane;
		private var MainArray:Array ;
		private var Step1Timer:Timer;
		private var Step1Count:int =0;
		private var State:Number  =0;
		private var StepMc:MovieClip;
		private var Step22Mc:MovieClip ;
		private var BgMusic:Music=new Music("background.mp3",99,1);
		public var Item:String="";
		private var FireMcc:MovieClip;//FireMc.OnPlay();
		public function Main() {
			// constructor code
			//addEventListener(Event.ADDED_TO_STAGE, init);
			Init();
		}
		private function Init():void
		{	
			Mouse.hide();
			//removeEventListener(Event.ADDED_TO_STAGE, Init);
			stage.nativeWindow.alwaysInFront = true;
		    stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE; 
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 
			//stage.displayState = StageDisplayState.NORMAL; 
			/*ScreenShowTimer.addEventListener(TimerEvent.TIMER, ScreenShowTimerEven);
			ScreenShowTimer.start();*/
			CreatOpening1();
			BgMusic.playGo();
			
		}
		private function ScreenShowTimerEven(e:TimerEvent):void{
			ScreenShowTimer.stop();
			ScreenShowTimer.removeEventListener(TimerEvent.TIMER, ScreenShowTimerEven);
			trace("Screen time.");
			CreatOpening();
			
		}
		public function AddFireMc():void{
			 FireMcc = new Fireworks();
			addChild(FireMcc);
			//FireMcc.OnPlay();
			Tweener.addTween(this, { time:15,transition: "easeOutBack" ,onComplete:function():void{
				FireMcc.OnStop();
				removeChild(FireMcc);
			}});		
		}
		private function Step_Init(_int:int=0,_move:Boolean=false){
			trace("Step in.." + _int);
			switch (_int) {
             
				//case 0 : StepMc=new Step0(); break;           //首頁
               case 1 : trace("222x:" +  StepMc);
			   			//BgMusic.SetVolume(0.5);
						if(!StepMc){
			   				StepMc=new Step1Mc(); 
			   				StepMc.x = 1920;
							this.addChild(StepMc);
							Tweener.addTween(StepMc, {x:0, time:1,transition: "easeOutBack" ,onComplete:function():void{
								var _isOpen = ScrollBarInstall();
							
							}});			   			
						}
						break;            //說明_輸入手機  
                case 2 :trace("222x:" +  Step22Mc);
						if(!Step22Mc){
							Step22Mc=new Step2Mc();
							Step22Mc.alpha =StepMc.scaleX = StepMc.scaleY = 0;
							Step22Mc.x = stage.mouseX;
							Step22Mc.y = stage.mouseY;
							trace("222x:" +  Step22Mc);
					    	this.addChild(Step22Mc);
							Tweener.addTween(Step22Mc, {scaleX:1,scaleY:1,x:0,y:0,alpha:1, time:2,transition: "easeOutBack" ,onComplete:function():void{
							//var _isOpen = ScrollBarInstall();
							//trace("333x:" +  Step22Mc.x + "  y:" + Step22Mc.y + "  cx:" + Step22Mc.scaleX);
							}});
						}
						break;         //3大區選擇頁面
				
				
                //case 3 : StepMc=new Step3(1); break;          //3大區的子項功能選擇頁面  1.雲端運算 
			}
			
			
		}
		public function Step_Remove(_inN:int=0,_remove:int = 1){
			if(_inN == 0){
				Tweener.addTween(StepMc, {x:-3840, time:1,transition: "easeInBack" ,onComplete:function():void{
					if(_remove == 1){
						try {
							if(Step22Mc) {
								Step22Mc.Quit();
								this.removeChild(Step22Mc);
								Step22Mc = null;
							}
							if(StepMc) {
								StepMc.Quit();
								if(StepMc) {
									//this.removeChild(StepMc);
									//trace("Step_Remove 222222"); 
									StepMc = null;
								}
								
								//StepMc.CloseStep2(_item);
							}
						}catch(error:Error){
    						//here you process error
    						//show it to user or make LOG
						}
						removeChild(scrollPane); 
						scrollPane =null;
						//StepMc.Quit(); 
					}
					else StepMc.Quit();
					MyBgMc.play();
				}});	
			}else if(_inN == 2){
				Step_Init(_inN); 
			}
			
			
		}
		//******** step1 **********
		private function ScrollBarInstall():Boolean{
			if(scrollPane) { scrollPane.setPosition(0,0);return true;}
			scrollPane = new ScrollPane();
		    addChild(scrollPane);
		    scrollPane.setSize(1930, 1080);
		    scrollPane.setPosition(0,0);
		    scrollPane.setScrollContent(StepMc);
		    //scrollPane.scrollDirection = ScrollDirection.VERTICAL; //horizontal
			scrollPane.scrollDirection = ScrollDirection.HORIZONTAL; 
			return false;
		}
		public function Step2Close(_item:String = "1",_str:String = "0"):void{
			trace("Step2Close****8**item:" + _item + "  str:" + _str);
			Tweener.addTween(Step22Mc, {y:0, time:.5,transition: "easeInBack" ,onComplete:function():void{
				if(Step22Mc) {
					StepMc.Step1Timer.start(); 
					StepMc.Step1Count = 0;
					Step22Mc.Quit();
					removeChild(Step22Mc);
					Step22Mc = null;
					if(_str == "1"){
						StepMc.CloseStep2(_item);
					}

				}
			}});	
		}
		public function Step2In(_n:String):void{
			if(!Step22Mc){
				var _Number:Number = Number(_n);
				Step22Mc=new Step2Mc(_n);
		    	trace("2222222222222222222x:" );
				Item = _n;
				this.addChild(Step22Mc);
   				Step22Mc.y = -1080;
				Tweener.addTween(Step22Mc, {y:0, time:1,transition: "easeOutBack" ,onComplete:function():void{
							
				}});	
			}
		}
		private function Step1Close():void{
			State = 0;
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
			}});
		}
		private function Step1TimerHandler(e:TimerEvent):void{
            if(State == 1) Step1Count++;
			else Step1Count = 0;
			if(Step1Count == 10){
				Step1Close();
				Step1Count = 0;
			}
			trace("Step1TimerHandle:" + Step1Count);
        }

		private function GotoMove():void{
			for(var i=0; i < MainArray.length; i++){
				var NNN:int =Math.ceil(Math.random()*60); /*產生1~8亂數整數*/
				MainArray[i].gotoAndPlay(NNN);
			}
		}
		//*************************
		//*******  Opening *******
		private function CreatOpening1():void{
			//MyBgMc.addEventListener(TouchEvent.TOUCH_BEGIN, TouchDownHandler); 
			MyBgMc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);		
		}
		private function CreatOpening():void{
			myOpening = new MyPlayer(1920,1080,"Resources//Opening//Opening.mp4",true,true);
			myOpening.addEventListener(MyEvent.OBJECK_CLICK, Object3D_Click);
			//OpeningMc.addChild(myOpening);
			myOpening.x=myOpening.y=0;
			myOpening.Play();
			myOpening.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);		
			//myOpening.addEventListener(TouchEvent.TOUCH_BEGIN, TouchDownHandler); 
			this.addChild(myOpening);
			
			State=0;
		}
		private function Object3D_Click(e:MyEvent):void{
			//if(e.data != "complete") return;
			//myOpening.x=myOpening.y=myOpening1.x=myOpening1.y =0;
			trace("Video..state:" + e.data);
			if(e.data == "autoRewound"){
				//myOpening.Seek(3);
				
			}
		}
		//***********************************
		private function MouseEventHandle(e:Event):void{
			//delayBTN(MovieClip(e.target));
			//trace("mouseClick.." + e.target.name + ".." + Smc);
			if(!ButtonUtil.SetBrightness(DisplayObject(e.target))) return;
			trace("mouseClick.." + e.target.name);
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
			Step1Count=0;
			
		}
		private function TouchDownHandler(event:TouchEvent) { 
			if(!ButtonUtil.SetBrightness(DisplayObject(event.target))) return;
			
			//myOpening.removeEventListener(MyEvent.OBJECK_CLICK, Object3D_Click);
			/*myOpening.removeEventListener(TouchEvent.TOUCH_BEGIN, TouchDownHandler); 
			trace("mouseDownHandler click..." );*/
			MyBgMc.stop();
			//Step1In();
			Step_Init(1);
        }
		private function mouseDownHandler(event:MouseEvent):void {
			if(!ButtonUtil.SetBrightness(DisplayObject(event.target))) return;
			
			MyBgMc.stop();
			//Step1In();
			Step_Init(1);
        }
		private function AddEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				trace("AddEvent click..." + i);
				_array[i].buttonMode = true;
				_array[i].mouseChildren = false;
				_array[i].addEventListener(MouseEvent.CLICK,MouseEventHandle);
			}
		}
		private function RemoveEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				//ButtonUtil.setEnable(DisplayObject(_array[i]));
				if(_array[i].hasEventListener(MouseEvent.CLICK))
					_array[i].removeEventListener(MouseEvent.CLICK,MouseEventHandle);
			}
		}
		// ******************* 
		//************step1 ************
		
	}
	
}
