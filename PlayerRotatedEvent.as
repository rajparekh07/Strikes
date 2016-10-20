package  {
	import flash.events.Event;
	
	public class PlayerRotatedEvent extends Event {
		var playerX:Number;
		var playerY:Number;
		public static const DEFAULT_NAME:String = "com.reintroducing.events.PlayerRotatedEvent";
       
        // event constants
        public static const EVENT_NAME:String = "PlayerRotatedEvent";
		public function PlayerRotatedEvent($type:String, $playerX:Number,$playerY:Number, $bubbles:Boolean = false, $cancelable:Boolean = false) {
			// constructor code
			super($type, $bubbles, $cancelable);
			this.playerX = $playerX;
			this.playerY = $playerY;

		}

	}
	
}
