package{	import flash.display.Stage;	import flash.display.MovieClip;	import flash.events.Event;
	import flash.media.Sound;	import flash.events.MouseEvent;	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
		public class Main extends MovieClip	{		public var player:Player;
		var startbtn:Start;
		public var kills:Number=0;		public var bulletList:Array = new Array();		public var enemyList:Array = new Array();		public var mousePressed:Boolean = false; //keeps track of whether the mouse is currently pressed down		public var delayCounter:int = 0; //we use this to add delay between the shots		public var delayMax:int = 8; //try changing this number to shoot more or less rapidly		var timeCounter:TextField;
		var counterTimer:Timer;		public function Main():void		{
				gameOverText.visible = false;
				gameOverTextScore.visible = false;
				startbtn = new Start();
				stage.addChild(startbtn);
				startbtn.addEventListener(MouseEvent.CLICK,start);
				
		}		public function start(e:Event):void{
			counterTimer = new Timer(1000,60);
			counterTimer.addEventListener(TimerEvent.TIMER,displayTime);
			timeCounter = new TextField();
			timeCounter.text = "Time Remaining:0";
			timeCounter.textColor = 0xFF0000;
			stage.addChild(timeCounter);
			counterTimer.start();
			counterTimer.addEventListener(TimerEvent.TIMER_COMPLETE,gameOver);
			var themeSongSound:Sound = new themeSong();
			themeSongSound.play();
			player = new Player(stage, 320, 240);
			stage.addChild(player);
			var enemyTimer:Timer = new Timer(1000,200);
			enemyTimer.addEventListener(TimerEvent.TIMER,createEnemies);
			enemyTimer.start();
			//stage.addEventListener(MouseEvent.CLICK, shootBullet, false, 0, true); //remove this
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			
			stage.addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			stage.addEventListener(Event.ENTER_FRAME, detectCollision);
			stage.addEventListener(BulletCollidedEvent.EVENT_NAME,bulletCollisionHandler);
			stage.removeChild(startbtn);
			logo.visible = false;
		}
		public function displayTime(e:TimerEvent){
				timeCounter.text = "Time Remaining:"+ (30-counterTimer.currentCount).toString();
		}
		public function gameOver(e:Event)
		{
				deleteAll();
				
				gameOverText.visible = true;
				gameOverTextScore.visible = true;
				gameOverTextScore.appendText("core: " + (kills*1).toString());
				trace("Score: " + kills.toString());
		}
		public function deleteAll(){
			player.alpha = 0;
			for each (var enemy:Enemy in enemyList){
					enemy.alpha = 0;
			}
		}		public function loop(e:Event):void		{			if(mousePressed) // as long as the mouse is pressed...			{				delayCounter++; //increase the delayCounter by 1				if(delayCounter == delayMax) //if it reaches the max...				{					shootBullet(); //shoot a bullet					delayCounter = 0; //reset the delay counter so there is a pause between bullets				}			}						if(bulletList.length > 0)			{				for(var i:int = bulletList.length-1; i >= 0; i--)				{					bulletList[i].loop();				}			}		}				public function mouseDownHandler(e:MouseEvent):void //add this function		{			mousePressed = true; //set mousePressed to true		}				public function mouseUpHandler(e:MouseEvent):void //add this function		{			mousePressed = false; //reset this to false		}				public function shootBullet():void //delete the "e:MouseEvent" parameter		{
			var bulletShotSound:Sound = new bulletShot();
			bulletShotSound.play()			var bullet:Bullet = new Bullet(stage, player.x, player.y, player.rotation);			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);			bulletList.push(bullet);			stage.addChild(bullet);		}				public function bulletRemoved(e:Event):void		{			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved);			bulletList.splice(bulletList.indexOf(e.currentTarget),1);		}
		public function createEnemies(e:Event):void{
			var enemy:MovieClip = new Enemy(player,Math.random()*width,Math.random()*stage.height);
			enemyList.push(enemy);
			stage.addChild(enemy);
	
		}
		public function detectCollision(e:Event):void{
			for each(var bullet:Bullet in bulletList){
					for each(var enemy:Enemy in enemyList){
							if(bullet.hitTestObject(enemy)){
						//	if(bullet.x==enemy.x && bullet.y==enemy.y){
								var bulletCollision:BulletCollidedEvent = new BulletCollidedEvent(BulletCollidedEvent.EVENT_NAME,bullet,enemy);
								stage.dispatchEvent(bulletCollision);
							}
					}
			}
		}
		public function bulletCollisionHandler(e:BulletCollidedEvent){
			kills++;
			enemyList.splice(enemyList.indexOf(e.enemyReference));
			stage.removeChild(e.enemyReference);
		}	}}