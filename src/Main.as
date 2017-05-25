package {

	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {

			var data:Array = [
				{'cat': 1, 'subcat': 1, 'item': 3},
				{'cat': 1, 'subcat': 2, 'item': 3},
				{'cat': 2, 'subcat': 2, 'item': 4}
			];
			var model:Model = new Model();
			var view:View = new View();
			addChild(view);
			var controller:Controller = new Controller();
			controller.initialize(model, view);

			model.update(data);
		}
	}
}
