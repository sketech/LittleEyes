/**
 * @author milkmidi
 */
package milkmidi.qnx.dialogs {
	import flash.display.Bitmap;
	import milkmidi.utils.SharedColorCache;
	import qnx.ui.core.InvalidationType;
	import qnx.ui.core.UIComponent;
    public class DialogBackground extends UIComponent    {
        public var outer:Bitmap;
        public var inner:Bitmap;

        public function DialogBackground()  {			
            this.outer = new Bitmap(SharedColorCache.setColor('backgroundLight', 4013373));			
            addChild(this.outer);
            this.inner = new Bitmap(SharedColorCache.setColor('backgroundDark', 2631720));			
            addChild(this.inner);
        }
		override protected function draw():void { 		
			if (isInvalid(InvalidationType.SIZE)) {
				this.outer.width = width;
				this.outer.height = height;
				this.inner.x = 1;
				this.inner.y = 1;
				this.inner.width = width - 2;
				this.inner.height = height - 2;				
			}			
			super.draw();		
        }
    }
}
