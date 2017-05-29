package controls {
	import data.DataEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 It's abstract class
	 */
	public class BaseControl extends Sprite {
		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		protected var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				draw();
				dispatchEvent(new DataEvent(BaseControlEventType.SELECTED, this));
			}
		}

		protected var _labelField:String = "label";

		public function get labelField():String {
			return _labelField;
		}

		public function set labelField(value:String):void {
			if (_labelField == value) {
				return;
			}
			_labelField = value;
		}

		protected var _label:String;

		public function get label():String {
			return _label;
		}

		public function set label(value:String):void {
			if (_label == value) {
				return;
			}
			_label = value;
			draw();
		}

		protected var _data:Object;

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (_data === value) {
				return;
			}
			_data = value;
			commitData();
			draw();
		}

		public function BaseControl() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function deselect():void {
			selected = false;
		}

		protected function commitData():void {
			throw new Error("It's abstract method");
		}

		public function dataToLabel(item:Object):String {
			var labelResult:Object;
			if (_labelField != null && item && item.hasOwnProperty(_labelField)) {
				labelResult = item[_labelField];
				if (labelResult is String) {
					return labelResult as String;
				}
				else if (labelResult) {
					return labelResult.toString();
				}
			}
			else if (item is String) {
				return item as String;
			}
			else if (item !== null) {
				return item.toString();
			}
			return null;
		}

		protected function draw():void {
			throw new Error("It's abstract method");
		}

		protected function initialize():void {
			throw new Error("It's abstract method");
		}

		protected function dispose():void {
			throw new Error("It's abstract method");
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
			_isInitialized = true;
			draw();
		}

		private function removedFromStageHandler(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			dispose();
			_isInitialized = false;
		}
	}
}
