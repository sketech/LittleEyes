/**
 * @author milkmidi
 */
package milkmidi.qnx.display {		
	import flash.display.MovieClip;
	import qnx.ui.core.InvalidationType;
	import qnx.ui.events.SliderEvent;
	import qnx.ui.slider.Slider;
	import qnx.ui.text.Label;
	import swc.Slider.Shadow_mc;
	import swc.Slider.Track_mc;	
	public class IOSSlider extends Slider {			
		private var _label	:Label;
		private var _shadow	:MovieClip;
		
		public function IOSSlider()  {						
		}		
		override protected function init():void {
			_label = new Label();
			_shadow = new Shadow_mc;
			_shadow.mouseEnabled = false;
			_shadow.mouseChildren = false;
			_shadow.cacheAsBitmap = true;
			__defaultThumbSkin = ThumbSkin;
			__defaultFillSkin = FillSkin;			
			__defaultTrackSkin = Track_mc;
			super.init();
			addChildAt( _shadow,1 );
			addChild( _label );					
			addEventListener( SliderEvent.MOVE , onMoveHandler);
		}		
		private function onMoveHandler(e:SliderEvent):void {
			_label.text = value.toFixed(2);
		}
		override protected function validate(property:String = "all"):void {
			if ( isInvalid( InvalidationType.SIZE) ) {
				_label.x = width + 5;
				_shadow.width = width;
			}
			super.validate(property);
		}
		override protected function positionChildren():void {
			super.positionChildren();
			_shadow.y = track.y;
		}		
		override protected function onRemoved():void {
			removeEventListener( SliderEvent.MOVE , onMoveHandler);
			super.onRemoved();
		}		
	}
}
import flash.display.MovieClip;
import flash.display.Sprite;
import qnx.ui.skins.SkinStates;
import qnx.ui.skins.UISkin;
import swc.Slider.Fill_mc;
import swc.Slider.Thumb_mc;
class ThumbSkin extends UISkin {	
	private var _skin:MovieClip;
	override protected function initializeStates():void {
		_skin = new Thumb_mc;
		setSkinState(SkinStates.UP, _skin );		
		showSkin( _skin );
	}	
	override public function get state():String {
		return super.state;
	}	
	override public function set state(value:String):void {
		super.state = value;
		
		if (state == SkinStates.UP) {			
			_skin.alpha = 1;			
		}else if (state == SkinStates.DISABLED) {
			_skin.alpha = .5;
		}
		_skin.gotoAndStop( state );
	}
}
class FillSkin extends UISkin { 
	private var upSkin:Sprite;
	override protected function initializeStates():void {
		upSkin = new Fill_mc;
		setSkinState(SkinStates.UP, upSkin );
		showSkin( upSkin );
	}
	override public function set state(value:String):void {
		super.state = value;
		if (state == SkinStates.UP) {
			upSkin.alpha = 1;			
		}else if (state == SkinStates.DISABLED) {
			upSkin.alpha = .5;
		}	
	}
}