package data {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Collection extends EventDispatcher {
		protected var _dataDescriptor:ICollectionDataDescriptor = new CollectionDataDescriptor();

		public function get dataDescriptor():ICollectionDataDescriptor {
			return _dataDescriptor;
		}

		public function set dataDescriptor(value:ICollectionDataDescriptor):void {
			if (_dataDescriptor != value) {
				_dataDescriptor = value;
				dispatchEventWith(CollectionEventType.RESET);
				dispatchEventWith(Event.CHANGE);
			}
		}

		private var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (_data != value) {
				_data = value;
				dispatchEventWith(CollectionEventType.RESET);
				dispatchEventWith(Event.CHANGE);
			}
		}

		public function Collection(data:Object = null) {
			if (!data) {
				data = [];
			}
			_data = data;
		}

		public function updateAll():void {
			dispatchEventWith(CollectionEventType.UPDATE_ALL);
		}

		public function getItemAt(index:int, ...rest:Array):Object {
			rest.unshift(index);
			rest.unshift(_data);
			return _dataDescriptor.getItemAt.apply(null, rest);
		}

		public function addItemAt(item:Object, index:int, ...rest:Array):void {
//			rest.unshift(index);
//			rest.unshift(item);
//			rest.unshift(this._data);
//			this._dataDescriptor.addItemAt.apply(null, rest);
//			this.dispatchEventWith(Event.CHANGE);
//			rest.shift();
//			rest.shift();
//			this.dispatchEventWith(CollectionEventType.ADD_ITEM, false, rest);
		}

		public function removeItemAt(index:int, ...rest:Array):Object {
//			rest.unshift(index);
//			rest.unshift(this._data);
//			var item:Object = this._dataDescriptor.removeItemAt.apply(null, rest);
//			this.dispatchEventWith(Event.CHANGE);
//			rest.shift();
//			this.dispatchEventWith(CollectionEventType.REMOVE_ITEM, false, rest);
//			return item;
			return {};
		}

		public function removeItem(item:Object):void {
//			var location:Vector.<int> = this.getItemLocation(item);
//			if (location) {
//				this is hacky. a future version probably won't use rest args.
//				var locationAsArray:Array = [];
//				var indexCount:int = location.length;
//				for (var i:int = 0; i < indexCount; i++) {
//					locationAsArray.push(location[i]);
//				}
//				this.removeItemAt.apply(this, locationAsArray);
//			}
		}

		public function getLength(...rest:Array):int {
			rest.unshift(this._data);
			return _dataDescriptor.getLength.apply(null, rest);
		}

		private function dispatchEventWith(type:String):void {
			var event:Event = new Event(type);
			dispatchEvent(event);
		}
	}
}
