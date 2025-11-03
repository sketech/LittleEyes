/**
 * @author milkmidi
 */
package milkmidi.qnx.display {		
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import milkmidi.pool.IObjectPool;
	import milkmidi.pool.ObjectPool;
	import milkmidi.utils.DeviceUtil;
	import qnx.ui.core.InvalidationType;
	import qnx.ui.core.UIComponent;		
	public class Toast extends UIComponent implements IObjectPool {	
		[Embed(source = "../asset/toast_frame_holo.png", 
			scaleGridLeft = "14",
			scaleGridTop = "14",
			scaleGridRight = "130",
			scaleGridBottom = "46")]					
		private static const TOAST_FRAME_HOLO:Class;
		private static const IS_DESKTOP	:Boolean = Mouse.supportsCursor
		private static var textFormat	:TextFormat;
		public static const LENGTH_LONG	:int = 2000;
		public static const LENGTH_SHORT:int = 1000;		
		private var _charSquence:String;
		private var _duration	:int = 1000;
		private var _timer		:Timer;
		private var _tf			:TextField;
		private var _stage		:Stage;		
		private var _frame:Sprite;
		private var _destroyed:Boolean = false;		
		
		public function Toast()  {			
			super();						
			if ( textFormat == null) {
				var fontSize:int = DeviceUtil.dpiScale * 20;			
				textFormat =  new TextFormat(null, fontSize, 0xffffff);					
				textFormat.align = TextFormatAlign.CENTER;
			}			
			addChild( this._tf = new TextField);
			this._tf.defaultTextFormat = textFormat;
			this._tf.autoSize = TextFieldAutoSize.CENTER;
		
			this._frame = new TOAST_FRAME_HOLO();
			this.addChildAt( _frame, 0 );			
			this.setSize( 250, 60 );			
		}			
		override protected function onAdded():void {	
			var w:int = IS_DESKTOP ? stage.stageWidth : stage.fullScreenWidth;
			var h:int = IS_DESKTOP ? stage.stageHeight : stage.fullScreenHeight;
			this.x = (w - width) >> 1;			
			this.y = h - height - 100;					
		}		
		override protected function draw():void {
			if (isInvalid( InvalidationType.SIZE ) ) {
				this._frame.x = -3;
				this._frame.y = -3;
				this._frame.width = this.width + 6;				
				this._frame.height = this.height + 10;				
				this._tf.x = width -this. _tf.textWidth >> 1;
				this._tf.y = (height - this._tf.height >> 1) + 2;								
			}
			super.draw();
		}		
		/**
		 * Return the duration.
		 * @return int;
		 */
		public function getDuration():int {	return this._duration;		}		
		/**
		 * Show the view for the specified duration.
		 */
		public function show():void {
			if ( _timer != null ) {
				return;
			}
			this._timer = new Timer( _duration, 1);			
			this._timer.addEventListener(TimerEvent.TIMER_COMPLETE , onTimerComplete);
			this._timer.start();
			this._stage.addChild(this);
			this.alpha = 0;
			this.cacheAsBitmap = true;			
			if ("cacheAsBitmapMatrix" in this) {
				this['cacheAsBitmapMatrix'] = new Matrix;
			}			
			TweenMax.to( this , .5, {
				alpha		:1,
				ease		:Cubic.easeInOut
			} );			
		}
		private function onTimerComplete(e:TimerEvent):void {			
			this.cancel();
		}	
		/**
		 * Close the view if it's showing, or don't show it if it isn't showing yet.
		 */
		public function cancel():void {
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE , onTimerComplete);			
			this._timer.stop();
			this._timer = null;
			TweenMax.to( this , .5, {
				alpha		:0,
				ease		:Cubic.easeInOut,
				onComplete	:recycle
			} );				
		}
		override public function destroy():void {
			if (_destroyed) {
				return;
			}
			this._destroyed = true;
			super.destroy();
		}	
		public function setDuration( pDuration:int ):void {
			this._duration = pDuration;
		}
		public function setText( pCharSequence:String ):void {			
			this._tf.text = pCharSequence;	
			this.setSize( _tf.textWidth + 30 , _tf.textHeight + 20 );
		}		
		/**
		 * Make a standard toast that just contains a text view.
		 * @param	pContainer
		 * @param	pCharSequence
		 * @param	pDuration
		 * @return
		 */
		public static function makeText( pStage:Stage, pCharSequence:*, pDuration:int = Toast.LENGTH_LONG):Toast {									
			var _toast:Toast = Toast.obtain();
			_toast.setDuration( pDuration );
			_toast.setText( pCharSequence + "" ) ;
			_toast._stage = pStage;
			return _toast;
		}		
		private static function obtain():Toast {
			return ObjectPool.obtain( Toast ) as Toast;
		}		
		/* INTERFACE milkmidi.pool.IObjectPool */		
		public function onPoolInit(...params:Array):void {			
		}		
		public function recycle():void {
			this._stage.removeChild( this );
			this._stage = null;	
			ObjectPool.recycle( this , Toast );
		}		
		public function get destroyed():Boolean {
			return this._destroyed;
		}
	}	
}

