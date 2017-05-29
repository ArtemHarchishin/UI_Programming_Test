package controls {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Scroller extends Sprite {
		protected var _value:Number = 0;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		protected var _handle:Sprite;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _thumbPercent:Number = 1.0;

		private var _isInitialized:Boolean;

		public function get isInitialized():Boolean {
			return _isInitialized;
		}

		public function Scroller() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public function setSize(w:Number, h:Number):void {
			_width = w;
			_height = h;
		}

		public function setThumbPercent(value:Number):void {
			_thumbPercent = Math.min(value, 1.0);
		}

		protected function dispose():void {
		}

		protected function updatePosition():void {
			var range:Number = _height - _handle.height;
			_handle.y = (_value - _min) / (_max - _min) * range;
			trace("updatePosition", _handle.y);
		}

		private function initialize():void {
			_handle = new Sprite();
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
			_handle.buttonMode = true;
			_handle.useHandCursor = true;
			addChild(_handle);
		}

		private function draw():void {
			if (!isInitialized) return;

			var size:Number;
			_handle.graphics.clear();
			size = Math.round(_height * _thumbPercent);
			size = Math.max(_width, size);
			_handle.graphics.beginFill(0, 0);
			_handle.graphics.drawRect(0, 0, _width - 2, size);
			_handle.graphics.endFill();
			_handle.graphics.beginFill(0x666666);
			_handle.graphics.drawRect(1, 1, _width - 2, size - 2);
			_handle.graphics.endFill();
			updatePosition();
		}

		protected function onSlide(event:MouseEvent):void {
			var oldValue:Number = _value;
			_value = (_height - _width - _handle.y) / (_height - _width) * (_max - _min) + _min;
			updatePosition();
			if (_value != oldValue) {
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		protected function onDrop(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}

		private function onDrag(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_handle.startDrag(false, new Rectangle(0, 0, 0, _height - _handle.height));
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
