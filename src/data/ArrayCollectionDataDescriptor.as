package data {
	import flash.errors.IllegalOperationError;

	public class ArrayCollectionDataDescriptor implements ICollectionDataDescriptor {

		public var itemField:String = "item";

		public function ArrayCollectionDataDescriptor() {
		}

		public function getLength(data:Object, ...rest:Array):int {
			checkForCorrectDataType(data);
			return (data as Array).length;
		}

		public function getItemAt(data:Object, index:int, ...rest:Array):Object {
			checkForCorrectDataType(data);
			return (data as Array)[index][itemField];
		}

		public function setItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
			checkForCorrectDataType(data);
			var newItem:Object = {};
			newItem[itemField] = item;
			(data as Array)[index] = newItem;
		}

		public function addItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
			checkForCorrectDataType(data);
			var newItem:Object = {};
			newItem[itemField] = item;
			(data as Array).insertAt(index, newItem);
		}

		public function removeItemAt(data:Object, index:int, ...rest:Array):Object {
			checkForCorrectDataType(data);
			var array:Array = (data as Array);
			var item:Object = array[index];
			array.splice(index, 1);
			return item;
		}

		public function removeAll(data:Object):void {
			checkForCorrectDataType(data);
			(data as Array).length = 0;
		}

		private function checkForCorrectDataType(data:Object):void {
			if (!(data is Array)) {
				throw new IllegalOperationError("Expected Array. Received " + Object(data).constructor + " instead.");
			}
		}
	}
}
