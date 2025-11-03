/**
 * @author milkmidi
 */
package milkmidi.qnx.display {		
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import milkmidi.display.MSprite;
	import net.hires.debug.Stats;
	import qnx.ui.core.Container;
	/**
	 * 繼承 MSprite
	 */
	public class QnxMain extends MSprite {			
		// Container , 之後的 QNX 元件都被加入至此物件。
		private var _container:Container;
		public function get container():Container {	return _container;		}		
		
		// 是否出現效能檢示器 
		private var _showStats:Boolean;			
		public function QnxMain(pShowStats:Boolean = true) {			
			_showStats = pShowStats;			
			super();
		}					
		/**
		 * 當被加入至場景上時
		 */
		override protected function atAddedToStage():void {	
			// 場景的對齊模式為左、上。
			stage.align = StageAlign.TOP_LEFT;				
			// 場景的縮放模式為不縮放。
			stage.scaleMode = StageScaleMode.NO_SCALE;				
			// 建立 Container 物件
			_container = new Container;						
			addChild( _container );				
			// 建立子物件
			createChildren();				
			// 加入效能檢示器。
			if (_showStats) {
				var stats:Stats = new Stats();
				stats.scaleX = 1.5;
				stats.scaleY = 1.5;
				addChild( stats );
			}			
			// 偵聽焦點為 swf 檔時
			stage.addEventListener(Event.ACTIVATE  , onActivateHandler);			
			// 偵聽焦點離開 swf 檔時
			stage.addEventListener(Event.DEACTIVATE  , onActivateHandler);	
		}		
		private function onActivateHandler(e:Event):void {
			switch (e.type) {
				case Event.ACTIVATE:
					stage.frameRate = 30;
					break;
				case Event.DEACTIVATE:
					stage.frameRate = 0.0000001;
					break;
			}
		}
		/**
		 * 建立子元件。
		 */
		protected function createChildren():void {	}
		
		// 當場景大小有更改時
		override protected function atResize():void {
			// 將主 Container 大小設置成和場景一樣的大小。
			_container.setSize( stage.stageWidth, stage.stageHeight );			
		}		
		override protected function atRemovedFromStage():void {
			stage.removeEventListener(Event.ACTIVATE  , onActivateHandler);
			stage.removeEventListener(Event.DEACTIVATE  , onActivateHandler);	
		}		
	}
}