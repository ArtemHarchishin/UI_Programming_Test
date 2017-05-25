package {
	import flash.display.Sprite;

	public class Item extends Sprite {
		private var _title:String;

		public function Item() { }

		public function update(vo:DataVO):void {
			vo ||= new DataVO({});

			_title = vo.item;
		}
	}
}
