Config Translation PO exports a site's translatable configuration strings to a Gettext `.po` file for external translation, then re-imports the translated `.po` back into Drupal's configuration translations/overrides.

---

The module adds two tabs under *Configuration → Regional → Configuration translation* (`/admin/config/regional/config-translation`): an **Export** form (`/export`) and an **Import** form (`/import`), both gated by the core `translate interface` permission. Export walks every translatable configuration object for a chosen language via a custom `CtpConfigManager` (a subclass of core's `LocaleConfigManager`), turns each translatable element into a `PoItem` — carrying a `context` string built from the config name + nested key path so identical source strings in different config objects stay distinct — and streams them out as a downloadable `<langcode>.po` via `PoStreamWriter`. Import reuses core's locale `ImportForm`: it attaches the uploaded `.po` to Drupal's locale batch (populating the interface-translation string tables) and then runs a second batch (`config_translation_po.bulk.inc`) that calls `CtpConfigManager::updateConfigTranslations()` to write the translated strings into each language's configuration overrides (or active config for the source language). This gives translators a standard `.po` round-trip for configuration text (menu labels, views titles, field labels, block text, etc.) instead of clicking through the per-config translation UI. It requires the core Locale and Configuration Translation modules and defines no permissions, schema, or plugins of its own.

---

- Export all translatable configuration strings for a language to a single `.po` file.
- Hand configuration text to an external translation agency in standard Gettext format.
- Bulk-import a translated `.po` file to populate configuration translations at once.
- Round-trip config translations through CAT tools (Poedit, Weblate, memoQ) that speak `.po`.
- Seed a new language's configuration translations from a translated template file.
- Keep identical source strings from different config objects separate via per-item `context`.
- Migrate configuration translations between environments as portable `.po` artifacts.
- Translate menu link titles, view display names, and field labels outside the admin UI.
- Generate an untranslated "template" `.po` (source strings) for the `system` pseudo-language.
- Update the active configuration language strings when importing for the source language.
- Write imported translations into per-language configuration overrides automatically.
- Avoid clicking through the core per-config translation forms for large sites.
- Batch-refresh configuration overrides across all configured languages after an import.
- Provide translators offline files instead of admin access to the site.
- Back up a language's configuration translations as a reviewable text file.
- Diff configuration translation changes between two `.po` exports.
- Re-sync configuration overrides after interface-translation edits.
- Export per-language `.po` named `<langcode>.po` with the site name as the PO project header.
- Support translation workflows that require Gettext `.po` deliverables.
- Populate both the locale string tables and config overrides in one import run.
