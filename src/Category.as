package {
	import flash.display.Sprite;

	public class Category extends Sprite {
		private var _subcategory:Subcategory;
		private var _title:String;

		public function Category() { }

		public function update(vo:DataVO):void {
			vo ||= new DataVO({});

			_title = vo.cat;

			if (vo.hasSubcat) {
				_subcategory = new Subcategory();
				_subcategory.update(vo);
				addChild(_subcategory);
			} else {

			}
		}
	}
}
