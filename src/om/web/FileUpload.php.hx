package om.web;

import php.NativeAssocArray;
import php.SuperGlobal.*;
import php.Syntax;

// fork of php.Web.parseMultipart

typedef ReceivedFile = {
	var name : String;
	var type : String;
	var tmp_name : String;
	var error : Int;
	var size : Int;
}

class FileUpload {

	public function new() {
	}

	public function start( onFinish : ReceivedFile->Void ) {
		Syntax.foreach( _FILES, (part:String, data:NativeAssocArray<Dynamic>) -> {
			//trace(part,data);
			//if( part == 'file' ) {
				var err = data['error'];
				var fileUploaded = true;
				if( err > 0 ) {
					switch err {
					case 1: throw "The uploaded file exceeds the max size of " + php.Global.ini_get('upload_max_filesize');
					case 2: throw "The uploaded file exceeds the max file size directive specified in the HTML form (max is" + php.Global.ini_get('post_max_size') + ")";
					case 3: throw "The uploaded file was only partially uploaded";
					case 4: fileUploaded = false; // No file was uploaded
					case 6: throw "Missing a temporary folder";
					case 7: throw "Failed to write file to disk";
					case 8: throw "File upload stopped by extension";
					}
				}
				if( fileUploaded ) {
					var received : ReceivedFile = cast {};
					for( k=>v in data ) {
						Reflect.setField( received, k, v );
					}
					onFinish( received );
					/*
					if( data["size"] > maxFileSize ) {
						throw 'file size exceeded';
					} else {
						
						var path = uploadDir+'/'+data['name'];
						File.copy( data["tmp_name"], path );
	
						var stat = FileSystem.stat( path );
	
						var e = new files.db.Upload(
							stat.mtime.getTime(),
							data["name"],
							Std.parseInt( data["size"] ),
							php.Web.getClientIP()
						);
						e.insert();
						onReceived( e.toJson() );
					}
					*/
				}
			// } else {
			// 	trace(">>>>>>>>>>>>",part);
			// }
		});
	}
	
}