package controls {
	import data.Collection;
	import data.CollectionEventType;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class List extends Sprite {
		private var _isInitialized:Boolean;

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
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		private function initialize():void {
			_isInitialized = true;
			draw();
		}

		private function draw():void {
			if (!_isInitialized) return;

			while (numChildren) {
				removeChildAt(0);
			}

			var length:int = _dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var dataItem:Object = _dataProvider.getItemAt(i);
				var item:IListItem = itemFactory();
				item.data = dataItem;
				addChild(DisplayObject(item));
				item.y = i * item.height;
			}
		}

		private function redraw():void {
			var shiftY:Number = 0;
			for (var i:int = 0; i < numChildren; i++) {
				var category:Category = Category(getChildAt(i));
				if (category.expanded) {
					category.y = (i * category.height) + shiftY;
					shiftY += category.height
				}
				else {
					category.y = (i * category.height) + shiftY;
				}
			}
		}

		private function dispose():void {
			while (numChildren) {
				Category(getChildAt(0)).removeEventListener(CategoryEventType.EXPANDED, category_expandedHandler);
				removeChildAt(0);
			}
			_itemFactory = null;
			_dataProvider = null;
			_isInitialized = false;
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			dispose();
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

		private function category_expandedHandler(e:Event):void {
			redraw();
		}
	}
}
