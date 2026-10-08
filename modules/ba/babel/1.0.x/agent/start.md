<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel (babel) — agent index

Unified UI-string translation hub. Version **1.0.0-alpha11** (alpha). Core `^10.4 || ^11.1 || ^12`.
Depends on core **locale**. Composer: `phpoffice/phpspreadsheet ^5.0`, `ext-pdo`.

## What it is
Babel exposes every translatable Drupal string — code (Locale), configuration, and simple content
entities — in one interface, and writes translations back to their native backend. Babel stores **no
translations**; it keeps only an index and per-string activation/lock state. Two plugin types drive it:
**translation type** (a backend adapter) and **data transfer** (import/export format).

## Provides
- **Plugin type `translation_type`** — `Plugin\Babel\TranslationType`, manager
  `Drupal\babel\Plugin\Babel\TranslationTypePluginManager`, attribute `#[TranslationType]`, interface
  `TranslationTypePluginInterface`. Built-in plugins: `locale` (`TranslationType\Locale`), `config`
  (`TranslationType\Config`). Alter with `hook_babel_translation_type_info()`.
- **Plugin type `data_transfer`** — `Plugin\Babel\DataTransfer`, manager `DataTransferPluginManager`,
  attribute `#[DataTransfer]`, exporter/importer interfaces. Built-in: `spreadsheet`
  (`DataTransfer\Spreadsheet`, xlsx/xls/ods/csv). Alter with `hook_babel_data_transfer_info()`.
- **Config**: `babel.settings` (data_transfer destination + filename prefix). Config schema provided.
- **Routes** (see `agent/config/settings.md`): `babel.ui`, `babel.ui_pager`, `babel.export`,
  `babel.import`, `babel.settings`.
- **Services**: `BabelStorageInterface` (index/status/lock tables), `BabelStringsRepositoryInterface`
  (aggregated strings), `BabelLockServiceInterface`, `BabelConfigTranslatables`, `StringsCollectorFactory`,
  cache bin `cache.babel`, `logger.channel.babel`, cache context `babel_translate_form_route`.
- **Events**: `SourceStringInserted`, `SourceStringEnabled`, `SourceStringDisabled`, `TranslationLocked`,
  `TranslationUnlocked` (namespace `Drupal\babel\Event`).
- **Hooks**: `hook_toolbar` (Translate tab), `hook_js_alter`, `hook_theme`, `hook_module_implements_alter`.
- **Schema tables**: `babel_source`, `babel_source_instance`, `babel_source_lock` (see settings doc).
- **Render element** `pager_babel` (`Element\BabelPager`) + theme `pager` override.

## Permissions (important)
- `translate interface` (core Locale permission) gates the translate/export/import routes and toolbar tab.
- `language manager` gates `babel.settings` — note this permission is **not defined** by core or Babel,
  so in practice only UID 1 can reach the settings form (alpha rough edge).

## Submodules (each documented in its own tree under `modules/<sub>/1.0.x/`)
- **babel_content_entity** — `content_entity:*` translation-type plugins (derived per entity type) to
  translate simple content entities (taxonomy terms, shortcuts, etc.). → `modules/babel_content_entity/1.0.x/agent/start.md`
- **babel_menu_link_content** — `menu_link_content` translation-type plugin for custom menu link
  titles/descriptions. → `modules/babel_menu_link_content/1.0.x/agent/start.md`
- **babel_tmgmt** — `babel` TMGMT source plugin + continuous-job cron integration (needs `drupal/tmgmt`).
  → `modules/babel_tmgmt/1.0.x/agent/start.md`

## Solution docs
- `agent/config/settings.md` — install, routes, permissions, `babel.settings` config + schema, DB tables.
- `agent/plugins/translation-type.md` — the translation-type plugin system; `locale` and `config` plugins.
- `agent/plugins/data-transfer.md` — the import/export plugin system; the `spreadsheet` plugin.
- `agent/api/storage-and-locking.md` — storage service, strings repository, lock service, events, hooks.
