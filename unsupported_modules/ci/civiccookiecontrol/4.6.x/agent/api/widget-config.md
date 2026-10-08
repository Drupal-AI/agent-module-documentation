<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Cookie Control — widget config build & attach

The module builds a JSON configuration object server-side and hands it to Civic's hosted
`CookieControl.load(config)` JS on the client. No consent logic runs in Drupal.

## Page attachment (`civiccookiecontrol_page_attachments`)

On every request (`hook_page_attachments`):
1. Attaches the widget library. If IAB CMP is on it uses the `.header` variant so the script loads
   in `<head>`: `civiccookiecontrol/civiccookiecontrol{8|9}[.header]`. The `{8|9}` suffix comes
   from `civiccookiecontrol_api_key_version`.
2. Attaches `civiccookiecontrol/civiccookiecontrol.settings` (the `js/cookieControlSettings.js`
   loader) and, on the module's own admin pages / gin theme, admin CSS.
3. Sets `drupalSettings.path.civiccookiecontrol_path` (module path).
4. On non-admin pages (or admin pages if `civiccookiecontrol_drupal_admin` is on) sets
   `drupalSettings.civiccookiecontrol` = `CCCConfigFactory::getCccConfig($version)->getCccConfigJson()`.
5. If the `csp` module is enabled, adds a `script-src 'self' 'unsafe-eval'` directive (the loader
   uses `new Function()` to eval the onLoad/onAccept/onRevoke strings).

Library definitions live in `civiccookiecontrol.libraries.yml`; the external widget JS is loaded
over **HTTPS** from `https://cc.cdn.civiccomputing.com/8/cookieControl-8.x.min.js` or `/9/…`.
`hook_js_alter` marks those two scripts `preprocess=0`, `cache=0` so they are never aggregated.

## Config builders (`src/CCCConfig/`)

`CCCConfigFactory::getCccConfig($version)` returns the `civiccookiecontrol.CCC8Config` or
`.CCC9Config` service based on the API-key version. Both extend `AbstractCCCConfig`, which is
constructed with the config factory, entity-type manager, date formatter, `cache.data` and the
language manager.

`AbstractCCCConfig::loadCookieConfig()` assembles the base object from `civiccookiecontrol.settings`:
`apiKey`, `product`, cookie/behaviour flags, `necessaryCookies`, `optionalCookies`,
`excludedCountries`, and the `text` / `branding` / `accessibility` / `statement` sub-objects (each
`array_filter`ed to drop empties). `CCC9Config` overrides add v9-only keys (`setInnerHTML`,
`wrapInnerHTML`, `mode`, `acceptBehaviour`, sameSite/secure/ccCookie handling, `iabConfig` from
`civiccookiecontrol.iab2`, CCPA `ccpaConfig`, extra text keys) and the `locales` array (see
`config/entities.md`).

`getCccConfigJson()` `json_encode`s the object with `JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES`
and caches it under `civiccookiecontrol_config[_<lang>]` (permanent, tagged with the settings
config's cache tags). The settings-form submit deletes this cache key.

## Client loader (`js/cookieControlSettings.js`)

`Drupal.behaviors.cookieControlWidget` parses `drupalSettings.civiccookiecontrol`, converts the
`onLoad` and per-category `onAccept`/`onRevoke` string bodies back into functions via
`new Function('return ' + cc)()`, then calls `CookieControl.load(config)`. If `config.debug` is set
it `console.log`s the config; JSON with no optional cookies and IAB off logs a console error.

## API-key validation (`src/Form/CCCFormHelper`)

`validateApiKey($apiKey, $productType)` maps the four product tiers to Civic licence-name strings
and calls `checkValidity()`, which issues a Guzzle `\Drupal::httpClient()->get()` to
`https://apikeys.civiccomputing.com/c/v?d=<host>&p=<licence>&v=<version>&format=json&k=<key>` and
returns TRUE when the JSON response `valid == 1`. The `d` (domain) parameter is the server's own
`\Drupal::request()->getHost()`. `CookieControlAccess::checkApiKey()` wraps this to gate the
config UI. The Civic key is a public, domain-locked site key — it is meant to appear in page markup.
