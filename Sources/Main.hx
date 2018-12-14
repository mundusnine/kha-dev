package;

import kha.audio2.StreamChannel;
import kha.Blob;
import kha.audio1.Audio;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Sound;

class Main {
	static var snd:Sound=  new Sound();
	static var channel:kha.audio1.AudioChannel;
	static var up:Bool = false;
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
				var t = Assets.blobs.get("tone2");
				var a = Assets.sounds.get("tone");
				var playStream = false;
				if(t == null && playStream){
					Assets.loadBlob("tone2_ogg",loadBlob, error);
					// 
				}
				else if(playStream){
					var s:StreamChannel = new StreamChannel(t.bytes,false);
					s.play();
					trace(s);
					// channel.pitch = 0.5;
					s.volume = 1.0;
				}
				if(a==null && !playStream){
					Assets.loadSound("tone",load,error);
				}
				else if(!playStream){
					snd = a;
					var channel = Audio.play(snd,false,1.0);
					channel.pitch = 0.5;
				}
			});
			
		});
	}
	public static function load(s:kha.Sound):Void{
		snd = s;
		var channel = Audio.play(snd,false,1.0);
		channel.pitch = 0.5;	
	}
	public static function loadBlob(s:Blob):Void{
		snd.compressedData = s.bytes;
		var s = kha.audio1.Audio.stream(snd,false,0.5);
		// s.pitch= 0.5;
		// s.pitch = 0.4;	
	}
	public static function error(error:kha.AssetError):Void{
		trace("was here");
		throw(error);
	}
}

