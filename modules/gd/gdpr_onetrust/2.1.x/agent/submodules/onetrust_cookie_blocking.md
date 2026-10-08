<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: onetrust_cookie_blocking

**Machine name:** `onetrust_cookie_blocking`. **Depends on** `gdpr_onetrust`. Core `^10 || ^11`.
This is the half of the project that actually enforces consent: it takes JS/HTML Drupal would
otherwise emit and hands it to OneTrust's client-side `Optanon.InsertScript` / `Optanon.InsertHtml`
queue, so a script runs only after the visitor consents to its category. Cookies of declined
categories are deleted client-side.

## Configuration
Route `onetrust_cookie_blocking.settings` →
**`/admin/config/system/gdpr-onetrust/cookie-blocking`** (a "Cookie Blocking" local task under the
main GDPR route). Permission: the shared **`One Trust Access`**. Form
`Drupal\onetrust_cookie_blocking\Form\GDPROneTrustCookieBlocking`, config
`onetrust_cookie_blocking.settings`.

- **External JS** (`external_js_cookie`, textarea): one entry per line, `path/to/file.js|category`.
  Category ids: **2** performance, **3** functional, **4** targeting (README), **8** media (used
  internally for iframes). Example: `sites/default/files/tracker.js|2`.

There is **no config schema** shipped for `onetrust_cookie_blocking.settings`, and the form has two
functional bugs worth knowing: `submitForm()` references an undefined `$field_name` and writes a
`ga_performance_cookies` value that no field sets. `hook_update_8102`
(`onetrust_cokkie_blocking_update_8102`, note the typo'd function name)
migrates a legacy `cookieblocking.settings` object into the new name.

## Category constants
Defined in `onetrust_cookie_blocking.module`:
`ONETRUST_COOKIE_BLOCKING_PERFORMANCE = 2`, `..._FUNCTIONAL = 3`, `..._TARGETTING = 4`,
`..._MEDIA = 8`.

## How blocking works
1. **Scope gate — `GdprBlockjs::isGdprScope()`** returns TRUE only when a compliance UUID is set
   for the current language (same single-/multi-language key logic as the main module). Nothing is
   rewritten off an unconfigured site/language.
2. **`hook_js_alter()`** — for each `path|category` line, if that JS asset is present it is passed
   to `onetrust_cookie_blocking_gdpr_scopeing()`, which moves the asset's original `scope` under
   `gdpr_onetrust` and sets its `scope` to the sentinel `'gdpr_onetrust'` (pulling it out of normal
   aggregation/output).
3. **`hook_page_attachments()` / `hook_page_attachments_alter()`** — builds two `;`/`|`-delimited
   strings, `insertscript` and `inserthtml`, via the `GdprBlockjs` singleton, and passes them plus
   `base_domain` and `onetrust_version` in `drupalSettings.onetrust_cookie_blocking`. It also
   re-attaches the `onetrust_cookie_blocking/cookie-blocking` library.
4. **Google Analytics special case** — when `google_analytics` is enabled, the GA inline snippet in
   `html_head` is detected (`GoogleAnalyticsObject`), removed from the head, written to a physical
   `public://ga.js` by `onetrust_cookie_blocking_create_gajs()`, and re-queued as an external
   performance-category (2) script.
5. **iframe remediation — `hook_node_view()` / `onetrust_cookie_blocking_iframes()`** — scans the
   rendered node **body** for `<iframe>`s whose src matches markers `youtube` or
   `socialpollencount`, replaces each with `<div id="media_id_<rand>">`, and queues the original
   iframe HTML for `Optanon.InsertHtml` under targeting (v2) / media (v1). On v2 it also rewrites
   `www.youtube.com` → `www.youtube-nocookie.com`.
6. **Client side — `js/onetrust_cookie_blocking.js`** defines the global **`OptanonWrapper()`**
   (the callback OneTrust invokes after load): it parses the `insertscript`/`inserthtml` strings and
   calls `Optanon.InsertScript(...)` / `Optanon.InsertHtml(...)`, then `gdprDelete().assignCookie()`
   reads `OptanonActiveGroups` + `Optanon.GetDomainData()` and expires the cookies of every disabled
   category across a set of domain/host variants.

## Programmatic API — `GdprBlockjs`
Singleton (`GdprBlockjs::instance()`). Queue your own assets from custom code:
- `optanonInsertscript($js_path, $js_group, $position = 'head', array $additional = [])` — relative
  paths are prefixed with `$base_root`.
- `optanonInserthtml($element, $selector, $groupid, array $additional = [])` — `$element` is the
  HTML that would fire a third-party cookie, `$selector` the wrapper div id.
- `generateOptanons($array)` — de-dupes and queues a `[path => ['data'=>…, 'gdpr_onetrust'=>['group'=>…]]]` list.

The queued strings are only published when `isGdprScope()` is TRUE.

## Reality check
- Only assets you **name** (in `external_js_cookie`, the GA snippet, or the two iframe markers) are
  governed. A theme's own analytics tag, a third-party module's inline script, or an unlisted embed
  keeps firing regardless of consent.
- `optanonInserthtml` builds a **comma/pipe-delimited** string that the JS splits on `,` — HTML
  containing commas (most iframes with multiple attributes survive because only the whole match is
  wrapped, but arbitrary snippets can be mangled). Prefer the `external_js_cookie` list for scripts.
- Auto-blocking (`OtAutoBlock.js`, main-module setting) is OneTrust doing its own DOM scan; this
  submodule is the complementary server-side/Drupal-asset path. Decide which one owns a given script
  so it is not double-handled.
