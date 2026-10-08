Re-provides the third-party [js-cookie](https://github.com/js-cookie/js-cookie) JavaScript library as a Drupal asset library, so front-end code can read, write, and delete browser cookies after `core/js-cookie` was deprecated in Drupal 10 and removed in Drupal 11.

---

Drupal core once shipped a `core/js-cookie` asset library, but it was deprecated in Drupal 10 and removed in Drupal 11. This module fills that gap by defining a `js_cookie/js-cookie` asset library that points at the js-cookie 3.x library file (`js.cookie.min.js`). It prefers a locally hosted copy at `/libraries/js-cookie/dist/js.cookie.min.js` (installable by hand, via the Composer Merge Plugin, or via Asset Packagist) and, through a `hook_library_info_alter()` implementation, transparently falls back to a jsDelivr CDN copy when no local file is found. A `hook_requirements()` check reports on the status page whether the library is installed locally or being loaded from the CDN (the latter raising a privacy warning). The module has no configuration, routes, permissions, plugins, or services — it is purely an asset-provider dependency. Custom and contributed modules or themes depend on it by listing `js_cookie:js_cookie` in their `.info.yml` and attaching `js_cookie/js-cookie` in their own `.libraries.yml`, then calling the global `Cookies` API (e.g. `Cookies.set(...)`, `Cookies.get(...)`) from their JavaScript. It exists so modules that used the old core library keep working on modern Drupal without bundling their own copy.

---

- Read a browser cookie value from JavaScript with `Cookies.get('name')`.
- Set a cookie from front-end code with `Cookies.set('name', 'value')`.
- Set a cookie with an expiry, e.g. `Cookies.set('name', 'value', { expires: 7 })`.
- Scope a cookie to a path or domain via the options object.
- Delete a cookie with `Cookies.remove('name')`.
- Read all cookies at once with `Cookies.get()`.
- Store JSON-serializable data using the built-in JSON conversion helpers.
- Restore a module that relied on the removed `core/js-cookie` library on Drupal 11.
- Provide a shared cookie library so multiple modules don't each bundle js-cookie.
- Attach the library in a theme to manage front-end preference cookies.
- Remember a dismissed banner or notification in a cookie so it stays hidden.
- Persist a user's chosen tab, accordion, or UI state across page loads.
- Store a lightweight anonymous session flag without server-side state.
- Track cookie-consent choices set by a consent/GDPR banner.
- Read a cookie value in an AJAX or fetch handler to send with a request.
- Manage cookies from a decoupled/progressively-enhanced front end.
- Set a `SameSite` or `secure` cookie attribute via js-cookie options.
- Host the library locally to respect user privacy and avoid CDN calls.
- Rely on the automatic CDN fallback during quick prototyping or CI.
- Check the status report to confirm whether the library loads locally or via CDN.
- Install the library reproducibly with the Composer Merge Plugin.
- Install the library via Asset Packagist (`npm-asset/js-cookie`).
- Replace `core/js-cookie` dependencies in a `.libraries.yml` with `js_cookie/js-cookie`.
- Share cookie state between server-rendered pages and client-side widgets.
