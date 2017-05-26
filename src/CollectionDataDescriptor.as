package {
	public class CollectionDataDescriptor implements ICollectionDataDescriptor {
		public function CollectionDataDescriptor() {}

		public var childrenField:String = "subcat";

		public function getLength(data:Object, ...rest:Array):int {
			var branch:Array = data as Array;
			var indexCount:int = rest.length;
			for (var i:int = 0; i < indexCount; i++) {
				var index:int = rest[i] as int;
				branch = branch[index][childrenField] as Array;
			}

			return branch.length;
		}

		public function getItemAt(data123:Object, index:int, ...rest:Array):Object {
			rest.unshift(index);
			var branch:Array = data123 as Array;
			var indexCount:int = rest.length - 1;
			for (var i:int = 0; i < indexCount; i++) {
				index = rest[i] as int;
				branch = branch[index][childrenField] as Array;
			}
			var lastIndex:int = rest[indexCount] as int;
			return branch[lastIndex];
		}

		public function setItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
			rest.unshift(index);
			var branch:Array = data as Array;
			var indexCount:int = rest.length - 1;
			for (var i:int = 0; i < indexCount; i++) {
				index = rest[i] as int;
				branch = branch[index][childrenField] as Array;
			}
			var lastIndex:int = int(rest[indexCount]);
			branch[lastIndex] = item;
		}

		public function addItemAt(data:Object, item:Object, index:int, ...rest:Array):void {
			rest.unshift(index);
			var branch:Array = data as Array;
			var indexCount:int = rest.length - 1;
			for (var i:int = 0; i < indexCount; i++) {
				index = rest[i] as int;
				branch = branch[index][childrenField] as Array;
			}
			var lastIndex:int = int(rest[indexCount]);
			branch.splice(lastIndex, 0, item);
		}

		public function removeItemAt(data:Object, index:int, ...rest:Array):Object {
			rest.unshift(index);
			var branch:Array = data as Array;
			var indexCount:int = rest.length - 1;
			for (var i:int = 0; i < indexCount; i++) {
				index = rest[i] as int;
				branch = branch[index][childrenField] as Array;
			}
			var lastIndex:int = int(rest[indexCount]);
			var item:Object = branch[lastIndex];
			branch.splice(lastIndex, 1);
			return item;
		}

		public function removeAll(data:Object):void {
			var branch:Array = data as Array;
			branch.length = 0;
		}
	}
}
