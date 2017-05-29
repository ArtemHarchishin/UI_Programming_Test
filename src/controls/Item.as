package controls {

	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class Item extends BaseControl {
		private var _skin:ItemSkin;
		private var _tf:TextField;

		public function Item() { }

		override protected function commitData():void {
			if (_data !== null) {
				_label = dataToLabel(_data);
			}
		}

		override protected function initialize():void {
			_skin = new ItemSkin();
			_skin.stop();
			_skin.addEventListener(MouseEvent.CLICK, skin_clickHandler);
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
		}

		override protected function draw():void {
			if (!isInitialized) return;

			_skin.gotoAndStop(_selected ? 2 : 1);
			_tf.text = _label;
		}

		override protected function dispose():void {
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
		}
	}
}
