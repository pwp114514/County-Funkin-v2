package gameObjects.userInterface.vhsinfo;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class VHSInfo extends FlxSpriteGroup {
	var time:FlxText;
    var timer:Float = TimerDetail.seconds;
    var hourstimer:Int = TimerDetail.hours;
    var minutestimer:Int = TimerDetail.minutes;
    var timercountdown:FlxText;

    var pauseOptions:Array<String> = ["RESUME", "RESTART", "QUIT"];
    var curPauseSelection:Int = 0;
    var pauseOptionsText:FlxText;
    public function new(pause:Bool = false)
    {
        super();
        trace (TimerDetail.seconds);

        var curState = new FlxText(40, 50, 0, "", 60);
		curState.font = Paths.font("vcr.ttf");
		curState.scrollFactor.set();
		add(curState);

        var sign = new FlxSprite(-15, -190);
		sign.scale.set(0.08, 0.08);
		add(sign);
        if (!pause)
        {
			curState.text = "PLAY";

			sign.loadGraphic(Paths.image("vhsplay"));
        }
        else
        {
			curState.text = "PAUSE";

			sign.loadGraphic(Paths.image("vhspause"));
            sign.x += 35;

			pauseOptionsText = new FlxText(1050, 600, 0, "", 60);
			pauseOptionsText.font = Paths.font("vcr.ttf");
            add(pauseOptionsText);
			changePauseOption(0);
        }

        time = new FlxText(1050, 50, 0, "time", 60);
        time.font = Paths.font("vcr.ttf");
        time.scrollFactor.set();
        add(time);

		timercountdown = new FlxText(40, 600, 0, "", 60);
        timercountdown.font = Paths.font("vcr.ttf");
        timercountdown.scrollFactor.set();
        add(timercountdown);
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
        //ingame timer
        var secondstimerstring:String = "";
        var minutestimerstring:String = "";
        if (timer >= 60)
        {
            TimerDetail.minutes += 1;
            minutestimer += 1;
            timer = 0;
            TimerDetail.seconds = 0;
        }
        if (minutestimer >= 60)
        {
            TimerDetail.hours += 1;
            hourstimer += 1;
            minutestimer = 0;
            TimerDetail.minutes = 0;
        }
        if (hourstimer >= 24)
        {
            timer = 0;
            TimerDetail.seconds = 0;
            minutestimer = 0;
            hourstimer = 0;            
        }
        if (Std.int(timer) < 10)
            secondstimerstring = "0" + Std.string(Std.int(timer));
        else
            secondstimerstring = Std.string(Std.int(timer));
        if (minutestimer < 10)
            minutestimerstring = "0" + Std.string(minutestimer);
        else
            minutestimerstring = Std.string(minutestimer);    
        timercountdown.text = Std.string(hourstimer) + ":" + minutestimerstring + ":" + secondstimerstring;
        timer += elapsed;
        TimerDetail.seconds += elapsed;
        //

        //system timer
		var curTime = Date.now();
        var hours:String = "";
        var minutes:String = "";
        //

		if (curTime.getHours() < 10)
			hours = "0" + Std.string(curTime.getHours());
        else
			hours = Std.string(curTime.getHours());
		if (curTime.getMinutes() < 10)
			minutes = "0" + Std.string(curTime.getMinutes());
        else
			minutes = Std.string(curTime.getMinutes());

        time.text = hours + ":" + minutes;
    }

    public function changePauseOption(yeah:Int)
    {
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        curPauseSelection += yeah;

		if (curPauseSelection >= pauseOptions.length)
            curPauseSelection = 0;
        if (curPauseSelection < 0)
			curPauseSelection = pauseOptions.length - 1;

        pauseOptionsText.text = "> " + pauseOptions[curPauseSelection] + " <";
        pauseOptionsText.x = 1280 - pauseOptionsText.width - 50;
    }

	public function returnSelectedOption():String
	{
		return pauseOptions[curPauseSelection];
	}
}