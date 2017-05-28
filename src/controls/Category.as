package controls {
	import data.Collection;
	import data.CollectionEventType;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Category extends Sprite implements IListItem{
		private var _isInitialized:Boolean;
		private var _skin:CategorySkin;
		private var _tf:TextField;
		private var _subcatAnchor:MovieClip;
		private var _expander:MovieClip;
		private var _hitArea:MovieClip;

		protected var _labelField:String = "label";

		public function get labelField():String {
			return _labelField;
		}

		public function set labelField(value:String):void {
			if (_labelField == value) {
				return;
			}
			_labelField = value;
		}

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (_data === value) {
				return;
			}
			_data = value;
			commitData();
			draw();
		}

		private var _dataProvider:Collection;

		public function get dataProvider():Collection {
			return _dataProvider;
		}

		public function set dataProvider(value:Collection):void {
			if (_dataProvider == value) {
				return;
			}
			if (_dataProvider) {
				_dataProvider.removeEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
				_dataProvider.removeEventListener(CollectionEventType.REMOVE_ITEM, dataProvider_removeItemHandler);
				_dataProvider.removeEventListener(CollectionEventType.REPLACE_ITEM, dataProvider_replaceItemHandler);
				_dataProvider.removeEventListener(CollectionEventType.RESET, dataProvider_resetHandler);
				_dataProvider.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
			_dataProvider = value;
			if (_dataProvider) {
				_dataProvider.addEventListener(CollectionEventType.ADD_ITEM, dataProvider_addItemHandler);
				_dataProvider.addEventListener(CollectionEventType.REMOVE_ITEM, dataProvider_removeItemHandler);
				_dataProvider.addEventListener(CollectionEventType.REPLACE_ITEM, dataProvider_replaceItemHandler);
				_dataProvider.addEventListener(CollectionEventType.RESET, dataProvider_resetHandler);
				_dataProvider.addEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
			draw();
		}

		private var _label:String;

		public function get label():String {
			return _label;
		}

		public function set label(value:String):void {
			if (_label != value) {
				_label = value;
				draw();
			}
		}

		private var _expanded:Boolean;

		public function get expanded():Boolean {
			return _expanded;
		}

		public function set expanded(value:Boolean):void {
			if (_expanded != value) {
				_expanded = value;
				draw();
			}
		}

		public function Category() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function itemToLabel(item:Object):String {
			var labelResult:Object;
			if (_labelField != null && item && item.hasOwnProperty(_labelField)) {
				labelResult = item[_labelField];
				if (labelResult is String) {
					return labelResult as String;
				}
				else if (labelResult) {
					return labelResult.toString();
				}
			}
			else if (item is String) {
				return item as String;
			}
			else if (item !== null) {
				return item.toString();
			}
			return null;
		}

		protected function commitData():void {
			if (_data !== null) {
				_label = itemToLabel(_data);
			}
		}

		private function initialize():void {
			_skin = new CategorySkin();
			_skin.stop();
			_hitArea = _skin["hit_area"];
			_hitArea.addEventListener(MouseEvent.CLICK, skin_clickHandler);
			_subcatAnchor = _skin["subcat_anchor"];
			_expander = _skin['expander'];
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
			_isInitialized = true;
			draw();
		}

		private function draw():void {
			if (!_isInitialized) return;
			_tf.text = _label;

			_expander.gotoAndStop(_expanded ? 2 : 1);

			while (_subcatAnchor.numChildren) {
				_subcatAnchor.removeChildAt(0);
			}

			if (!_expanded) return;

			var length:uint = _data.length;
			for (var i:int = 0; i < length; i++) {
				var subcat:Object = _data[i];
				var subcategory:Subcategory = new Subcategory();
				subcategory.text = subcat["text"];
				subcategory.items = subcat["items"];
				_subcatAnchor.addChild(subcategory);
				subcategory.y = i * subcategory.height;
			}
		}

		private function dispose():void {
			_expander = null;
			if (_subcatAnchor) {
				while (_subcatAnchor.numChildren) {
					_subcatAnchor.removeChildAt(0);
				}
				_subcatAnchor = null;
			}
			_dataProvider = null;
			if (_hitArea) {
				_hitArea.removeEventListener(MouseEvent.CLICK, skin_clickHandler);
				_hitArea = null;
			}
			_isInitialized = false;
			_skin = null;
			_tf = null;
			_label = null;
		}

		private function dataProvider_addItemHandler(e:Event):void {
		}

		private function dataProvider_removeItemHandler(e:Event):void {
		}

		private function dataProvider_replaceItemHandler(e:Event):void {
		}

		private function dataProvider_resetHandler(e:Event):void {
		}

		private function dataProvider_changeHandler(e:Event):void {
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			dispose();
		}

		private function skin_clickHandler(e:MouseEvent):void {
			expanded = !expanded;
			draw();
			dispatchEvent(new Event(CategoryEventType.EXPANDED));
		}
	}
}
