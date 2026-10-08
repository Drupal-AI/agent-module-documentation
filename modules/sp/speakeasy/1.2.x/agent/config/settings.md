<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speakeasy — settings, routes & permissions

Install/enable: `drush en speakeasy`. No dependencies beyond Drupal core. Install ships
`config/install/speakeasy.settings.yml`. Configure at `/admin/config/speakeasy`
(also linked under Configuration > Web services via `speakeasy.links.menu.yml`).

## Config object `speakeasy.settings`
Schema: `config/schema/speakeasy.schema.yml`. Default install values in parentheses.

| Key | Type | Meaning |
|-----|------|---------|
| `allowed_voices_by_browser` | mapping of `chrome`/`edge`/`firefox`/`safari`/`other` → sequence of strings | Per-browser voice whitelist. Empty (`{}`) = allow all. |
| `allowed_languages` | sequence of langcodes | Restrict voices to these languages. Empty (`[]`) = all. |
| `default_speed` | float (`1`) | Default rate, 0.1–2. |
| `theme` | string (`default`) | `none`, `default`, or `olivero` — selects a bundled CSS library or none. |
| `allow_voice_selection` | boolean (`true`) | Globally permit the voice dropdown in blocks. |
| `allow_highlighting` | boolean (`true`) | Globally permit sentence highlighting in blocks. |

Note: the block also reads `default_voice_name`, which has **no schema key and no install
default** — it is only ever `null` unless set out of band; the block treats it as an
optional fallback voice name (`SpeakeasyBlock::build()`).

## Settings form `SpeakeasySettingsForm`
`src/Form/SpeakeasySettingsForm.php`, form id `speakeasy_settings_form`, extends
`ConfigFormBase`. DI: `config.factory`, `config.typed`, `logger.factory` (channel `speakeasy`),
`language_manager`. Three vertical-tab groups: **Block options** (theme, `allow_voice_selection`,
`allow_highlighting`, `default_speed`), **Voice Whitelisting by Browser** (a comma-separated
textfield per browser, parsed on submit into arrays), **Language options** (checkboxes built from
`language_manager->getLanguages()`, plus a JS "select all" via `speakeasy/speakeasy.admin`).
`submitForm()` trims/splits the per-browser textfields, filters empties, and saves all six keys.
The form emits `logger->debug()` traces of loaded/submitted/saved config on every build and submit.

## Routes (`speakeasy.routing.yml`)
- `speakeasy.settings` → `/admin/config/speakeasy`, `_form: SpeakeasySettingsForm`,
  requires permission **`administer speakeasy settings`**.
- `speakeasy.user_preferences` → `/user/speakeasy/preferences`,
  `_form: SpeakeasyUserPreferencesForm`, requires permission
  **`manage speakeasy user preferences`**.

## User preferences form `SpeakeasyUserPreferencesForm`
`src/Form/SpeakeasyUserPreferencesForm.php`, form id `speakeasy_user_preferences_form`,
extends `FormBase`. DI: `user.data`, `current_user`. Stores two values per uid in the
`user.data` store under module `speakeasy`: `voice_name` (string, trimmed) and `speed` (float).
The voice `<select>` is populated client-side by `speakeasy/speakeasy.user_preferences`, which
receives `drupalSettings.speakeasy.allowedVoices` / `allowedLanguages` from the settings config.

## Permissions (`speakeasy.permissions.yml`)
- `administer speakeasy settings` — manage global config.
- `manage speakeasy user preferences` — access the personal preferences form.

## Hooks (`speakeasy.module`)
- `speakeasy_help()` — help.page.speakeasy text; output passed through `Xss::filter(..., ['p','a'])`.
- `speakeasy_theme()` — registers `speakeasy_media_player` (variable `show_voice_select`,
  template in `templates/`).
