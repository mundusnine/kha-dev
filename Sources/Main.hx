package;

import kha.audio1.Audio;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Sound;

class Main {
	static var snd:Sound;
	static function update(): Void {

	}

	static function render(frames: Array<Framebuffer>): Void {

	}

	public static function main() {
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });
				var t = Assets.sounds.get("tone");
				if(t == null){
					Assets.loadSound("tone",load, error);
				}
				else {
					snd = t;
					var channel = Audio.play(snd,false,0.5);
					channel.pitch = 0.5;
				}
			});
			
		});
	}
	public static function load(s:kha.Sound):Void{
		snd = s;
		var channel = Audio.play(snd,false,0.5);
		channel.pitch = 0.5;	
	}
	public static function error(error:kha.AssetError):Void{
			trace(error);
	}
}

