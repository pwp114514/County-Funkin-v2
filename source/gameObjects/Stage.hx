package gameObjects;

import haxe.io.Path;
import flixel.util.FlxColor;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import gameObjects.background.*;
import meta.CoolUtil;
import meta.data.Conductor;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;

using StringTools;

/**
	This is the stage class. It sets up everything you need for stages in a more organised and clean manner than the
	base game. It's not too bad, just very crowded. I'll be adding stages as a separate
	thing to the weeks, making them not hardcoded to the songs.
**/
class Stage extends FlxTypedGroup<FlxBasic>
{
	public var curStage:String;

	public var background:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var foreground:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	public function new(curStage)
	{
		super();
		this.curStage = curStage;

		/// get hardcoded stage type if chart is fnf style
		if (PlayState.determinedChartType == "FNF")
		{
			// this is because I want to avoid editing the fnf chart type
			// custom stage stuffs will come with forever charts
			switch (CoolUtil.spaceToDash(PlayState.SONG.song.toLowerCase()))
			{
				case 'traumatized':
					curStage = 'bubu';
				case "expedited":
					curStage = "phonecall";	
				case "followed":
					curStage = "bedroom";
				case "lured":
					curStage = "basement";
				case "deceived":
					curStage = "field";
				case "pursued":
					curStage = "alleyway";
				case "remembered":
					curStage = "adamsroom";
				case "awakened":
					curStage = "church";
				case "befriended":
					curStage = "tv";
				default:
					curStage = 'stage';
			}

			PlayState.curStage = curStage;
		}

		//
		switch (curStage)
		{
			case "tv":
				curStage = "tv";
				PlayState.defaultCamZoom = 1.7;

				var tv = new FlxSprite(0, 0);
				tv.loadGraphic(Paths.image("backgrounds/befriended/bg"));
				tv.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(tv);

				var shine = new FlxSprite(0, 0);
				shine.loadGraphic(Paths.image("backgrounds/befriended/shine"));
				shine.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(shine);
				shine.alpha = 0;

				var tv2 = new FlxSprite(248, -73);
				tv2.loadGraphic(Paths.image("backgrounds/befriended/TV"));
				tv2.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(tv2);
				tv2.visible = false;

				var light = new FlxSprite(98, -223);
				light.loadGraphic(Paths.image("backgrounds/befriended/light"));
				light.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(light);
				light.visible = false;
			case "church":
				curStage = "church";
				PlayState.defaultCamZoom = 1;

				var gradientUnder = new FlxSprite(0, -400);
				gradientUnder.loadGraphic(Paths.image("backgrounds/awakened/gradientUnder"));
				gradientUnder.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				gradientUnder.scrollFactor.set();
				gradientUnder.screenCenter(X);
				background.add(gradientUnder);

				var sillouhette = new FlxSprite(0, -550);
				sillouhette.loadGraphic(Paths.image("backgrounds/awakened/sillouhette"));
				sillouhette.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				sillouhette.scrollFactor.set(0.2, 0.2);
				sillouhette.screenCenter(X);
				background.add(sillouhette);

				var trees = new FlxSprite(0, -550);
				trees.loadGraphic(Paths.image("backgrounds/awakened/trees"));
				trees.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				trees.scrollFactor.set(0.3, 0.3);
				trees.screenCenter(X);
				background.add(trees);

				var light = new FlxSprite(531, -234);
				light.loadGraphic(Paths.image("backgrounds/awakened/light"));
				light.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(light);

				var church = new FlxSprite(440, -125);
				church.loadGraphic(Paths.image("backgrounds/awakened/church"));
				church.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(church);
		
			case "adamsroom":
				curStage = "adamsroom";
				PlayState.defaultCamZoom = 0.9;

				var bg = new FlxSprite();
				bg.loadGraphic(Paths.image("backgrounds/remembered/computer"));
				bg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg);
			case "alleyway":
				curStage = "alleyway";
				PlayState.defaultCamZoom = 0.7;

				var bg = new FlxSprite();
				bg.loadGraphic(Paths.image("backgrounds/pursued/bg"));
				bg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg);
				bg.visible = false;

				var overlay = new FlxSprite();
				overlay.loadGraphic(Paths.image("backgrounds/pursued/overlay"));
				overlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				overlay.alpha = 0.3;
				foreground.add(overlay);
				overlay.visible = false;

				var bg2 = new FlxSprite(-60, -43);
				bg2.loadGraphic(Paths.image("backgrounds/pursued/ct1"));
				bg2.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg2);
				bg2.visible = false;

				var overlay2 = new FlxSprite(-60, -43);
				overlay2.loadGraphic(Paths.image("backgrounds/pursued/ct2"));
				overlay2.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(overlay2);
				overlay2.visible = false;
			case "field":
				curStage = "field";
				PlayState.defaultCamZoom = 0.3;

				var front = new FlxSprite();
				front.loadGraphic(Paths.image("backgrounds/deceived/gradient"));
				front.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(front);

				var back = new FlxSprite();
				back.loadGraphic(Paths.image("backgrounds/deceived/sand"));
				back.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(back);
				
				var mid = new FlxSprite();
				mid.loadGraphic(Paths.image("backgrounds/deceived/bg"));
				mid.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(mid);
			case "basement":
				curStage = "basement";
				PlayState.defaultCamZoom = 0.62;

				var bg = new FlxSprite(-500, -500);
				bg.loadGraphic(Paths.image("backgrounds/lured/basement"));
				bg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg);

				var staticBg = new FlxSprite(-400, 0);
				staticBg.frames = Paths.getSparrowAtlas("backgrounds/lured/static");
				staticBg.animation.addByPrefix("static", "static", 24, true);
				staticBg.animation.play("static");
				staticBg.scale.set(2, 2);
				staticBg.alpha = 0;
				staticBg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(staticBg);

				var tv = new FlxSprite(337, 330);
				tv.loadGraphic(Paths.image("backgrounds/lured/TV"));
				tv.scale.set(1.1, 1.1);
				tv.updateHitbox();
				tv.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(tv);

				var tvnotch = new FlxSprite(337, 330);
				tvnotch.loadGraphic(Paths.image("backgrounds/lured/TVnotch"));
				tvnotch.scale.set(1.1, 1.1);
				tvnotch.updateHitbox();
				tvnotch.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(tvnotch);

				var tvlights = new FlxSprite(-500, -500);
				tvlights.loadGraphic(Paths.image("backgrounds/lured/TVlights"));
				tvlights.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(tvlights);

				var blackOverlay = new FlxSprite();
				blackOverlay.makeGraphic(3000, 3000, FlxColor.BLACK);
				blackOverlay.scrollFactor.set();
				blackOverlay.screenCenter();
				blackOverlay.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				foreground.add(blackOverlay);

			case "bedroom":
				PlayState.defaultCamZoom = 0.53;
				curStage = "bedroom";

				var bg = new FlxSprite(0, 0);
				bg.loadGraphic(Paths.image("backgrounds/followed/bedroom"));
				bg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg);

				var dooralter = new FlxSprite(550, 320);
				dooralter.loadGraphic(Paths.image("backgrounds/followed/dooralter"));
				dooralter.scale.set(0.8, 0.8);
				dooralter.updateHitbox();
				dooralter.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(dooralter);
				dooralter.visible = false;

				var door = new FlxSprite(550, 320);
				door.loadGraphic(Paths.image("backgrounds/followed/door"));
				door.scale.set(0.8, 0.8);
				door.updateHitbox();
				door.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(door);
			case "phonecall":
				curStage = "phonecall";
				PlayState.defaultCamZoom = 0.52;

				var marsBG = new FlxSprite(0, 0);
				marsBG.loadGraphic(Paths.image("backgrounds/expedited/markbg"));
				marsBG.scale.set(0.34963325183, 0.2626953125);
				marsBG.updateHitbox();
				marsBG.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(marsBG);

				var shizarBG = new FlxSprite(1200, 0);
				shizarBG.loadGraphic(Paths.image("backgrounds/expedited/ceasarbg")); // name spelling mistake :sobbing emoji:
				shizarBG.scale.set(0.34963325183, 0.2626953125);
				shizarBG.updateHitbox();
				shizarBG.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(shizarBG);

			case "bubu":
				curStage = "bubu";
				PlayState.defaultCamZoom = 1.1;

				var bg = new FlxSprite(0, -30);
				bg.loadGraphic(Paths.image("backgrounds/traumatized/traumatizedBG"));
				bg.antialiasing = !Init.trueSettings.get('Disable Antialiasing');
				background.add(bg);

			default:
				PlayState.defaultCamZoom = 0.9;
				curStage = 'stage';
				var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('backgrounds/' + curStage + '/stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;

				// add to the final array
				add(bg);

				var stageFront:FNFSprite = new FNFSprite(-650, 600).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;

				// add to the final array
				add(stageFront);

				var stageCurtains:FNFSprite = new FNFSprite(-500, -300).loadGraphic(Paths.image('backgrounds/' + curStage + '/stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = true;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;

				// add to the final array
				add(stageCurtains);
		}
	}

	// return the girlfriend's type
	public function returnGFtype(curStage)
	{
		var gfVersion:String = 'gf';

		switch (curStage)
		{

		}

		return gfVersion;
	}

	// get the dad's position
	public function dadPosition(curStage, boyfriend:Character, dad:Character, gf:Character, camPos:FlxPoint):Void
	{
		var characterArray:Array<Character> = [dad, boyfriend];
		for (char in characterArray)
		{
			switch (char.curCharacter)
			{
				case 'gf':
					char.setPosition(gf.x, gf.y);
					gf.visible = false;
					/*
						if (isStoryMode)
						{
							camPos.x += 600;
							tweenCamIn();
					}*/
					/*
						case 'spirit':
							var evilTrail = new FlxTrail(char, null, 4, 24, 0.3, 0.069);
							evilTrail.changeValuesEnabled(false, false, false, false);
							add(evilTrail);
					 */
			}
		}
	}

	public function repositionPlayers(curStage, boyfriend:Character, dad:Character, gf:Character):Void
	{
		// REPOSITIONING PER STAGE
		gf.visible = false;
		switch (curStage)
		{
			case "tv":
				boyfriend.visible = false;
				dad.setPosition(340, -30);
				boyfriend.setPosition(330, 130);
			case "church":
				boyfriend.setPosition(-850, -50);
				dad.setPosition(480, -525);
			case "adamsroom":
				boyfriend.visible = false;
				boyfriend.setPosition(886, 265);
				dad.setPosition(770, 135);
			case "alleyway":
				boyfriend.setPosition(32, 20);
				dad.setPosition(695, 30);
			case "field":
				boyfriend.setPosition(2900, 1170);
				dad.setPosition(1000, 600);
				
			case "basement":
				boyfriend.setPosition(513, 456);
				boyfriend.visible = false;
				dad.setPosition(504, 382);

			case "bedroom":
				boyfriend.setPosition(1700, 490);
				dad.setPosition(300, 250);

			case "phonecall":
				boyfriend.setPosition(background.members[0].x - 50, background.members[0].y - 59);
				dad.setPosition(background.members[1].x - 130, background.members[1].y - 100);

			case "bubu":
				boyfriend.setPosition(430, 260);
				dad.setPosition(510, -50);
		}
	}

	public function stageUpdate(curBeat:Int, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		// trace('update backgrounds');
		switch (PlayState.curStage)
		{
			
		}
	}

	public function stageUpdateConstant(elapsed:Float, boyfriend:Boyfriend, gf:Character, dadOpponent:Character)
	{
		switch (PlayState.curStage)
		{

		}
	}
}
