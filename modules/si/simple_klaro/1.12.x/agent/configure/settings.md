# Configure Simple Klaro

Everything is configured from one settings form. There is no per-service UI — the whole Klaro
config is a single JSON document you paste into a textarea.

- **Route:** `simple_klaro.settings` → `/admin/config/system/simple-klaro` (`_admin_route: TRUE`)
- **Permission:** `administer simple klaro`
- **Form:** `Drupal\simple_klaro\Form\SettingsForm` (extends `ConfigFormBase`)
- **Config object:** `simple_klaro.settings`
- **Menu link:** `simple_klaro.settings` under `system.admin_config_system` (weight `-20`)

## Config object keys (`simple_klaro.settings`)

| Key | Type | Form field | Meaning |
|-----|------|-----------|---------|
| `enabled` | boolean | checkbox "Enable Simple Klaro" | Master on/off. When off, nothing is attached and the block is hidden. |
| `config` | string | textarea "Klaro Config" (required, 20 rows) | The Klaro configuration as a **JSON string** (see below). Validated as JSON on submit. |
| `preferences` | string | textfield "Preferences label" (required, max 128) | Label for the re-open link/block. Defaults to `Cookie preferences`. |
| `library` | string | select "Klaro library" (required) | Which `simple_klaro.libraries.yml` variant to load (see table below). Default `klaro`. |
| `exclude_paths` | string | textarea "Exclude paths" | One path per line; `*` wildcard; `<front>` token. Consent manager is **not** loaded on matching paths. |

Schema is in `config/schema/simple_klaro.schema.yml` (`type: config_object`, all five keys typed as
above). Default values ship in `config/install/simple_klaro.settings.yml` (a demo config with
Google Analytics / Google Fonts / YouTube services and de/en translations).

### Validation & save behaviour

- `validateForm()` runs `Json::decode()` on `config` and sets an error if `json_last_error()` is
  not `JSON_ERROR_NONE` ("The data is not valid JSON.").
- `submitForm()` writes all five keys, calls the parent, then **`drupal_flush_all_caches()`** — so
  a saved config change takes effect on every page at once (rendered output is cache-tagged on the
  config; see runtime section).

## Set it without the UI

Drush:

```bash
drush config:set simple_klaro.settings enabled 1 -y
drush config:set simple_klaro.settings library klaro_no_css -y
# The Klaro JSON lives in the `config` key as a single string value.
drush config:set simple_klaro.settings config "$(cat my-klaro-config.json)" -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('simple_klaro.settings')
  ->set('enabled', TRUE)
  ->set('config', file_get_contents('my-klaro-config.json')) // JSON as a string
  ->set('preferences', 'Cookie preferences')
  ->set('library', 'klaro')       // one of the variant ids below
  ->set('exclude_paths', "/admin\n/admin/*")
  ->save();
drupal_flush_all_caches(); // the form does this; do it too if you bypass the form
```

## The Klaro JSON `config` (what goes in the textarea)

This is the upstream Klaro config object (see heyklaro.com/docs). The module passes it through
verbatim to the browser. Common top-level keys used by the shipped default:

- `elementID` (`"klaro"`), `storageMethod` (`"localStorage"`), `cookieName`, `cookieExpiresAfterDays`.
- `groupByPurpose` (bool) — group services by their `purposes` in the dialog.
- `privacyPolicy` — URL shown in the notice.
- `default`, `mustConsent`, `acceptAll`, `hideDeclineAll` — dialog behaviour flags.
- `translations` — per-language strings keyed by `lang` (e.g. `de`, `en`), each with
  `consentModal`, per-service descriptions, and a `purposes` map. Klaro picks the language from the
  `lang` attribute of the `<html>` element.
- `services` (an array; older configs used `apps` — `simple_klaro_update_8001()` migrates `apps` →
  `services` and sets `groupByPurpose`). Each service object:

  | Field | Purpose |
  |-------|---------|
  | `name` | machine id, matches the `data-name` on gated script tags |
  | `title` | label shown in the dialog |
  | `purposes` | array of purpose ids (grouped when `groupByPurpose`) |
  | `default` | pre-checked when the visitor first sees the dialog |
  | `required` | consent cannot be withdrawn |
  | `cookies` | array of names / regex strings (e.g. `"/^_ga.*$/"`) deleted when consent is revoked |
  | `contextualConsentOnly` | only ask in-context (e.g. per embed) |
  | `callback` | **string** of JS run when consent for the service changes (see next) |

### Service `callback`

If a service object contains a `callback`, `js/klaro.drupal.js` converts the string into a real
function at attach time (`service.callback = new Function('return ' + callback)()`) before handing
the config to `klaro.render()`. This lets a service run arbitrary opt-in/opt-out JS. The value is
authored only by an administrator through this form (the `administer simple klaro` permission is
`restrict access: true`).

## How consent gates a script

Klaro gates a third-party `<script>` by convention: give it `type="text/plain"` and
`data-name="<service name>"` (and `data-src` instead of `src`). Klaro flips it to an executable
type / restores the source once the visitor consents to that service, and re-blocks / deletes the
service's `cookies` when consent is revoked. The Drupal module does not rewrite your script tags —
you place them (via template, block, or another module) using that convention; Simple Klaro only
supplies and renders the Klaro config.

## Library variants (`library` key)

Selected by the "Klaro library" select; each id maps to a library in `simple_klaro.libraries.yml`.
Every variant also attaches `js/klaro.drupal.js` (the Drupal integration + a11y focus-trap) and,
for the local/CDN Klaro variants, the `klaro_sanitize` helper.

| `library` value | Source | CSS | Translations |
|-----------------|--------|-----|--------------|
| `klaro` (default) | local `/libraries/klaro/dist/klaro.js` | yes | yes |
| `klaro_no_css` | local `klaro-no-css.js` | no (bring your own) | yes |
| `klaro_no_translations` | local `klaro-no-translations.js` | yes | no |
| `klaro_no_translations_no_css` | local `klaro-no-translations-no-css.js` | no | no |
| `klaro_cdn` | external `cdn.kiprotect.com/klaro/v0.7.18/klaro.js` | yes | yes |
| `klaro_cdn_no_css` | external CDN `klaro-no-css.js` | no | yes |
| `klaro_cdn_no_translations` | external CDN `klaro-no-translations.js` | yes | no |
| `klaro_cdn_no_translations_no_css` | external CDN | no | no |

The `no-css` variants let you style the dialog to match the site theme. Local variants expect the
library at `/libraries/klaro/` — install it with Composer via the module's `composer.libraries.json`
(pins `kiprotect/klaro` `v0.7.22`; note the `libraries.yml` `version`/CDN URLs still reference
`0.7.18`) plus `wikimedia/composer-merge-plugin`. CDN variants need no local library.

## How it is embedded (runtime)

`simple_klaro_page_attachments()` (`hook_page_attachments` in `simple_klaro.module`) runs on every
page and:

1. Returns early (attaches nothing) if the current user has `bypass simple klaro`.
2. Reads `enabled`, `config`, `library`, `exclude_paths` from `simple_klaro.settings`.
3. If enabled and `config`+`library` are non-empty, and `exclude_paths` (evaluated with the core
   `request_path` condition plugin against path and alias) does not match, it sets
   `$page['#attached']['drupalSettings']['klaroConfig']` to the decoded config and attaches
   `simple_klaro/<library>`.
4. Always calls `renderer->addCacheableDependency($page, $config)` so pages are invalidated when the
   config changes (the form's `drupal_flush_all_caches()` also forces this).

`js/klaro.drupal.js` (`Drupal.behaviors.klaro`) then wires `#klaro-preferences` / `.klaro-preferences`
click handlers to `klaro.show()`, resolves any service `callback`, and calls `klaro.render()`. A
second behaviour (`klaroAccessibility`) moves the `#klaro` element to the top of `<body>` and traps
focus inside the open notice/modal for keyboard users.
