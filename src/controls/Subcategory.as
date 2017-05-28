package controls {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	public class Subcategory extends Sprite {
		private var _isInitialized:Boolean;
		private var _skin:SubcategorySkin;
		private var _tf:TextField;
		private var _itemsAnchor:MovieClip;
		private var _items:Array;

		public function set items(value:Array):void {
			if (_items != value) {
				_items = value;
				_items ||= [];
				draw();
			}
		}

		private var _text:String;

		public function get text():String {
			return _text;
		}

		public function set text(value:String):void {
			if (_text != value) {
				_text = value;
				draw();
			}
		}

		public function Subcategory() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		private function initialize():void {
			_skin = new SubcategorySkin();
			_skin.stop();
			_itemsAnchor = _skin["items_anchor"];
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
			_isInitialized = true;
			draw();
		}

		private function draw():void {
			if (!_isInitialized) return;
			_tf.text = _text;

			while (_itemsAnchor.numChildren) {
				_itemsAnchor.removeChildAt(0);
			}

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var text:String = _items[i]["text"];
				var item:Item = new Item();
				item.text = text;
				_itemsAnchor.addChild(item);
				item.y = i * item.height;
			}
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			dispose();
		}

		private function dispose():void {
			_items = null;
			_isInitialized = false;
			_skin = null;
			_tf = null;
			_text = null;
		}
	}
}
