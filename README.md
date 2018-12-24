#  Global.js Safari App Extension

This is a proof-of-concept Safari app extension for embedding a `WKWebView` view from the WKWebkit framework inside a Safari app extension.  Tested on macOS 10.14.2 Mojave and Safari Technology Preview 72.  YMMV on other versions.

In porting legacy Safari extensions (.safariextz), one of the major challenges is that legacy extensions tend to have lots of logic written in Javascript, in the background.html/background.js/global.html/global.js file.  Porting all of this JS to Objective-C / Swift is fairly challenging.

## Concept

Instead of doing that, the idea here is:

1.  we embed a `WKWebView` instance inside the app extension
2.  have it load `global.html` + `global.js` on first invocation.  
3.  call `[webkitview evaluateJavaScript:...]` on demand to run arbitrary Javascript from global.js, then proxy the return values to our `injected.js` script.

## Results / Caveats

- Compile the project and run the extension.  
- Reload the main page after the extension runs.  This ensures that the injected script loads (Safari sometimes doesn't inject app extension content scripts correctly).
- Click the toolbar item installed by the extension.
- See that the global.js function `test2` is successfully invoked, and its results printed via an `alert()` call in the injected script.

Success!  Sort of.

The process of calling JS functions with simple values is fairly straightforward.  However, I have yet to figure out how to call `evaluateJavascript` with arbitrarily complex JS objects.

## Notes

- The app extension target (not the main containing app target) must have the "Outgoing Connections (client)" capability granted in the App Sandbox.
