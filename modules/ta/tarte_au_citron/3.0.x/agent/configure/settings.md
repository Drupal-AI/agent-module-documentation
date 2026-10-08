# Configure Tarte au citron

Two admin forms live under `/admin/config/tarte_au_citron` (a `SystemController` menu block page,
`tarte_au_citron.config`). The `configure` link points at the first.

| Route | Path | Form | Permission |
|---|---|---|---|
| `tarte_au_citron.configuration_js` | `/admin/config/tarte_au_citron/js` | `ConfigurationJsForm` | `administer tarte au citron` |
| `tarte_au_citron.configuration_texts` | `/admin/config/tarte_au_citron/texts` | `ConfigurationTextsForm` | `translate tarte au citron` |

Both extend `AbstractForm` (a `ConfigFormBase`) and are populated from the **installed JS library**, not
from static schema — see [../plugins/services.md](../plugins/services.md) for the discovery mechanism.

## Prerequisite: install the JS library

The module ships no JS library. Download [tarteaucitron.js](https://github.com/AmauriC/tarteaucitron.js)
into `web/libraries/tarteaucitron/` so `web/libraries/tarteaucitron/tarteaucitron.js` exists (plus
`tarteaucitron.services.js` and `lang/tarteaucitron.<lang>.js`). `tarte_au_citron_requirements()`
(runtime) shows a WARNING with the version "Missing" until it is present; when
`tarteaucitron.min.js` also exists, `hook_library_info_alter()` swaps the library to the minified file.
README documents a composer-merge route via `composer.libraries.json` (library `amauric/tarteaucitron`).

## Config object `tarte_au_citron.settings` (JS form)

Schema is a `config_entity` (`config/schema/tarte_au_citron.schema.yml`) whose `tacConfig` mapping is
**extended at runtime** by `hook_config_schema_info_alter()` with one key per discovered library default.

| Key | Type | Meaning |
|---|---|---|
| `tacConfig` | mapping | Every tarteaucitron.js default/parameter (checkbox for booleans, textfield otherwise). Keys ending `Url`/`Link` are treated as URLs. |
| `services` | sequence | Enabled service plugin ids (checkboxes; `array_filter`ed on save). |
| `services_settings` | mapping | Per-service settings, kept only for enabled services (`array_intersect_key`). |

- On **submit** URL-typed keys are validated (`ConfigurationJsForm::validateForm()` → `UrlHelper::isValid`),
  and on **attach** they are additionally passed through `UrlHelper::filterBadProtocol()`
  (`tarte_au_citron_page_attachments_alter`). Booleans use the `boolean` type; everything else `label`.
- `getJsConfig()` derives the key list by regex from `defaults = {…}` and `tarteaucitron.parameters.*`
  in `tarteaucitron.js`; keys starting `is`/`has` become booleans.

## Config object `tarte_au_citron.texts.settings` (texts form)

| Key | Type | Values | Meaning |
|---|---|---|---|
| `strategy` | string | `''` (Default) / `forced` / `custom` | How banner text is chosen. |
| `forced_lang` | string | `current` or a library language id | Used when `strategy = forced`; pins `tarteaucitronForceLanguage`. |
| `texts` | mapping (translatable) | discovered text ids → override strings | Used when `strategy = custom`; emitted as `tarteaucitronCustomText`. |

- `custom` text values are sanitized with `Xss::filterAdmin()` on save and again on attach
  (`_tarte_au_citron_filter_text()`), and empty values are dropped.
- The texts form is config-translatable (`tarte_au_citron.config_translation.yml`).
- Saving the JS form invalidates the `tarte_au_citron:configurations_texts` cache entry.

## What gets sent to the browser

`hook_page_attachments_alter()` (skipped when the user has `bypass tarte au citron`) attaches library
`tarte_au_citron/tarte_au_citron` and sets `drupalSettings.tarte_au_citron` = filtered `tacConfig` +
`user` (per-service params) + `services` (enabled ids) + the chosen `tarteaucitronCustomText` /
`tarteaucitronForceLanguage`. `js/init.js` then calls `Drupal.tarte_au_citron.init()` →
`tarteaucitron.init()`.

## Drush (core config only — no module Drush commands)

```bash
# enable two services and set a config flag
drush cset tarte_au_citron.settings services.gtag gtag -y
drush cset tarte_au_citron.settings tacConfig.orientation bottom -y
drush cr   # discovery is cached in the services_js bin
```
