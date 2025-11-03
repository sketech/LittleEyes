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
	import Music;
	public class Step1Mc extends MovieClip{
		private var Main_Array:Array;
		private var MainOk_Array:Array;
		private var scrollPane:ScrollPane;
		public var Step1Timer:Timer;
		public var Step1Count:int =0;
		private var StepMc:MovieClip;
		private var TouchX:Number=0;
		private var TouchY:Number=0;
		public var Item:String = "";
		private var ClickMusic2:Music=new Music("Click.mp3",1,1);
		private var isFast:Boolean = true;
		private var isRemove:Boolean = false;
		
		public function Step1Mc(){
			//this.stop();
			//this.gotoAndStop(2);
			
			
			Init();
		}
		private function Init():void{

			/*Tweener.addTween(this, {time:1,onComplete:function():void{*/
				
				Main_Array = new Array(MC_1,MC_2,MC_3,MC_4,MC_5,MC_6,MC_7,MC_8,MC_9,MC_10,MC_11,MC_12,MC_13,MC_14);
				//MainOk_Array = new Array
				SetBtnState(Main_Array);
				GotoMove();
				Step1Timer = new Timer(1000);				    
				Step1Timer.addEventListener(TimerEvent.TIMER, Step1TimerHandler);
				Step1Timer.start();

				Step1Count = 0 ;
				AddEvent(Main_Array);
				trace("Step1 Width:" + this.width + "  h:" + this.height);
				//FireMc.OnPlay();
				/*Main_Array[2].OkMc.visible =true;
			    Main_Array[2].OkMc.play();*/
				//ScrollBarInstall();
			/*}});	*/
		}
		private function SetBtnState(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				_array[i].State = "0";
				_array[i].OkMc.visible =false;
			}
		}
		public function CloseStep2(_str:String){
			Main_Array[Number(_str) -1].OkMc.visible =true;
			Main_Array[Number(_str)-1].OkMc.play();
			Main_Array[Number(_str) -1].State = "1";
			CheckState(Main_Array);
		}
		private function CheckState(_array:Array):void{
			var _length:int=_array.length;
			var _Nubmer:int = 0;
			for(var i:int=0; i< _length ; i++){
				if(_array[i].State == "1"){
					_Nubmer++;
				}
			}
			if(_Nubmer >=14) MovieClip(root).AddFireMc();
		}
		public function Step1Close():void{
		
			//this.addChild(StepMc);
			Tweener.addTween(StepMc, {scaleX:0,scaleY:0,x:TouchX,y:TouchY, time:1,transition: "linear" ,onComplete:function():void{
							if(StepMc) {
								StepMc.Quit();
								removeChild(StepMc);
								StepMc = null;
								Step1Timer.start();
								Step1Count = 0;
							}
			}});			
		}
		private function Step1TimerHandler(e:TimerEvent):void{
              Step1Count++;
			
			if(Step1Count == 15){
				isRemove = true;
				Step1Count = 0;
				MovieClip(root).Step_Remove(0,1);
			}else if(Step1Count % 5 == 0) GotoMove();
			
        }
		private function Step_Init(_int:int=0,_str:String="1"){
			trace("Step in.." + _int);
			Step1Timer.stop();
			switch (_int) {
               case 1 : trace("222x:" +  StepMc);
			 		   			
						break;            //說明_輸入手機  
                case 2 :
						MovieClip(root).Step2In(_str);
			
						break;         //3大區選擇頁面
			}
			
			
		}
		private function GotoMove():void{
			var _n:int = 0;
			if(isFast) _n =0;
			else _n =1;
			for(var i=_n; i < Main_Array.length; i++){
				if(Main_Array[i].State == "0"){
					var NNN:int =Math.ceil(Math.random()*60); /*產生1~8亂數整數*/
				
					Main_Array[i].gotoAndPlay(NNN);
					i++;
				}
			}
			if(isFast) isFast=false;
			else isFast = true;
		}
		private function MouseEventHandle(e:Event):void{
			//delayBTN(MovieClip(e.target));
			Step1Count = 0;
			if(isRemove) return;
			//trace("mouse..clicl"+ e.target.name + "  state:" +e.target.State);
			if(!ButtonUtil.SetBrightness(DisplayObject(e.target))) return;
			
			ClickMusic2.playGo();
			//Main_Array[Number(_str) -1].State = "1";
			if(e.target.State == "1") {e.target.AnswerMc.play();return;}
			e.target.play();
			switch (e.target.name) {
             
				case "MC_1" : Item = "1";  Step_Init(2,"1"); break;
				case "MC_2" : Item = "2";  Step_Init(2,"2"); break;
				case "MC_3" : Item = "3";  Step_Init(2,"3"); break;
				case "MC_4" : Item = "4";  Step_Init(2,"4"); break;
				case "MC_5" : Item = "5";  Step_Init(2,"5"); break;
				case "MC_6" : Item = "6";  Step_Init(2,"6"); break;
				case "MC_7" : Item = "7";  Step_Init(2,"7"); break;
				case "MC_8" : Item = "8";  Step_Init(2,"8"); break;
				case "MC_9" : Item = "9";  Step_Init(2,"9"); break;
				case "MC_10" :Item = "10";  Step_Init(2,"10"); break;
				case "MC_11" : Item = "11";  Step_Init(2,"11"); break;
				case "MC_12" :Item = "12";  Step_Init(2,"12"); break;
				case "MC_13" : Item = "13";  Step_Init(2,"13"); break;
				case "MC_14" :Item = "14";  Step_Init(2,"14"); break;
				
			}
		}
		private function TouchDownHandler(e:Event):void{
			//delayBTN(MovieClip(e.target));
			Step1Count = 0;
			if(isRemove) return;
			//trace("mouse..clicl"+ e.target.name + "  state:" +e.target.State);
			if(!ButtonUtil.SetBrightness(DisplayObject(e.target))) return;
			
			ClickMusic2.playGo();
			//Main_Array[Number(_str) -1].State = "1";
			if(e.target.State == "1") {e.target.AnswerMc.play();return;}
			e.target.play();
			switch (e.target.name) {
             
				case "MC_1" : Item = "1";  Step_Init(2,"1"); break;
				case "MC_2" : Item = "2";  Step_Init(2,"2"); break;
				case "MC_3" : Item = "3";  Step_Init(2,"3"); break;
				case "MC_4" : Item = "4";  Step_Init(2,"4"); break;
				case "MC_5" : Item = "5";  Step_Init(2,"5"); break;
				case "MC_6" : Item = "6";  Step_Init(2,"6"); break;
				case "MC_7" : Item = "7";  Step_Init(2,"7"); break;
				case "MC_8" : Item = "8";  Step_Init(2,"8"); break;
				case "MC_9" : Item = "9";  Step_Init(2,"9"); break;
				case "MC_10" :Item = "10";  Step_Init(2,"10"); break;
				case "MC_11" : Item = "11";  Step_Init(2,"11"); break;
				case "MC_12" :Item = "12";  Step_Init(2,"12"); break;
				case "MC_13" : Item = "13";  Step_Init(2,"13"); break;
				case "MC_14" :Item = "14";  Step_Init(2,"14"); break;
				
			}
		}
		private function AddEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				/*_array[i].buttonMode = true;
				_array[i].mouseChildren = false*/
				//_array[i].addEventListener(MouseEvent.CLICK,MouseEventHandle);
				_array[i].addEventListener(TouchEvent.TOUCH_BEGIN, TouchDownHandler); 
			}
		}
		private function RemoveEvent(_array:Array):void{
			var _length:int=_array.length;
			for(var i:int=0; i< _length ; i++){
				//_array[i].removeEventListener(MouseEvent.CLICK,MouseEventHandle);
				_array[i].removeEventListener(TouchEvent.TOUCH_BEGIN, TouchDownHandler); 
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
			Step1Timer.stop();
			Step1Timer.removeEventListener(TimerEvent.TIMER, Step1TimerHandler);

			//MyName.Txt.removeEventListener(TextEvent.TEXT_INPUT, onTextInput);
			this.visible=false;
		}
		public function set dispose(value:String):void{
			RemoveEvent(Main_Array);
		}
		
	}
}