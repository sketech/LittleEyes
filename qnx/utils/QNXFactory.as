/**
 * @author milkmidi
 */
package milkmidi.qnx.utils {		
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.RadioButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.text.Label;	
	public class QNXFactory {		
		public static const SIZE_PERCENT_100:Object = 
		{ 
			size	:100,
			sizeUnit:SizeUnit.PERCENT
		};		
		/**
		 * 建立 Label
		 * @param	pParent 父容器
		 * @param	pLabel 要顯示的文字
		 * @return
		 */
		public static function label(pParent:DisplayObjectContainer , pLabel:String):Label {
			var label:Label = new Label();
			label.text = pLabel;
			pParent.addChild( label );
			return label;
		}		
		/**
		 * 建立 RadioButton
		 * @param	pParent 父容器
		 * @param	pLabel 要顯示的文字
		 * @param	pClick 偵聽點擊事件
		 * @param	pGroupName 群組名稱
		 * @param	pProperty 初始化屬性
		 * @return
		 */
		public static function radioButton( 
			pParent		:DisplayObjectContainer , 
			pLabel		:String , 
			pClick		:Function, 
			pGroupName	:String = "default",  
			pProperty	:Object = null ):RadioButton 
			{
			var radioButton:RadioButton = new RadioButton();
			if (pProperty != null) {				
				for (var a:String in pProperty) {				
					radioButton[a] = pProperty[a];						
				}
			}				
			radioButton.groupname = pGroupName;
			radioButton.label = pLabel;			
			radioButton.addEventListener(MouseEvent.CLICK , pClick );
			pParent.addChild( radioButton);
			return radioButton;
		}		
		/**
		 * 建立 LabelButton
		 * @param	pParent 父容器
		 * @param	pLabel Label名稱
		 * @param	pClick 偵聽 Click 事件
		 * @param	pProperty 初始化的屬性
		 * @return
		 */
		public static function labelButton( 
			pParent		:DisplayObjectContainer, 
			pLabel		:String, 
			pClick		:Function = null, 
			pProperty	:Object = null):LabelButton 	
			{							
			var labelBtn:LabelButton = new LabelButton();
			labelBtn.label = pLabel;
			if (pProperty != null) {				
				for (var a:String in pProperty) {				
					if (a === "scale") {
						labelBtn.scaleX = pProperty[a];
						labelBtn.scaleY = pProperty[a];
					}else {
						labelBtn[a] = pProperty[a];												
					}
				}
			}				
			if (pClick != null) {
				labelBtn.addEventListener(MouseEvent.CLICK , pClick );				
			}
			pParent.addChild( labelBtn );
			return labelBtn;
		}
		
		/**
		 * 建立 Container 物件
		 * @param	pMargins 設定 margin
		 * @param	pDebugColor 設定 debug 色碼
		 * @param	pSize Size 大小, 預設為 100
		 * @param	pSizeUnit size 模式, 預設為 percent
		 * @param	pFlow flow 模式, 預設為 vertical 
		 * @return Container 物件
		 */
		public static function container( 
			pMargins	:int = 0, 
			pDebugColor	:int = -1, 
			pSize		:int = 100 , 
			pSizeUnit	:String = SizeUnit.PERCENT,
			pFlow		:String = ContainerFlow.VERTICAL ):Container 
			{			
			var c:Container = new Container( pSize , pSizeUnit );
			if (pMargins > 0) {				
				c.margins = new <Number>[pMargins,pMargins,pMargins,pMargins];					
			}
			if (pDebugColor > -1) {				
				c.debugColor = pDebugColor;
			}
			c.flow = pFlow;
			return c;			
		}		
	}
}