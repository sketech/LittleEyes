/**
 * @author milkmidi
 */
package milkmidi.qnx.dialogs {  
	import flash.display.*;
	import flash.text.*;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.Spacer;
	import qnx.ui.data.DataProvider;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.text.Label;
    public class ListDialog extends BaseDialog {
		private var topDivider:Spacer;
        protected var titleText		:Label;
        protected var _title		:String;
        protected var _dataProvider	:Array;
        protected var optionsMenu	:List;
		
        public function ListDialog(pWidth:int = 400, pHeight:int = 250, pTitle:String = "", pDatas:Array = null, pSelectIndex:int = -1){			
            this._dataProvider = pDatas || [];
            super(pWidth, pHeight);
            this.title = pTitle;			
        }
		override protected function init():void {						
            addChild(titleText = new Label);			
				
			titleText.textField.defaultTextFormat = new TextFormat( null, null, 0xffffff);
			titleText.x = 0;		
			
            optionsMenu = new List;
			optionsMenu.sizeUnit = SizeUnit.PERCENT;
			optionsMenu.size =  100;			
			
			var d:DataProvider = new DataProvider();
			for (var i:int = 0; i < _dataProvider.length; ++i){
				d.addItem( { label:_dataProvider[i] } );				
			}			
			optionsMenu.dataProvider = d;	
			optionsMenu.selectionMode = ListSelectionMode.SINGLE;
            addChild(this.optionsMenu);
		
			addButtons( "OK", "CANCEL" );	
            super.init();		
		}
        public function set title(ptitle:String) : void        {
            this.titleText.text = ptitle;
            this._title = ptitle;
        }
        public function set dataProvider(pData:Array) : void        {
            this._dataProvider = pData;
        }
    }
}
