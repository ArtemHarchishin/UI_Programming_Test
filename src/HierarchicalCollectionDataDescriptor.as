package {
	import data.ICollectionDataDescriptor;

	public class HierarchicalCollectionDataDescriptor implements ICollectionDataDescriptor {

		public var itemsField:String = "items";

		public function HierarchicalCollectionDataDescriptor() {
		}

		public function getLength(data:Object, ...rest:Array):int {
			return (data as Array).length;
		}

		public function getItemAt(data:Object, index:int, ...rest:Array):Object {
			return (data as Array)[index][itemsField];
		}

		public function setItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
//			(data as Array)[index] = newItem;
		}

		public function addItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
//			(data as Array).insertAt(index, newItem);
		}

		public function removeItemAt(data:Object, index:int, ...rest:Array):Object {
			return {};
		}

		public function removeAll(data:Object):void {
			(data as Array).length = 0;
		}
	}
}
