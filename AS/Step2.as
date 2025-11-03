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
	public class Step2 extends MovieClip{
		private var Main_Array:Array;
		private var scrollPane:ScrollPane;
		private var Step1Timer:Timer;
		private var Step1Count:int =0;
		public function Step2(){
			//this.stop();
			//this.gotoAndStop(2);
			
			
			Init();
		}
		private function Init():void{
			trace("Step2  init..");
		}
		
	}
}