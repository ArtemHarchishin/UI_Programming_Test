package {

	import controls.List;

	import data.Collection;

	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {

			var data:Array = [
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "John"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "Phil"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Psytrance party"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Singing Fountains"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Drags"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Rock'n'Roll"}},
				{'item': {text: "Rock'n'Roll"}},
				{'cat': {text: "Kiev"}, 'item': {text: "item1"}},
				{'cat': {text: "Kiev"}, 'item': {text: "item2"}},
				{'subcat': {text: "Rzecszow"}, item: {text: "item3"}}
			];
//			var data:Array = [
//				{
//					'cat': {text: "Kerkira"},
//					'subcat': [
//						{
//							text: "Characters",
//							items: [
//								{text: "John"},
//								{text: "Phil"}
//							]
//						},
//						{
//							text: "Events",
//							items: [
//								{text: "Psytrance party"},
//								{text: "Singing Fountains"}
//							]
//						},
//						{
//							text: "Points of interest",
//							items: [
//								{text: "Drags"},
//								{text: "Rock'n'Roll"}
//							]
//						}
//					]
//				},
//				{
//					'cat': {text: "Kiev"},
//					'subcat': []
//				},
//				{
//					'cat': {text: "Lviv"},
//					'subcat': []
//				},
//				{
//					'cat': {text: "Odessa"},
//					'subcat': []
//				},
//				{
//					'cat': {text: "Rzecszow"},
//					'subcat': []
//				}
//			];
			var list:List = new List();
			var collection:Collection = new Collection(data);
			var r = collection.getLength();
			list.dataProvider = collection;
			addChild(list);
		}
	}
}

