# js_cookie — agent start

Asset-only module: defines the `js_cookie/js-cookie` library so JS can read/write cookies
after core removed `core/js-cookie` in Drupal 11. No config UI, routes, permissions, plugins,
or services. Local file at `/libraries/js-cookie/dist/js.cookie.min.js`, else CDN fallback.

- Depend on and attach the library, and call the `Cookies` API → [extend/library.md](extend/library.md)
