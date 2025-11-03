/**
 * @author milkmidi
 */
package milkmidi.qnx.dialogs {	
	import flash.events.MouseEvent;
	import milkmidi.managers.DialogManager;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
    public class BaseDialog extends Container {		
        protected var buttonContainer:Container;
        protected var buttonList	:Array;

        public function BaseDialog( pWidth:int = 400, pHeight:int = 250)        {			
			super();			
			this.setSize( pWidth, pHeight );
        }
		override protected function init():void {			
			super.init();
			var bg:DialogBackground = new DialogBackground();
			bg.alpha = 0.3;
			bg.containment = Containment.BACKGROUND;
            addChildAt(bg, 0);				
			this.margins = new <Number>[10,10,10,10];				           
        }
		override protected function onAdded():void {
			this.setPosition( stage.stageWidth - width >> 1 , stage.stageHeight - height >> 1);
		}		
		override public function setSize(width:Number, height:Number):void {
			trace( "BaseDialog.setSize > width : " + width + ", height : " + height );		
			super.setSize(width, height);
		}
        public function addButtons( ...buttons:Array) : void{
            if (buttonContainer == null) {				
                buttonContainer = new Container();
				buttonContainer.sizeMode = SizeMode.BOTH;
				buttonContainer.flow = ContainerFlow.HORIZONTAL;
				buttonContainer.size = 20;
				buttonContainer.margins = new <Number>[10,8,10,8];								
				addChild( buttonContainer );				
            }
            this.buttonContainer.removeChildren();
            var i:int = 0;
            var _length:int= buttons.length;
            while (i < _length)        {                
                var _btn:LabelButton = new LabelButton();
                _btn.label = buttons[i];
				_btn.sizeUnit = SizeUnit.PERCENT;
				_btn.size = 50;
				
                _btn.addEventListener(MouseEvent.CLICK, this.onButtonClicked, false, 0, true);
                this.buttonContainer.addChild(_btn);
                i++;
            }
        }		
        protected function onButtonClicked(event:MouseEvent) : void {
			DialogManager.removeDialogs();
        }
    }
}
