package {
	public class Controller {
		private var _model:Model;
		private var _view:View;

		public function Controller() { }

		public function initialize(model:Model, view:View):void {
			_model = model;
			_view = view;
			_model.addEventListener(ModelEvent.UPDATE, model_updateHandler);
		}

		private function model_updateHandler(e:ModelEvent):void {
			_view.update(_model.data);
		}
	}
}
