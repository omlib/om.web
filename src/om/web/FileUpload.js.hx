package om.web;

import js.html.FormData;
import js.html.File;
import js.html.XMLHttpRequest;
import js.lib.Promise;

class FileUpload {

	public final url : String;

	var xhr : XMLHttpRequest;

	public function new( url : String ) {
		this.url = url;
	}

	public function start( file : File ) : Promise<String> {
		return new Promise( function(resolve,reject){
			xhr = new XMLHttpRequest();
			xhr.upload.addEventListener( 'progress', function(e){
				//trace(e);
				//progress.max = e.total;
				//progress.value = e.loaded;
			//	onProgress( e.loaded );
			}, false );
			xhr.upload.addEventListener( 'load', function(e){
				//trace(e);
				//resolve( Json.parse(e) );
			}, false );
			xhr.addEventListener( 'readystatechange', function(e){
				//console.debug(xhr);
				if( xhr.readyState == 4 ) {
					//progress.remove();
					if( xhr.status == 200 ) {
						var res = xhr.response;
						xhr = null;
						resolve( res );
					} else {
						var status = xhr.statusText;
						xhr = null;
						reject( status );
					}
				}
			}, false );
			xhr.upload.addEventListener( 'loadend',  function(e){
				trace('loadend',e);
			});
			xhr.upload.addEventListener( 'abort',  function(e){
				trace('abort',e);
			});
			xhr.upload.addEventListener( 'abort',  function(e){
				trace('abort',e);
			});
		//	xhr.open( "POST", '$url?id=upload' );
			xhr.open( "POST", url );
			//xhr.overrideMimeType( 'text/plain; charset=x-user-defined-binary' );
			/* 
			var reader = new FileReader();
			  reader.onload = function(e) {
			  //xhr.send( e.target.result );
			}
			reader.readAsBinaryString( file );
	*/
			//trace(file.name);
			var form = new FormData();
			form.append( 'file', file );
			xhr.send( form );
		});
	}
	
	//TODO
	public function abort() {
		if( xhr != null ) {
			xhr.abort();
		}
	}
}