package controls {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Item extends Sprite {
		private var _skin:ItemSkin;
		private var _isInitialized:Boolean;
		private var _tf:TextField;

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

		private var _text:String;

		public function get text():String {
			return _text;
		}

		public function set text(value:String):void {
			if (_text != value) {
				_text = value;
				draw();
			}
		}

		public function Item() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
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
			_tf.text = _text;
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			_isInitialized = false;
			_tf = null;
			_text = null;
			if (_skin) {
				_skin.removeEventListener(MouseEvent.CLICK, skin_clickHandler);
				_skin = null;
			}
		}

		private function skin_clickHandler(e:MouseEvent):void {
			selected = !selected;
			draw();
		}
	}
}
