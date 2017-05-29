package controls {
	import data.DataEvent;

	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Subcategory extends BaseControl {
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

		public function Subcategory() {
			_items = [];
		}

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(_data);
				_items = dataToItems(_data);
			}
		}

		private function dataToItems(data:Object):Array {
//			var result:Array;
//			if (_itemsField != null && item && item.hasOwnProperty(_labelField)) {
//				labelResult = item[_labelField];
//				if (labelResult is String) {
//					return labelResult as String;
//				}
//				else if (labelResult) {
//					return labelResult.toString();
//				}
//			}
//			else if (item is String) {
//				return item as String;
//			}
//			else if (item !== null) {
//				return item.toString();
//			}
			return data as Array;
		}

		override protected function initialize():void {
			_skin = new SubcategorySkin();
			_skin.stop();
			_itemsAnchor = _skin["items_anchor"];
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
		}

		override protected function draw():void {
			if (!isInitialized) return;
			_tf.text = label;

			while (_itemsAnchor.numChildren) {
				_itemsAnchor.removeChildAt(0);
			}

			var length:uint = _items.length;
			for (var i:int = 0; i < length; i++) {
				var item:Item = new Item();
				item.data = _items[i];
				item.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				_itemsAnchor.addChild(item);
				item.y = i * item.height;
			}
		}

		override protected function dispose():void {
			if (_itemsAnchor) {
				while (_itemsAnchor.numChildren) {
					_itemsAnchor.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
					_itemsAnchor.removeChildAt(0);
				}
				_itemsAnchor = null;
			}
			_items = null;
			_skin = null;
			_tf = null;
		}

		private function item_selectedHandler(e:DataEvent):void {
			dispatchEvent(e);
		}
	}
}
