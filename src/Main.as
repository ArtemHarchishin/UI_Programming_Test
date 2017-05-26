package {

	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {

//			var data:Array = [
//				{'cat': 1, 'subcat': 1, 'item': 3},
//				{'cat': 1, 'subcat': 2, 'item': 3},
//				{'cat': 2, 'subcat': 2, 'item': 4}
//			];
			var data:Array = [
				{
					'cat': {text: "Kerkira"},
					'subcat': [
						{
							text: "Characters",
							items: [
								{text: "John"},
								{text: "Phil"}
							]
						},
						{
							text: "Events",
							items: [
								{text: "Psytrance party"},
								{text: "Singing Fountains"}
							]
						},
						{
							text: "Points of interest",
							items: [
								{text: "Drags"},
								{text: "Rock'n'Roll"}
							]
						}
					]
				},
				{
					'cat': {text: "Kiev"},
					'subcat': []
				},
				{
					'cat': {text: "Lviv"},
					'subcat': []
				},
				{
					'cat': {text: "Odessa"},
					'subcat': []
				},
				{
					'cat': {text: "Rzecszow"},
					'subcat': []
				}
			];
			var collection:Collection = new Collection(data);
			var list:List = new List();
			list.dataProvider = collection;
			addChild(list);
		}
	}
}
