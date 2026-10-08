# Configure the Cookie Control widget

Main form: **`\Drupal\civiccookiecontrol\Form\CivicCookieControlSettings`** (form id
`civiccookiecontrol_config_form`) at `/admin/config/system/cookiecontrol` (route
`cookiecontrol.admin_overview`, permission `administer civiccookiecontrol`). It is a **multi-step**
form driven by `civiccookiecontrol.CCCStepsManager`:

1. **License info step** (`CCCLicenseInfo`) — shown until a valid key exists. You enter the Civic
   **API key** (`civiccookiecontrol_api_key`) and pick the **product/license type**
   (`civiccookiecontrol_product`: `COMMUNITY` | `PRO` | `PRO_MULTISITE` | `CUSTOM`). On submit the key is
   validated against Civic (`CCCFormHelper::validateApiKey()` → `https://apikeys.civiccomputing.com/c/v`).
2. **Settings step** (`CCCSettings`) — appears once the key validates; grouped into `details` fieldsets:
   Product Information, Customising Appearance/Text/Behaviour, Privacy Statement, CCPA Privacy Statement,
   Custom Branding (hidden for `COMMUNITY`), Accessibility. Field definitions come from the YAML files in
   `src/Form/CookieControlFormElements/*.yml`.

Extra tabs (local tasks under the same base route):
- `cookiecontrol.iab1` → IAB TCF v1 settings (`IAB1Settings`, config `civiccookiecontrol.iab`).
- `cookiecontrol.iab2` → IAB TCF v2 settings (`IAB2Settings`, config `civiccookiecontrol.iab2`); pulls the
  vendor list from `https://cc.cdn.civiccomputing.com/vl/v2/additional-vendor-information-list.json`.
- Entity collection tabs (cookie categories / necessary cookies / excluded countries / alt languages) —
  see [entities.md](entities.md).

## Config objects

Three config objects (constants in `\Drupal\civiccookiecontrol\CCCConfigNames`):

| Constant | Config name | Purpose |
|---|---|---|
| `COOKIECONTROL` | `civiccookiecontrol.settings` | The widget config (~130 keys, all `civiccookiecontrol_*`). Default values in `config/install/civiccookiecontrol.settings.yml`, schema in `config/schema/civiccookiecontrol.schema.yml`. |
| `IAB` | `civiccookiecontrol.iab` | IAB TCF v1 text/flags (used when `api_key_version == 8`). |
| `IAB2` | `civiccookiecontrol.iab2` | IAB TCF v2 text/flags + `iabCMP` on/off. |

Only `civiccookiecontrol.settings` is editable through the main form
(`getEditableConfigNames()`); the IAB objects have their own forms.

### Most operationally significant keys (`civiccookiecontrol.settings`)

| Key | Default | Meaning |
|---|---|---|
| `civiccookiecontrol_api_key` | `''` | Civic license/API key (a **client-side widget key**, sent to the browser by design). |
| `civiccookiecontrol_api_key_version` | `9` | `8` or `9` — selects the CDN script and `CCC8Config`/`CCC9Config`. |
| `civiccookiecontrol_product` | `COMMUNITY` | License tier; must match what the key is valid for. |
| `civiccookiecontrol_mode` | `GDPR` | `GDPR` or `CCPA` (v9 only; CCPA is incompatible with IAB TCF v2). |
| `civiccookiecontrol_locale_mode` | `browser` | `browser` = expose all alt languages; `drupal` = follow Drupal's current language (needs `language` module). |
| `civiccookiecontrol_initial_state` | `OPEN` | Banner initial state. |
| `civiccookiecontrol_layout` | `SLIDEOUT` | Widget layout. |
| `civiccookiecontrol_widget_position` / `_widget_theme` | `LEFT` / `LIGHT` | Placement + theme. |
| `civiccookiecontrol_drupal_admin` | `false` | If false, the widget is NOT injected on admin routes. |
| `civiccookiecontrol_onload` | `''` | Raw JS body run as the widget `onLoad` (wrapped `function(){…}` and eval'd client-side). |
| `civiccookiecontrol_privacynode` / `_ccpa_privacynode` | `''` | Node id whose URL becomes the statement link. |
| `civiccookiecontrol_log_consent` | `false` | Enable Civic consent logging. |
| `civiccookiecontrol_secure_cookie` / `_same_site_cookie` / `_same_site_value` | `false` / `true` / `Strict` | Consent-cookie flags. |
| `civiccookiecontrol_debug` | `false` | `console.log` the config client-side. |

The remaining keys are 1:1 text/colour/font/accessibility fields that map straight onto Civic's config
object (see `AbstractCCCConfig` / `CCC9Config` for the exact JSON keys they populate). Because there are
~130 of them, read `config/install/civiccookiecontrol.settings.yml` for the full default set rather than
enumerating here.

### Set the essentials with Drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('civiccookiecontrol.settings');
$config
  ->set('civiccookiecontrol_api_key', 'YOUR-CIVIC-KEY')
  ->set('civiccookiecontrol_product', 'COMMUNITY')   // or PRO / PRO_MULTISITE / CUSTOM
  ->set('civiccookiecontrol_api_key_version', 9)
  ->set('civiccookiecontrol_mode', 'GDPR')
  ->save();
// The built config JSON is cached under cid 'civiccookiecontrol_config[_<lang>]'; clear it after changes:
\Drupal::cache()->delete('civiccookiecontrol_config');
drupal_flush_all_caches(); // or drush cr
```

`drush cset civiccookiecontrol.settings civiccookiecontrol_api_key 'YOUR-KEY' -y` also works. The form's
own submit rebuilds the router and deletes the config cache; a plain `cset` should be followed by `drush cr`.

## How the widget JS is embedded (runtime)

`civiccookiecontrol_page_attachments()` (`hook_page_attachments`) on every page:

1. Attaches the **external CDN library** `civiccookiecontrol/civiccookiecontrol{8|9}` (or the `.header`
   variant when IAB CMP is on) — this is Civic's `cookieControl-{8,9}.x.min.js`. `hook_js_alter` sets
   `preprocess=0 / cache=0` on it so it is never aggregated.
2. Attaches local library `civiccookiecontrol/civiccookiecontrol.settings` (`js/cookieControlSettings.js`).
3. Sets `drupalSettings.civiccookiecontrol` to the JSON string returned by
   `CCCConfigFactory::getCccConfig($version)->getCccConfigJson()` — **only** when the route is not an admin
   route, unless `civiccookiecontrol_drupal_admin` is true.
4. If the `csp` module is enabled, adds a `script-src: 'self' 'unsafe-eval'` directive (the widget config
   contains JS callbacks that are eval'd — see below).

`js/cookieControlSettings.js` then: `JSON.parse(drupalSettings.civiccookiecontrol)` → converts the
`onLoad` string and each optional-cookie `onAccept`/`onRevoke` string into real functions via
`new Function('return ' + cc)()` → calls `CookieControl.load(config)`. These callback strings come from the
settings form and from cookie-category entities (both `administer civiccookiecontrol`-only).

The JSON is assembled in `AbstractCCCConfig` (+ `CCC8Config` / `CCC9Config`), which map the flat config
keys onto Civic's nested object (`text`, `branding`, `statement`, `ccpaConfig`, `accessibility`,
`optionalCookies`, `necessaryCookies`, `excludedCountries`, `locales`, `iabConfig`). Result is cached
permanently under `civiccookiecontrol_config[_<lang>]` with the config's cache tags.

## Config schema note

`config/schema/civiccookiecontrol.schema.yml` declares all three mappings. Entity schemas live in
`config/schema/civiccookiecontrol_*.schema.yml`. Install also seeds a `cookie_control_html` text
format/editor (`config/optional/**`) used by the rich-text settings fields, created/removed by
`civiccookiecontrol_install_html_format()` on (un)install of ckeditor/ckeditor5.
