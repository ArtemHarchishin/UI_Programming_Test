package {
	import flash.display.Sprite;

	public class Subcategory extends Sprite {
		private var _title:String;

		public function Subcategory() { }

		public function update(vo:DataVO):void {
			vo ||= new DataVO({});

			_title = vo.subcat;

			if (vo.hasItem) {
				var item:Item = new Item();
				item.update(vo);
				addChild(item);
			}
		}
	}
}
