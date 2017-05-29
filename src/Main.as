package {

	import controls.BaseControl;
	import controls.Category;
	import controls.Item;
	import controls.List;

	import data.Collection;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class Main extends Sprite {
		public function Main() {
			var list:List;
//			list = createHierarchicalList();
//			moveTo(list, 0, 0);
//			addChild(list);
			list = createArrayList();
			moveTo(list, 200, 0);
			addChild(list);
		}

		private function createCategory():void {
			var hierarchicalData:Object = {
				label: "Kerkira",
				subcat: [
					{
						label: {text: "Characters"},
						items: [
							{text: "John"},
							{text: "Phil"}
						]
					},
					{
						label: {text: "Events"},
						items: [
							{text: "Psytrance party"},
							{text: "Singing Fountains"}
						]
					},
					{
						label: {text: "Points of interest"},
						items: [
							{text: "Drags"},
							{text: "Rock'n'Roll"}
						]
					}
				]
			};
			var category:Category = new Category();
			var collection:Collection = new Collection(hierarchicalData['subcat']);
			collection.dataDescriptor = new HierarchicalCollectionDataDescriptor();
			category.data = hierarchicalData;
			category.dataProvider = collection;
			addChild(category);
		}

		private function createArrayList():List {
			var arrayData:Array = [
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "John"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Characters"}, 'item': {text: "Phil"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Psytrance party"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Events"}, 'item': {text: "Singing Fountains"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Drags"}},
				{'cat': {text: "Kerkira"}, 'subcat': {text: "Points of interest"}, 'item': {text: "Rock'n'Roll"}},
				{'subcat': {text: "Rzecszow"}, item: {text: "item3"}},
				{'cat': {text: "Kiev"}, 'item': {text: "item1"}},
				{'cat': {text: "Kiev"}, 'item': {text: "item2"}},
				{'item': {text: "Rock'n'Roll"}}
			];
			var list:List = new List();
			var collection:Collection = new Collection(arrayData);
			list.dataProvider = collection;
			list.itemFactory = function ():BaseControl {
				var item:Item = new Item();
				item.labelField = "text";
				return item;
			};

			return list;
		}

		private function createHierarchicalList():List {
			var hierarchicalData:Array = [
				{
					cat: {text: "Kerkira"},
					subcat: [
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
					cat: {text: "Kiev"},
					subcat: []
				},
				{
					cat: {text: "Lviv"},
					subcat: []
				},
				{
					cat: {text: "Odessa"},
					subcat: []
				},
				{
					cat: {text: "Rzecszow"},
					subcat: []
				}
			];

			var list:List = new List();
			var collection:Collection = new Collection(hierarchicalData);
//			var dataDescriptor:HierarchicalCollectionDataDescriptor = new HierarchicalCollectionDataDescriptor();
//			dataDescriptor.itemsField = "subcat";
//			collection.dataDescriptor = dataDescriptor;
			list.dataProvider = collection;
			list.itemFactory = function ():BaseControl {
				var item:Category = new Category();
				item.labelField = "text";
				return item;
			};

			return list;
		}

		public function moveTo(displayObject:DisplayObject, x:Number = NaN, y:Number = NaN):void {
			if (isNaN(x)) {
				x = displayObject.x;
			}
			if (isNaN(y)) {
				y = displayObject.y;
			}
			displayObject.x = x;
			displayObject.y = y;
		}
	}
}

