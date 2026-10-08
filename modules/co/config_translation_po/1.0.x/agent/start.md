# Config Translation PO — agent index

Export translatable **configuration** strings to a Gettext `.po` file and import a translated `.po`
back into config translations/overrides. Depends on core `locale` + `config_translation`. No config
page (`configure` null), no own permissions (uses `translate interface`), no plugins.

- **Routes, forms, the `ctp.config_manager` service, and the import/export batch flow** →
  [api/service.md](api/service.md)

Key facts:
- Two tabs under `/admin/config/regional/config-translation`: Export (`/export`) and Import (`/import`),
  both `_permission: translate interface`.
- Export = `CtpConfigManager::exportConfigTranslations()` → `PoItem`s (with `name:key` context) →
  `PoStreamWriter` → downloadable `<langcode>.po`.
- Import = core locale `ImportForm` (fills locale string tables) + batch
  `config_translation_po_config_batch_update_components()` → `CtpConfigManager::updateConfigTranslations()`
  writes config overrides / active config.
- `CtpConfigManager` extends core `Drupal\locale\LocaleConfigManager`.
