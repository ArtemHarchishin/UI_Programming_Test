package controls {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Item extends Sprite implements IListItem {
		private var _skin:ItemSkin;
		private var _isInitialized:Boolean;
		private var _tf:TextField;

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

		private var _selected:Boolean;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				draw();
			}
		}

		private var _label:String;

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

		public function Item() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function itemToLabel(item:Object):String {
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

		protected function commitData():void {
			if (_data !== null) {
				_label = itemToLabel(_data);
			}
		}

		private function initialize():void {
			_skin = new ItemSkin();
			_skin.stop();
			_skin.addEventListener(MouseEvent.CLICK, skin_clickHandler);
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
			_isInitialized = true;
			draw();
		}

		private function draw():void {
			if (!_isInitialized) return;

			_skin.gotoAndStop(_selected ? 2 : 1);
			_tf.text = _label;
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			_isInitialized = false;
			_tf = null;
			_label = null;
			if (_skin) {
				_skin.removeEventListener(MouseEvent.CLICK, skin_clickHandler);
				_skin = null;
			}
			_data = null;
		}

		private function skin_clickHandler(e:MouseEvent):void {
			selected = !selected;
			draw();
		}
	}
}
