# JavaScript Cookie Library — manual setup guide

**JavaScript Cookie Library** (`js_cookie`) re-provides the popular third-party
[js-cookie](https://github.com/js-cookie/js-cookie) JavaScript library to Drupal
as an asset library, so your front-end code can read, write, and delete browser
cookies. Drupal core used to ship a `core/js-cookie` library, but it was
deprecated in Drupal 10 and removed in Drupal 11 — this module fills that gap so
modules and themes that relied on it keep working on modern Drupal.

Under the hood it defines a single asset library, `js_cookie/js-cookie`, that
points at the js-cookie 3.x file. It prefers a locally hosted copy at
`/libraries/js-cookie/dist/js.cookie.min.js` and, if that file isn't present,
transparently falls back to a jsDelivr CDN copy. A status-report check on
**Reports → Status report** (`/admin/reports/status`) tells you which of the two
is in effect — and warns you when the CDN copy is being used, since that sends a
request to a third party.

This is a **developer-facing** module: it has no configuration form, no routes,
no permissions, and no settings to click through. You don't use it directly —
other modules or themes declare it as a dependency and then call the global
`Cookies` API from their JavaScript. It depends only on the external js-cookie
library (nothing else in Drupal), and it ships no submodules.

This guide is written for a **human** setting the library up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and provide the js-cookie library file locally.

## How to use it

There is no admin page for this module — it surfaces purely as a JavaScript asset
library that other code attaches. To use it in your own module or theme:

1. **Declare the dependency** in your `.info.yml`:

   ```yaml
   dependencies:
     - js_cookie:js_cookie
   ```

2. **Attach the asset library** from your own `.libraries.yml` (this replaces any
   old `core/js-cookie` dependency):

   ```yaml
   my_widget:
     js:
       js/my-widget.js: {}
     dependencies:
       - js_cookie/js-cookie
   ```

   Then attach it from a render array with
   `#attached: { library: ['mymodule/my_widget'] }`, or from Twig/JS.

3. **Call the global `Cookies` API** from your JavaScript:

   ```js
   Cookies.set('theme', 'dark', { expires: 30, path: '/' }); // write, 30-day expiry
   const theme = Cookies.get('theme');                        // read one
   const all = Cookies.get();                                 // read all
   Cookies.remove('theme', { path: '/' });                    // delete
   ```

   The full API (expiry, path/domain scoping, `SameSite`/`secure` attributes, JSON
   helpers) is documented at <https://github.com/js-cookie/js-cookie> (v3.x).

To confirm which copy of the library is loading, open **Reports → Status report**:
it reports whether js-cookie is served locally or from the CDN.
