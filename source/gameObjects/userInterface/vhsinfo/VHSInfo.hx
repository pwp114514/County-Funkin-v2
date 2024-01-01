package gameObjects.userInterface.vhsinfo;

import flixel.FlxSprite;
import flixel.addons.ui.FlxUIText;
import flixel.group.FlxSpriteGroup;

class VHSInfo extends FlxSpriteGroup {
    var time:FlxUIText;
    var timer:Float = TimerDetail.seconds;
    var hourstimer:Int = TimerDetail.hours;
    var minutestimer:Int = TimerDetail.minutes;
    var timercountdown:FlxUIText;
    public function new()
    {
        super();
        trace (TimerDetail.seconds);
        var play = new FlxUIText(40, 50, 0, "PLAY", 60);
        play.font = Paths.font("vcr.ttf");
        play.scrollFactor.set();
        add(play);

		var playbutton = new FlxSprite(-15, -190);
		playbutton.loadGraphic(Paths.image("vhsplay"));
		playbutton.scale.set(0.08, 0.08);
		add(playbutton);

        time = new FlxUIText(1050, 50, 0, "time", 60);
        time.font = Paths.font("vcr.ttf");
        time.scrollFactor.set();
        add(time);

        timercountdown = new FlxUIText(40, 600, 0, "", 60);
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
}