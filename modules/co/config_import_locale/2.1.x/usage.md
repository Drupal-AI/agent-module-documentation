<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Locale: Config import lets you control whether interface (locale) translations get overwritten when configuration is imported, fixing the default Drupal behaviour where a config import silently replaces or clears existing UI string translations.

---

By default Drupal core's `locale.config_subscriber` re-applies translations shipped inside imported
configuration, which can overwrite (or remove) interface translations you have customised in
*Translate interface*. This module swaps in its own subscriber and config manager to change that. A
`ServiceProvider` (`ConfigImportLocaleServiceProvider::alter()`) repoints the `locale.config_subscriber`
service to `ConfigImportLocaleSubscriber` and `locale.config_manager` to
`ConfigImportLocaleConfigManager`. The subscriber overrides `saveCustomizedTranslation()` to consult the
module's own settings before writing: **Default** keeps core behaviour (translations may be
overwritten), **No overwrites** keeps existing translations but still allows brand-new ones to be added,
and **Nothing** never adds or changes interface translations on import. A context option lets you apply
the chosen behaviour only in **CLI** (e.g. `drush config:import`), only in the **UI**, or everywhere —
when the running context doesn't match, it falls back to core's default behaviour. Settings live in the
`config_import_locale.settings` config object and are edited at
`/admin/config/regional/translate/config-import-settings` (a tab under *Translate interface*), gated by
the `administer config import locale` permission. There are no plugins or Drush commands; it purely alters
core services and is driven by three config values.

---

- Stop config imports from wiping interface-string translations you customised in the UI.
- Preserve existing translations on import but still allow genuinely new translations to be added.
- Freeze interface translations entirely so config imports never touch them.
- Keep core's default overwrite behaviour but only in one context (CLI or UI).
- Apply the no-overwrite policy only during `drush config:import` (CLI) deployments.
- Apply the policy only in the admin UI while leaving CLI imports on default behaviour.
- Protect hand-tuned translations across repeated config-sync deployments.
- Avoid re-translating strings after every deploy in a multilingual site.
- Ensure a translation team's edits survive continuous-integration config imports.
- Roll config between environments without clobbering environment-specific UI translations.
- Choose overwrite behaviour per role using the `administer config import locale` permission.
- Let editors manage translations independently of the config that ships them.
- Reduce translation drift between the config export and the live locale storage.
- Keep default (English source) strings from replacing empty/blank customised translations.
- Standardise translation-import policy across a site via one config object.
- Debug translation overwrites by switching to "Nothing" temporarily.
