package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Enemy extends MovieClip {
	
		var player:Player;
		public function Enemy(playerReference:Player,enemyX:Number,enemyY:Number) {
			this.x = enemyX;
			this.y = enemyY;
			this.player = playerReference;
			player.addEventListener(PlayerRotatedEvent.EVENT_NAME,playerRotationHandler); 
		}
		public function playerRotationHandler(e:PlayerRotatedEvent):void{
				var yDifference:Number = e.playerX-this.y;
				var xDifference:Number = e.playerY-this.x;
				var radiansToDegrees:Number = 180/Math.PI;
				rotation = Math.atan2(yDifference, xDifference) * radiansToDegrees;
				rotation = Math.atan2(yDifference, xDifference) * radiansToDegrees;
			}
	}
	
}
