package {
	import flash.display.Sprite;
	import flash.events.Event;

	public class List extends Sprite {
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
		}

		public function List() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function initialize():void {
			draw();
		}

		private function draw():void {
			var length:int = _dataProvider.getLength();
			for (var i:int = 0; i < length; i++) {
				var item:Object = _dataProvider.getItemAt(i);
				var categorySkin:CategorySkin = new CategorySkin();
				categorySkin.y = i * categorySkin.height;
				categorySkin["title"].text = item["cat"]["text"];
				addChild(categorySkin);
			}
		}

		private function removedFromStageHandler(e:Event):void {
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

	}
}
