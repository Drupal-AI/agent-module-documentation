# Config Translation PO — agent index

Export translatable **configuration** strings to a Gettext `.po` file and import a translated `.po`
back into config translations/overrides. Depends on core `locale` + `config_translation`. No config
page (`configure` null), no own permissions (uses `translate interface`), no plugins.

- **Routes, forms, the `ctp.config_manager` service, and the import/export batch flow** →
  [api/service.md](api/service.md)

Key facts:
- `2.0.x` is a compatibility-driven major: `core_version_requirement: ^10.1.3 || ^11 || ^12`
  (drops Drupal 9, adds Drupal 12). No new routes, permissions, or features vs `1.0.x`.
- Two tabs under `/admin/config/regional/config-translation`: Export (`/export`) and Import (`/import`),
  both `_permission: translate interface`.
- Export = `CtpConfigManager::exportConfigTranslations()` → `PoItem`s (with `name:key` context) →
  `PoStreamWriter` → downloadable `<langcode>.po` (streamed from `temporary://`).
- Import = core locale `ImportForm` (fills locale string tables) + batch
  `config_translation_po_config_batch_update_components()` → `CtpConfigManager::updateConfigTranslations()`
  writes config overrides / active config.
- `CtpConfigManager` extends core `Drupal\locale\LocaleConfigManager` and is now wired as
  `parent: locale.config_manager` with a `setLocaleLanguages(@?Drupal\locale\LocaleLanguages)` call.
- Forward-compat shims use `DeprecationHelper::backwardsCompatibleCall` for core 11.4/11.5 API moves
  (`LocaleFile::createFromPath`, `LocaleDefaultOptions`, `localeImportBatch->buildBatch`,
  `LocaleLanguages::isTranslatable`).
