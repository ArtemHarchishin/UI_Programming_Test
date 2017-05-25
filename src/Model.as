package {
	import flash.events.EventDispatcher;

	public class Model extends EventDispatcher {
		private var _data:Vector.<DataVO>;

		public function get data():Vector.<DataVO> { return _data; }

		public function Model() {
			_data = new Vector.<DataVO>();
		}

		public function update(rawData:Array):void {
			rawData ||= [];
			_data = parse(rawData);
			dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
		}

		private function parse(rawData:Array):Vector.<DataVO> {
			var dataVOs:Vector.<DataVO> = new Vector.<DataVO>();
			var length:uint = rawData.length;
			for (var i:int = 0; i < length; i++) {
				var rawObj:Object = rawData[i];
				dataVOs.push(new DataVO(rawObj));
			}
			return dataVOs;
		}
	}
}
