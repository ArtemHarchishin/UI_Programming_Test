package {
	import flash.display.Sprite;

	public class View extends Sprite {
		private var _categoriesContainer:Sprite;

		public function View() {
			_categoriesContainer = new Sprite();
			addChild(_categoriesContainer);
		}

		public function update(data:Vector.<DataVO>):void {
			data ||= new Vector.<DataVO>();
			var length:uint = data.length;
			for (var i:int = 0; i < length; i++) {
				var vo:DataVO = data[i];
				if (vo.hasCat) {
					var category:Category = new Category();
					category.update(vo);
					_categoriesContainer.addChild(category);
				}
			}
		}
	}
}
