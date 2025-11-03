package
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import Music;
	//[SWF(width=1920, height=1080, backgroundColor=0x000000, frameRate=30)]
	public class Fireworks extends MovieClip
	{
		//private var txt:TextField;
		private var interval:int;
		private var tempx:Number;
		private var isDestroy:Number;
		private var  holder:Sprite;
		private var _t:int;
		private var _pt:int;
		private var _p:Dictionary;
		private var bmp:Bitmap;
		private var BgMusic:Music=new Music("煙火.mp3",99,1);
		
		public function Fireworks()
		{
			/*stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;*/
			
			//txt = addChild(new TextField()) as TextField;
			interval = 38;
			holder = addChild(new Sprite()) as Sprite;
			_pt = -interval;
			_p = new Dictionary();
			bmp = addChild(new Bitmap(new BitmapData(1920, 1080, true, 0))) as Bitmap;
			OnPlay();
			/*stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);*/
		}
		public function OnPlay():void{
			addEventListener(Event.ENTER_FRAME, onEnterFrame)
			BgMusic.playGo();
		}
		public function OnStop():void{
			BgMusic.stopGo();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame)
		}
		private function onMouseClick(e:Event):void
		{
			isDestroy = 1
			//trace("onMouseClick:" + isDestroy);
		}
		private function onMouseWheel(e:MouseEvent):void
		{
			interval += ((interval + (e.delta * 33)) < 0) ? 0 : e.delta * 33
			//trace("onMouseWheel:" + interval + "  e.delta" + e.delta);
		}
		private function onEnterFrame(e:Event):void
		{
			bmp.bitmapData.applyFilter(bmp.bitmapData, bmp.bitmapData.rect, new Point(), new ColorMatrixFilter([0.93, 0, 0, 0, 0, 0, 0.85, 0, 0, 0, 0, 0, 0.9, 0, 0, 0, 0, 0, .9, 0]));
			for each (var p:Object in _p) 
			{
				(p.type == "r" && ((_t - p.tS) > p.lS || isDestroy == 1)) ? emit("s2", {x:p.t.x, y:p.t.y}, p.color, 40) : (p.type == "r") ? emit("s", {x:p.t.x, y:p.t.y}, 1) : null;
				if((_t - p.tS) > p.lS || (p.type == "r" && isDestroy-- == 1)) delete _p[holder.removeChild(p.t)];
				p.v = { x:p.v.x * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1), y:(p.v.y + ((p.type == "r") ? 0.35 : (p.type == "s") ? -0.03 : 0.2)) * ((p.type == "s") ? 0.99 : (p.type == "s2") ? 0.91 : 1) };
				p.t.transform.matrix = new Matrix((p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), (p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x)), -((p.t.scaleY * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.sin(Math.atan2(p.v.y, p.v.x))), (p.t.scaleX * ((p.type == "r") ? 0.98 : (p.type == "s") ? 1.02 : 0.9)) * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x + p.v.x, p.t.y + p.v.y);
				bmp.bitmapData.draw(p.t, new Matrix(p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x)), -(p.t.scaleY * Math.sin(Math.atan2(p.v.y, p.v.x))), p.t.scaleX * Math.cos(Math.atan2(p.v.y, p.v.x)), p.t.x, p.t.y), new ColorTransform(1, 1, 1, 0.98));
			}
			//txt.htmlText = "<font face='_sans' color='#333333' size='25'><b>" + Number(interval / 1000).toFixed(1) + "s Delay (Scroll to Change) / Click to Explode</b></font>";
			if (((_t = getTimer() + 550) - _pt) >= interval) emit("r", {x:((Math.random()*800) +500), y:800}, 1);
		}
		private function emit(type:String, pt:Object, color:Number = NaN, num:uint = 1):void 
		{
			//if (type == "r") txt.width = 
			//trace("emit.." + num);
			_pt = _t;
			for (var i:int = 0; i < num; i++) 
			{
				//trace(i + "emit.." + num);
				var p:Object = {type:type, tS:_t, t:holder.addChild(new Sprite()), color:Math.random() * 0xFFFFFF, lS:(type == "r") ? 2000 : (type == "s") ? 1660 : 1300, v:(type == "r") ? {x:Math.random() * (5 - -5) + -5,y:-20} : (type == "s") ? {x:Math.random() * (0.25 - -0.25) + -0.25, y:0} : {x:(tempx = (Math.random() * (20 - 10) + 10)) * Math.cos((Math.random()*360) * (180 / Math.PI)), y:tempx * Math.sin((Math.random()*360) * (180 / Math.PI))}};
				(type == "s") ? p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF], [0.1, 0.012], [0, 255], new Matrix(0.023, 0, 0, 0.023)) : (type == "r") ? p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF, p.color, p.color], [1, 1, 0.25, 0.25], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0)) : p.t.graphics.beginGradientFill("radial", [0xFFFFFF, 0xFFFFFF, color, color], [0.5, 0.5, 0.075, 0.075], [0, 150, 151, 255], new Matrix(0.0213, 0, 0, 0.0024, 0, 0));
				(type == "s") ? p.t.graphics.drawCircle(0, 0, 20) : p.t.graphics.drawEllipse(-21, -5.5, 42, 11);
				p.t.transform.matrix = new Matrix(((type == "r") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), 0, 0, ((type == "r") ? 1 : (type == "s") ? Math.random() * (0.5 - 0.25) + 0.25 : Math.random() * (2.3 - 1.5) + 1.5), pt.x, pt.y);
				_p[p.t] = p;
			}
		}
	}
	
}