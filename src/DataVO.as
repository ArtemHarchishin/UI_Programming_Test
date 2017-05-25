package {
	public class DataVO {
		private var _cat:String;

		public function get cat():String { return _cat; }

		private var _subcat:String;

		public function get subcat():String { return _subcat; }

		private var _item:String;

		public function get item():String { return _item; }

		public function get hasSubcat():Boolean {return _subcat != "";}

		public function get hasItem():Boolean {return _item != "";}

		public function get hasCat():Boolean {return _cat != "";}

		public function DataVO(raw:Object) {
			raw ||= {};
			_cat = raw.hasOwnProperty("cat") ? raw["cat"] : "";
			_subcat = raw.hasOwnProperty("subcat") ? raw["subcat"] : "";
			_item = raw.hasOwnProperty("item") ? raw["item"] : "";
		}
	}
}
