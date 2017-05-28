package {

	import controls.Category;
	import controls.List;

	import data.Collection;

	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {

//			var somedata:Array = [
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "John"}},
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "Phil"}},
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Psytrance party"}},
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Singing Fountains"}},
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Drags"}},
//				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Rock'n'Roll"}},
//				{'subcat': {text: "Rzecszow"}, item: {text: "item3"}},
//				{'cat': {text: "Kiev"}, 'item': {text: "item1"}},
//				{'cat': {text: "Kiev"}, 'item': {text: "item2"}},
//				{'item': {text: "Rock'n'Roll"}}
//			];
			var somedata:Array = [
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
			var list:List = new List();
			var collection:Collection = new Collection(somedata);
//			var dataDescriptor:HierarchicalCollectionDataDescriptor = new HierarchicalCollectionDataDescriptor();
//			dataDescriptor.itemsField = "subcat";
//			collection.dataDescriptor = dataDescriptor;
			list.dataProvider = collection;
//			list.itemFactory = function ():IListItem {
//				var item:Item = new Item();
//				item.labelField = "text";
//				return item;
//			};
			list.itemFactory = function ():IListItem {
				var item:Category = new Category();
				item.labelField = "text";
				return item;
			};
			addChild(list);
		}
	}
}

