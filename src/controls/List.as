package controls {

	import data.Collection;
	import data.CollectionEventType;
	import data.DataEvent;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class List extends BaseControl {
		private var _selectedItem:BaseControl;
		private var _itemsContainer:Sprite;

		protected var _itemFactory:Function;

		public function get itemFactory():Function {
			return _itemFactory;
		}

		public function set itemFactory(value:Function):void {
			if (_itemFactory === value) {
				return;
			}

			_itemFactory = value;
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

		public function List() {
		}

		private var _scrollbar:Scroller;

		override protected function initialize():void {
			_itemsContainer = new Sprite();
			addChild(_itemsContainer);
			_scrollbar = new Scroller();
			addChild(_scrollbar);
		}

		override protected function draw():void {
			if (!isInitialized) return;

			while (_itemsContainer.numChildren) {
				_itemsContainer.removeChildAt(0);
			}

			var shiftY:Number = 0;
			var length:int = _dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var dataItem:Object = _dataProvider.getItemAt(i);
				var item:BaseControl = itemFactory();
				item.data = dataItem;
				item.addEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
				_itemsContainer.addChild(DisplayObject(item));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}

			drawScrollBar();
		}

		private function drawScrollBar():void {
			_scrollbar.x = width;
			var contentHeight:Number = _itemsContainer.numChildren * _itemsContainer.getChildAt(0).height;
			_scrollbar.setThumbPercent(height / contentHeight);
			_scrollbar.height = height;
			_scrollbar.setSize(10, 200);
		}

		override protected function dispose():void {
			if (_itemsContainer) {
				while (_itemsContainer.numChildren) {
					_itemsContainer.getChildAt(0).removeEventListener(BaseControlEventType.SELECTED, item_selectedHandler);
					_itemsContainer.removeChildAt(0);
				}
				_itemsContainer = null;
			}
			_itemFactory = null;
			_dataProvider = null;
		}

		private function redraw():void {
			if (!isInitialized) return;

			var shiftY:Number = 0;
			for (var i:int = 0; i < _itemsContainer.numChildren; i++) {
				var item:BaseControl = BaseControl(_itemsContainer.getChildAt(i));
				item.y = shiftY;
				shiftY = item.y + item.height;
			}
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

		private function item_selectedHandler(e:DataEvent):void {
			var clickedItem:BaseControl = BaseControl(e.data);
			if (_selectedItem != clickedItem) {
				if (_selectedItem) {
					_selectedItem.deselect();
				}
				_selectedItem = clickedItem;
			}
			redraw();
		}
	}
}
