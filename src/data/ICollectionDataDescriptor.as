package data {
	public interface ICollectionDataDescriptor {
		function getLength(data:Object, ...rest:Array):int;

		function getItemAt(data:Object, index:int, ...rest:Array):Object;

		function setItemAt(data:Object, item:Object, index:int, ...rest:Array):void;

		function addItemAt(data:Object, item:Object, index:int, ...rest:Array):void;

		function removeItemAt(data:Object, index:int, ...rest:Array):Object;

		function removeAll(data:Object):void;
	}
}
