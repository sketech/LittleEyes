package milkmidi.qnx.display {
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import qnx.ui.text.TextInput;	
	public class MyTextInput extends TextInput {
		private var _tf:TextFormat = new TextFormat( null , 20 );
		
		public function MyTextInput() 		{			
		}		
		override protected function getDefaultTextFormat():TextFormat {
			//return super.getDefaultTextFormat();
			return _tf;
		}		
		override protected function getTextRect():Rectangle {
			var rect:Rectangle = super.getTextRect();
			rect.height = height;
			return rect;
		}
	}
}