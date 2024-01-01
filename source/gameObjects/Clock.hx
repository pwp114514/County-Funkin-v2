package gameObjects;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import meta.FlxTweenPlayState;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import openfl.display.BitmapDataChannel;

class Clock extends FlxSprite
{
	var second:FlxSprite;
	var minute:FlxSprite;
	var clock:FlxSprite;

	public function new(X:Float = 0, Y:Float = 0)
	{
		clock = new FlxSprite(0, 0, Paths.image("county-sprites/pursued/clock"));

		second = new FlxSprite(0, 0, Paths.image("county-sprites/pursued/second"));

		minute = new FlxSprite(0, 0, Paths.image("county-sprites/pursued/minute"));

		super(X, Y, clock.pixels.clone());

		stamp(second);
		stamp(minute);
	}

    public function setTime(second:Float = 0, minute:Float = 0)
    {
        if (second == 0) second = 12;
        if (minute == 0) minute = 12;

        this.second.angle = 360 / (12 / second);
        this.minute.angle = 360 / (12 / minute);

		stamp(clock);
		stamp(this.second);
		stamp(this.minute);
    }

    public function click()
    {
		second.angle += 6;
		if (second.angle == 360)
			second.angle = 0;

		if (second.angle == 0)
			minute.angle += 6;

		stamp(clock);
		stamp(second);
		stamp(minute);
    }
}