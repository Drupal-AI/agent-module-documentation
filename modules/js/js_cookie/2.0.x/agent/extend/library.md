# Use the js-cookie library

## Declare the dependency
In your module's `.info.yml`:
```yaml
dependencies:
  - js_cookie:js_cookie
```
If your module has a manual `composer.json`, also add `"drupal/js_cookie": "^2.0"`.

## Attach the asset library
In your own `.libraries.yml`, depend on it (replaces any old `core/js-cookie`):
```yaml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - js_cookie/js-cookie
```
Attach in render arrays with `#attached: { library: ['mymodule/my_widget'] }` or in JS/Twig.

## Call the API (global `Cookies` object)
```js
Cookies.set('theme', 'dark', { expires: 30, path: '/' }); // write, 30-day expiry
const theme = Cookies.get('theme');                        // read one
const all = Cookies.get();                                  // read all
Cookies.remove('theme', { path: '/' });                     // delete
```
Full API: https://github.com/js-cookie/js-cookie (v3.x).

## Local vs CDN
Provide `/libraries/js-cookie/dist/js.cookie.min.js` (see README install options) to serve
locally. If absent, `js_cookie_library_info_alter()` swaps in the jsDelivr CDN copy and
`hook_requirements()` shows a privacy warning on `/admin/reports/status`.
