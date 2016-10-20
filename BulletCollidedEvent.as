package  {
	import flash.events.Event;
	public class BulletCollidedEvent extends Event {
		public static const DEFAULT_NAME:String = "com.reintroducing.events.BulletCollidedEvent";
        var bulletReference:Bullet;
		var enemyReference:Enemy;
        // event constants
        public static const EVENT_NAME:String = "BulletCollidedEvent";
		public function BulletCollidedEvent($type:String,bulletReference:Bullet,enemyReference:Enemy, $bubbles:Boolean = false, $cancelable:Boolean = false) {
			// constructor code
			super($type, $bubbles, $cancelable);
			this.bulletReference = bulletReference;
			this.enemyReference = enemyReference;
		}

	}
	
}
