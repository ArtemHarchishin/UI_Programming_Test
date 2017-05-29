package controls {
	import data.Collection;
	import data.CollectionEventType;
	import data.DataEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Category extends BaseControl {
		private var _skin:CategorySkin;
		private var _tf:TextField;
		private var _subcatAnchor:MovieClip;
		private var _expander:MovieClip;
		private var _hitArea:MovieClip;
		private var _selectedItem:BaseControl;

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

		public function Category() {
		}

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(_data);
			}
		}

		override protected function initialize():void {
			_skin = new CategorySkin();
			_skin.stop();
			_hitArea = _skin["hit_area"];
			_hitArea.addEventListener(MouseEvent.CLICK, skin_clickHandler);
			_subcatAnchor = _skin["subcat_anchor"];
			_expander = _skin['expander'];
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
			draw();
		}

		override protected function draw():void {
			if (!isInitialized) return;
			_tf.text = _label;

			_expander.gotoAndStop(_selected ? 2 : 1);

			while (_subcatAnchor.numChildren) {
				_subcatAnchor.removeChildAt(0);
			}

			if (!_selected) return;

			var length:uint = _dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var subcat:Object = _dataProvider.getItemAt(i);
				var subcategory:Subcategory = new Subcategory();
				subcategory.data = subcat;
				subcategory.labelField = labelField;
				subcategory.addEventListener(BaseControlEventType.SELECTED, subcategory_selectedHandler);
				_subcatAnchor.addChild(subcategory);
				subcategory.y = i * subcategory.height;
			}
		}

		override protected function dispose():void {
			_expander = null;
			if (_subcatAnchor) {
				while (_subcatAnchor.numChildren) {
					_subcatAnchor.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, subcategory_selectedHandler);
					_subcatAnchor.removeChildAt(0);
				}
				_subcatAnchor = null;
			}
			_dataProvider = null;
			if (_hitArea) {
				_hitArea.removeEventListener(MouseEvent.CLICK, skin_clickHandler);
				_hitArea = null;
			}
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

		private function skin_clickHandler(e:MouseEvent):void {
			selected = !selected;
		}

		private function subcategory_selectedHandler(e:DataEvent):void {
			var clickedItem:BaseControl = BaseControl(e.data);
			if (_selectedItem != clickedItem) {
				if (_selectedItem) {
					_selectedItem.deselect();
				}
				_selectedItem = clickedItem;
			}
		}
	}
}
