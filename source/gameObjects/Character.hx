package gameObjects;

/**
	The character class initialises any and all characters that exist within gameplay. For now, the character class will
	stay the same as it was in the original source of the game. I'll most likely make some changes afterwards though!
**/
import flixel.FlxG;
import flixel.addons.util.FlxSimplex;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import gameObjects.userInterface.HealthIcon;
import meta.*;
import meta.data.*;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

typedef CharacterData =
{
	var offsetX:Float;
	var offsetY:Float;
	var camOffsetX:Float;
	var camOffsetY:Float;
	var quickDancer:Bool;
}

class Character extends FNFSprite
{
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var characterData:CharacterData;
	public var adjustPos:Bool = true;

	public function new(?isPlayer:Bool = false)
	{
		super(x, y);
		this.isPlayer = isPlayer;
	}

	public function setCharacter(x:Float, y:Float, character:String):Character
	{
		curCharacter = character;
		var tex:FlxAtlasFrames;
		antialiasing = true;

		characterData = {
			offsetY: 0,
			offsetX: 0,
			camOffsetY: 0,
			camOffsetX: 0,
			quickDancer: false
		};

		switch (curCharacter)
		{
			case "stanley":
				frames = Paths.getSparrowAtlas("characters/stanleycf");
				animation.addByPrefix('idle', 'stanleycf idle', 12, false);
				animation.addByPrefix('singUP', 'stanleycf up1', 12, false);
				animation.addByPrefix('singRIGHT', 'stanleycf right', 12, false);
				animation.addByPrefix('singDOWN', 'stanleycf down', 12, false);
				animation.addByPrefix('singLEFT', 'stanleycf left', 12, false);

				characterData.camOffsetX = -3;
				characterData.camOffsetY = 20;

				scale.set(1, 1);
				updateHitbox();
				playAnim("idle");
			case "dave":
				frames = Paths.getSparrowAtlas('characters/dave');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('death', 'death', 24, false);

				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);

				scale.set(1.8, 1.8);
				characterData.camOffsetX = -350;
				characterData.camOffsetY = -480;

				flipX = true;

				playAnim("idle");

			case "awakenedGabriel":
				frames = Paths.getSparrowAtlas('characters/GabrielAwakened');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				scale.set(1.25, 1.25);
				updateHitbox();
				
				characterData.camOffsetX = -300;
				characterData.camOffsetY = -150;

				playAnim("idle");

			case "awakenedGabrielAlt":
				frames = Paths.getSparrowAtlas('characters/ALTGabrielAwakened');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				scale.set(1.25, 1.25);
				updateHitbox();

				characterData.camOffsetX = -300;
				characterData.camOffsetY = -150;

				playAnim("idle");
				
			case "ruth":
				frames = Paths.getSparrowAtlas("characters/RuthCall");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				scale.set(1.3, 1.3);
				updateHitbox();
				playAnim("idle");

			case "thatcherCall":
				frames = Paths.getSparrowAtlas("characters/ThatcherCall");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);

				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);

				scale.set(1.3, 1.3);
				flipX = true;
				updateHitbox();
				playAnim("idle");


			case "pursuedAlt":
				frames = Paths.getSparrowAtlas("characters/pursuedAlt");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				scale.set(0.51, 0.51);
				updateHitbox();
				playAnim("idle");

				flipX = false;

				characterData.camOffsetX = 100;
				characterData.camOffsetY = 100;

			case "thatcher":
				frames = Paths.getSparrowAtlas("characters/thatcher");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);

				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				scale.set(0.85, 0.85);
				updateHitbox();
				flipX = true;
				playAnim("idle");

				characterData.camOffsetX = -180;
				characterData.camOffsetY = -60;

			case "noahScared":
				frames = Paths.getSparrowAtlas("characters/NoahScared");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				scale.set(1.25, 1.25);
				updateHitbox();
				flipX = true;
				playAnim("idle");

				characterData.camOffsetY -= 220;
				characterData.camOffsetX += 200;	

			case "noah":
				frames = Paths.getSparrowAtlas("characters/Noah");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				scale.set(1.25, 1.25);
				updateHitbox();
				flipX = true;
				playAnim("idle");

				characterData.camOffsetY -= 220;
				characterData.camOffsetX += 200;

			case "adamyoung":
				frames = Paths.getSparrowAtlas("characters/AdamAgain");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				scale.set(1.3, 1.3);
				updateHitbox();
				flipX = true;
				playAnim("idle");
				
			case "satan_front":
				frames = Paths.getSparrowAtlas("characters/Satan_Front");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				characterData.camOffsetY -= 455;
				characterData.camOffsetX -= 283;
				scale.set(1.9, 1.9);
				updateHitbox();
				playAnim("idle");

			case "gab_front":
				frames = Paths.getSparrowAtlas("characters/Gabriel_Front");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				characterData.camOffsetY -= 645;
				characterData.camOffsetX -= 323;
				scale.set(1.9, 1.9);
				updateHitbox();
				playAnim("idle");

			case "altGabriel":
				frames = Paths.getSparrowAtlas("characters/satan");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				scale.set(2, 2);
				updateHitbox();
				characterData.camOffsetY -= 700;
				characterData.camOffsetX += 30;
				playAnim("idle");

			case "gabriel":
				frames = Paths.getSparrowAtlas("characters/Gabriel");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				scale.set(2, 2);
				updateHitbox();
				characterData.camOffsetY -= 700;
				characterData.camOffsetX += 202;
				playAnim("idle");

			case "intruderRemembered":
				frames = Paths.getSparrowAtlas("characters/intrudermonitor");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				scale.set(1.25, 1.25);
				updateHitbox();
				characterData.camOffsetX -= 63;

			case "altIntruderRemembered":
				frames = Paths.getSparrowAtlas("characters/ALTintrudermonitor");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				scale.set(1.25, 1.25);
				updateHitbox();
				characterData.camOffsetX -= 63;

			case "intruderlured":
				frames = Paths.getSparrowAtlas("characters/intruderlured");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				scale.set(1.2, 1.2);
				characterData.camOffsetY += 50;

			case "intruderlured_alt":
				frames = Paths.getSparrowAtlas("characters/intruderlured_alt");
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				scale.set(1.2, 1.2);
				characterData.camOffsetY += 50;

			case "intruderSketch":
				frames = Paths.getSparrowAtlas("characters/IntruderFront");
				animation.addByPrefix('idle', 'idle', 24, true);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				scale.set(1.5625, 1.5625);
				updateHitbox();

			case "alternateAdam":
				frames = Paths.getSparrowAtlas('characters/AlternateAdamFront');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				scale.set(1.5625, 1.5625);
				updateHitbox();
				flipX = true;
				characterData.camOffsetX += 210;
				characterData.camOffsetY -= 380;

			case "scaredAdam":
				frames = Paths.getSparrowAtlas('characters/ScaredAdamFront');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				scale.set(1.5625, 1.5625);
				updateHitbox();
				flipX = true;
				characterData.camOffsetX += 210;
				characterData.camOffsetY -= 280;
				
			case "adam":
				frames = Paths.getSparrowAtlas('characters/AdamFront');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				scale.set(1.25, 1.25);
				updateHitbox();
				flipX = true;
				characterData.camOffsetX += 100;
				characterData.camOffsetY -= 200;
				
			case "mark":
				frames = Paths.getSparrowAtlas('characters/mark');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('shoot', 'shoot', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				scale.set(1.3, 1.3);
				updateHitbox();
				characterData.camOffsetX = 300;
				characterData.camOffsetY = -230;
				flipX = true;
				
			case "alternate":
				frames = Paths.getSparrowAtlas('characters/N');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				setGraphicSize(Std.int(width * 1.15));
				updateHitbox();
				characterData.camOffsetX = 300;
				characterData.camOffsetY = -350;

			case "markFront":
				frames = Paths.getSparrowAtlas('characters/MarkFront');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				scale.set(1.6, 1.6);
				updateHitbox();
				playAnim("idle");
				flipX = true;
				characterData.camOffsetX = 700;
				characterData.camOffsetY = -360;

			case "alt_cesar":
				frames = Paths.getSparrowAtlas('characters/alt_cesar');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				updateHitbox();

			case "cesarphone":
				frames = Paths.getSparrowAtlas('characters/cesarphone');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				playAnim("idle");
				updateHitbox();

			case "markphone":
				frames = Paths.getSparrowAtlas('characters/markphone');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				updateHitbox();

				flipX = true;
				
			case "smallmark":
				frames = Paths.getSparrowAtlas('characters/smallmark');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);
				animation.addByPrefix('singUPmiss', 'miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'miss down', 24, false);
				playAnim("idle");
				updateHitbox();
				characterData.camOffsetY -= 70;
				flipX = true;
			case "TRintruder":
				frames = Paths.getSparrowAtlas('characters/TRintruder');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				scale.set(0.7, 0.7);
				playAnim("idle");
				updateHitbox();
				characterData.camOffsetX += 20;
				characterData.camOffsetY += 12;
				
			case 'bf':
				frames = Paths.getSparrowAtlas('characters/BOYFRIEND');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				playAnim('idle');

				flipX = true;

				characterData.offsetY = 70;
					
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				playAnim('danceRight');

			default:
				// set up animations if they aren't already

				// fyi if you're reading this this isn't meant to be well made, it's kind of an afterthought I wanted to mess with and
				// I'm probably not gonna clean it up and make it an actual feature of the engine I just wanted to play other people's mods but not add their files to
				// the engine because that'd be stealing assets
				var fileNew = curCharacter + 'Anims';
				if (OpenFlAssets.exists(Paths.offsetTxt(fileNew)))
				{
					var characterAnims:Array<String> = CoolUtil.coolTextFile(Paths.offsetTxt(fileNew));
					var characterName:String = characterAnims[0].trim();
					frames = Paths.getSparrowAtlas('characters/$characterName');
					for (i in 1...characterAnims.length)
					{
						var getterArray:Array<Array<String>> = CoolUtil.getAnimsFromTxt(Paths.offsetTxt(fileNew));
						animation.addByPrefix(getterArray[i][0], getterArray[i][1].trim(), 24, false);
					}
				}
				else
					return setCharacter(x, y, 'bf');
		}

		// set up offsets cus why not
		if (OpenFlAssets.exists(Paths.offsetTxt(curCharacter + 'Offsets')))
		{
			var characterOffsets:Array<String> = CoolUtil.coolTextFile(Paths.offsetTxt(curCharacter + 'Offsets'));
			for (i in 0...characterOffsets.length)
			{
				var getterArray:Array<Array<String>> = CoolUtil.getOffsetsFromTxt(Paths.offsetTxt(curCharacter + 'Offsets'));
				addOffset(getterArray[i][0], Std.parseInt(getterArray[i][1]), Std.parseInt(getterArray[i][2]));
			}
		}

		dance();

		if (isPlayer) // fuck you ninjamuffin lmao
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
				flipLeftRight();
			//
		}
		else if (curCharacter.startsWith('bf'))
			flipLeftRight();

		if (adjustPos)
		{
			x += characterData.offsetX;
			trace('character ${curCharacter} scale ${scale.y}');
			y += (characterData.offsetY - (frameHeight * scale.y));
		}

		this.x = x;
		this.y = y;

		return this;
	}

	function flipLeftRight():Void
	{
		// get the old right sprite
		var oldRight = animation.getByName('singRIGHT').frames;

		// set the right to the left
		animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;

		// set the left to the old right
		animation.getByName('singLEFT').frames = oldRight;

		// insert ninjamuffin screaming I think idk I'm lazy as hell

		if (animation.getByName('singRIGHTmiss') != null)
		{
			var oldMiss = animation.getByName('singRIGHTmiss').frames;
			animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
			animation.getByName('singLEFTmiss').frames = oldMiss;
		}
	}

	override function update(elapsed:Float)
	{
		if (!isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		var curCharSimplified:String = simplifyCharacter();
		switch (curCharSimplified)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
				if ((animation.curAnim.name.startsWith('sad')) && (animation.curAnim.finished))
					playAnim('danceLeft');
		}

		// Post idle animation (think Week 4 and how the player and mom's hair continues to sway after their idle animations are done!)
		if (animation.curAnim.finished && animation.curAnim.name == 'idle')
		{
			// We look for an animation called 'idlePost' to switch to
			if (animation.getByName('idlePost') != null)
				// (( WE DON'T USE 'PLAYANIM' BECAUSE WE WANT TO FEED OFF OF THE IDLE OFFSETS! ))
				animation.play('idlePost', true, false, 0);
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(?forced:Bool = false)
	{
		if (!debugMode)
		{
			var curCharSimplified:String = simplifyCharacter();
			switch (curCharSimplified)
			{
				case 'gf':
					if ((!animation.curAnim.name.startsWith('hair')) && (!animation.curAnim.name.startsWith('sad')))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight', forced);
						else
							playAnim('danceLeft', forced);
					}
				default:
					// Left/right dancing, think Skid & Pump
					if (animation.getByName('danceLeft') != null && animation.getByName('danceRight') != null)
					{
						danced = !danced;
						if (danced)
							playAnim('danceRight', forced);
						else
							playAnim('danceLeft', forced);
					}
					else
						playAnim('idle', forced);
			}
		}
	}

	override public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (animation.getByName(AnimName) != null)
			super.playAnim(AnimName, Force, Reversed, Frame);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
				danced = true;
			else if (AnimName == 'singRIGHT')
				danced = false;

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
				danced = !danced;
		}
	}

	public function simplifyCharacter():String
	{
		var base = curCharacter;

		if (base.contains('-'))
			base = base.substring(0, base.indexOf('-'));
		return base;
	}
}
