package {
	import flash.events.Event;

	public class ModelEvent extends Event {
		public static const UPDATE:String = "update";

		public function ModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone():Event {
			return new ModelEvent(type, bubbles, cancelable);
		}
	}
}
