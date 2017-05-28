package controls {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class DropDownList extends Sprite {
		private var _isInitialized:Boolean;
		private var _skin:CategorySkin;
		private var _tf:TextField;
		private var _subcatAnchor:MovieClip;
		private var _expander:MovieClip;
		private var _hitArea:MovieClip;

		private var _subcategories:Array;

		public function set subcategories(value:Array):void {
			if (_subcategories != value) {
				_subcategories = value;
				_subcategories ||= [];
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

		private var _expanded:Boolean;

		public function get expanded():Boolean {
			return _expanded;
		}

		public function set expanded(value:Boolean):void {
			if (_expanded != value) {
				_expanded = value;
				draw();
			}
		}

		public function DropDownList() {
			_isInitialized = false;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		private function initialize():void {
			_skin = new CategorySkin();
			_skin.stop();
			_hitArea = _skin["hit_area"];
			_hitArea.addEventListener(MouseEvent.CLICK, skin_clickHandler);
			_subcatAnchor = _skin["subcat_anchor"];
			_expander = _skin['expander'];
			_tf = _skin["text"];
			_tf.text = "";
			addChild(_skin);
			_isInitialized = true;
			draw();
		}

		private function draw():void {
			if (!_isInitialized) return;
			_tf.text = _text;

			_expander.gotoAndStop(_expanded ? 2 : 1);

			while (_subcatAnchor.numChildren) {
				_subcatAnchor.removeChildAt(0);
			}

			if (!_expanded) return;

			var length:uint = _subcategories.length;
			for (var i:int = 0; i < length; i++) {
				var subcat:Object = _subcategories[i];
				var subcategory:Subcategory = new Subcategory();
				subcategory.text = subcat["text"];
				subcategory.items = subcat["items"];
				_subcatAnchor.addChild(subcategory);
				subcategory.y = i * subcategory.height;
			}
		}

		private function dispose():void {
			_expander = null;
			if (_subcatAnchor) {
				while (_subcatAnchor.numChildren) {
					_subcatAnchor.removeChildAt(0);
				}
				_subcatAnchor = null;
			}
			_subcategories = null;
			if (_hitArea) {
				_hitArea.removeEventListener(MouseEvent.CLICK, skin_clickHandler);
				_hitArea = null;
			}
			_isInitialized = false;
			_skin = null;
			_tf = null;
			_text = null;
		}

		private function addedToStageHandler(e:Event):void {
			initialize();
		}

		private function removedFromStageHandler(e:Event):void {
			dispose();
		}

		private function skin_clickHandler(e:MouseEvent):void {
			expanded = !expanded;
			draw();
			dispatchEvent(new Event(CategoryEventType.EXPANDED));
		}
	}
}
