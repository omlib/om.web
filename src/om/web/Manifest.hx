package om.web;

@:enum abstract DisplayMode(String) to String {
	var fullscreen = "fullscreen";
	var standalone = "standalone";
	var minimal_ui = "minimal-ui";
	var browser = "browser";
}

@:enum abstract Dir(String) to String {
	var ltr = "ltr";
	var rtl = "rtl";
	var auto = "auto";
}

@:enum abstract Orientation(String) to String {
	var any = "any";
	var natural = "natural";
	var landscape = "landscape";
	var landscape_primary = "landscape-primary";
	var landscape_secondary = "landscape-secondary";
	var portrait = "portrait";
	var portrait_primary = "portrait-primary";
	var portrait_secondary = "portrait-secondary";
}

typedef Icon = {
	var src : String;
	var sizes : String;
	@:optional var type : String;
}

typedef RelatedApplication = {
	var platform : String;
	var url : String;
	var id : String;
}

/**
	JSON-based manifest file that provides developers with a centralized place to put metadata associated with a web application.

    The web app manifest provides information about an application (such as name, author, icon, and description) in a JSON text file.
    The purpose of the manifest is to install web applications to the homescreen of a device, providing users with quicker access and a richer experience.

    https://developer.mozilla.org/en-US/docs/Web/Manifest#icons
	https://w3c.github.io/manifest/

    Web app manifests are deployed in your HTML pages using a link tag in the head of your document:

        `<link rel="manifest" href="/manifest.json">`

    Manifests should be served using the `application/manifest+json` MIME type.
    However, it is optional to do so.

*/
typedef Manifest = {
    @:optional var background_color : String;
    @:optional var description : String;
    @:optional var dir : Dir;
    @:optional var display : DisplayMode;
    @:optional var icons : Array<Icon>;
    @:optional var lang : String;
    @:optional var name : String;
    @:optional var orientation : Orientation;
    @:optional var prefer_related_applications : Bool;
    @:optional var related_applications : Array<RelatedApplication>;
    @:optional var scope : String;
	@:optional var short_name : String;
	@:optional var start_url : String;
	@:optional var theme_color : String;
}
