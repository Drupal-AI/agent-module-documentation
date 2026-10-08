<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cyrillic to Latin (cyrillic_to_latin) — agent index

Transliterates **Serbian** text from **Cyrillic to Latin** script at display time (one-way,
character-map `str_replace`). It works through three mechanisms: (1) a `ServiceProvider` swaps core's
`string_translation` service for `Drupal\cyrillic_to_latin\CyrillicToLatinManager`, so every string
passing through `t()`/`TranslationManager::doTranslate()` is converted when the module is enabled and
the current language is in the configured list; (2) `hook_preprocess_field` and
`hook_preprocess_views_view_field` convert rendered field output (`string`, `string_long`, `text`,
`text_long`, `text_with_summary`, `list_string`, and `address` country names, plus a views field
literally named `address`); (3) an event subscriber rewrites stored locale translations to Latin on
`.po` import. The single reusable API is the static `CyrillicToLatinManager::convertCyrillicToLatin($string)`.
Configure at `/admin/config/regional/cyrillic-to-latin`. Version **2.0.3**.

Conversion is gated by config: `enabled` must be truthy AND the current language id must appear in the
`languages` list (default `sr`). Changing settings requires a **cache clear** to take effect (the form
says so on save). Direction is one-way only — Cyrillic→Latin is deterministic, the reverse is not.

- Depends on: `drupal:locale` (the event subscriber type-hints `locale` storage/events).
- Core: `^10 || ^11`. Package: `Multilingual`. License GPL-2.0-or-later.
- Settings page: yes — `configure: cyrillic_to_latin.admin_settings` (permission `administer site configuration`).
- Provides config schema (yes). No module-defined permissions, no drush commands, no plugin types, no submodules.

## What you'd do → where

- **Convert a Cyrillic string from your own code / understand the `string_translation` override and the
  locale-import subscriber** → [api/services.md](api/services.md)
- **Enable/disable conversion, pick which languages it applies to, transliterate on `.po` import** →
  [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Route: `cyrillic_to_latin.admin_settings` → `/admin/config/regional/cyrillic-to-latin`
  (`_permission: 'administer site configuration'`), form
  `Drupal\cyrillic_to_latin\Form\SettingsForm` (form id `cyrillic_to_latin_admin_settings_form`).
  Menu link `cyrillic_to_latin.admin_settings` under `system.admin_config_regional`.
- Service: `cyrillic_to_latin.locale_subscriber` →
  `Drupal\cyrillic_to_latin\EventSubscriber\LocaleSubscriber` (args `@config.factory`,
  `@locale.storage`; subscribes to `locale.save_translation`).
- Service override: `Drupal\cyrillic_to_latin\CyrillicToLatinServiceProvider::alter()` re-classes the
  core `string_translation` service to `CyrillicToLatinManager` (extends core `TranslationManager`).
- Public API: `CyrillicToLatinManager::convertCyrillicToLatin(string $string): string` (static).
- Hooks: `hook_help` (`help.page.cyrillic_to_latin`), `hook_preprocess_field`,
  `hook_preprocess_views_view_field`. Helper `cyrillic_to_latin_is_module_enabled()`.
- Config object `cyrillic_to_latin.settings` — keys: `enabled` (integer 0/1),
  `transliterate_on_po_import` (boolean), `languages` (sequence of langcode→langcode; default `sr: sr`).
- Update hook: `cyrillic_to_latin_update_8001` (seeds `languages: {sr: sr}`).
- Handled field types: `string`, `string_long`, `text`, `text_long`, `text_with_summary`,
  `list_string`, `address` (country name). Views: field named `address`.
