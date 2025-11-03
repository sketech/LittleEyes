  package  {
  import flash.display.MovieClip;
  import flash.display.DisplayObject;
  import flash.events.EventDispatcher;
  import flash.events.*;
  import flash.net.URLRequest;
  import flash.filters.*;
  import flash.net.URLLoader;
  import flash.display.Loader;
  import com.myFile.FileUtil;
  import com.myEvent.MyEvent;
  import flash.display.Bitmap;
  import caurina.transitions.Tweener;
  import flash.geom.Point;
  import com.button.ButtonUtil;
  import com.myEvent.MyEvent;
  
  import qnx.ui.listClasses.ScrollPane;
  import qnx.ui.listClasses.ScrollDirection;
  public class Gallery extends MovieClip{         //EventDispatcher
    
    private var FileArray:Array;
	private var BitmapArray:Array;
    public var photo_array:Array=new Array();
	private var loader:Loader ;
	
	private var offset:Point;
	private var isMove:Boolean=false;
	private var ClickNumber:Number;
	private var myHeight:Number=800;
	
	private var ImgW:Number;
	private var ImgH:Number;
	
	private var _tempImg:Image;  //暫時用,取Image 的長寬比
	private var ImgScale:Number;
	
	private var isMoveUp:Boolean;  //判斷向上或向下拖拉
	private var PictureGap:int= 5; //圖片與圖片的間距
	private var SMc:MovieClip=new MovieClip();
	private var scrollPane : ScrollPane;
    public function Gallery(_array:Array,_w:Number,_h:Number){
    	FileArray=_array;
		ImgW = _w;
		myHeight=ImgH = _h;
		GetImgScale();
		//LoadImg(FileArray);
    }
	//************** img load ************************
	private function GetImgScale():void
	{
		_tempImg=new Image(FileArray[0],100,100,false);
		_tempImg.addEventListener(MyEvent.OBJECK_CLICK, GetImgScaleFun );
	}
	public function GetImgScaleFun(e:MyEvent):void
	{
		var _object:Object=e.data;
		ImgScale=_object.width/_object.height;
		_tempImg.removeEventListener(MyEvent.OBJECK_CLICK, GetImgScaleFun );
		_tempImg=null;
		LoadImg(FileArray);
	}
	private function LoadImg(_a:Array):void
	{
		var _length:Number=_a.length;
	
		for(var i:int=0; i < _length ; i++){
			photo_array[i]=new Image(_a[i],ImgW,ImgW/ImgScale);
			
			photo_array[i].name="Img" + String(i);
			photo_array[i].n=i;
			photo_array[i].oldY =0;
			SMc.addChild(photo_array[i]);
			//photo_array[i].alpha=0;
			//this.addChild(photo_array[i]);
			photo_array[i].addEventListener(MouseEvent.CLICK,onMouseHandle);
			
		}
		Tweener.addTween(this, {time:1,transition:"easeOutExpo",onComplete:function():void{
				DisplayImg();
		}});	
	}
	private function DisplayImg():void
	{
		var _length:Number=FileArray.length;
		for(var i:int=0; i < _length ; i++){
			if(i == 0)	photo_array[i].y = photo_array[i].oldY = i * photo_array[i].height ;//+ MovieClip(parent).Bar.height;
			else photo_array[i].y = photo_array[i].oldY = (i * ( photo_array[i].height + PictureGap)) ;//+ MovieClip(parent).Bar.height;
		}
		scrollPane = new ScrollPane();
		addChild(scrollPane);
		scrollPane.setSize(ImgW, ImgH-MovieClip(parent).Bar.height);
		scrollPane.setPosition(0, MovieClip(parent).Bar.height);
		scrollPane.setScrollContent(SMc);
		scrollPane.scrollDirection = ScrollDirection.VERTICAL;
	}
	//****************************************************
	//********************* mouse handle *****************
	private function onMouseHandle(e:Event):void{
		var _n:Number=e.target.n;
		//trace("click.." + _n);
		if(!ButtonUtil.SetBrightness(DisplayObject(photo_array[_n]),.3)) return;
		MouseClickHandle(_n);
		//trace("click.." + _n);
	}

	//*************************************************
    private function MouseClickHandle(_n:Number):void{
		//myXML = new XML(evt.currentTarget.data);
		var _data:Object=new Object();

		try{
			var eve:MyEvent = new MyEvent(MyEvent.OBJECK_CLICK);
      		
			eve.data = _n;
			eve.state = "Gallery";
      		dispatchEvent(eve);
      		eve = null;
		}
		catch(error:Error){
			_data="Error";
		}
	}
	public function Clear():void
	{
		var _length:Number=photo_array.length;
		for(var i:int=0; i < _length ; i++){
			photo_array[i].removeEventListener(MouseEvent.CLICK,onMouseHandle);
			
		}
		if(scrollPane){
			removeChild(scrollPane);
			scrollPane=null;
		}
	}
  }
}
