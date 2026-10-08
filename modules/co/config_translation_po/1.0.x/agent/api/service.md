# Config Translation PO — routes, service, batch

## Routes (`config_translation_po.routing.yml`)
| Route | Path | Form | Access |
|---|---|---|---|
| `config_translation_po.export_config_form` | `/admin/config/regional/config-translation/export` | `ExportConfigForm` | `translate interface` |
| `config_translation_po.import_config_form` | `/admin/config/regional/config-translation/import` | `ImportConfigForm` | `translate interface` |

Both appear as local tasks (tabs) on the core config-translation page.

## Service `ctp.config_manager`
Class `Drupal\config_translation_po\Services\CtpConfigManager extends Drupal\locale\LocaleConfigManager`.
Constructor args: `@config.storage`, `@locale.storage`, `@config.factory`, `@config.typed`,
`@language_manager`, `@locale.default.config.storage`, `@config.manager`.

Key methods:
- `getComponentNames(array $components = [])` — config object names to process; empty array = all
  (`configStorage->listAll()`).
- `getTranslatableConfig($name)` — translatable elements of one config object (typed-data wrapper).
- `exportConfigTranslations(array $names, array $langcodes)` → array of `PoItem` keyed by context.
  Each translatable element becomes a `PoItem` with `context = implode(':', [config_name, ...keyPath])`,
  source = untranslated string, translation = translated value (empty for the `system` pseudo-language).
- `updateConfigTranslations(array $names, array $langcodes = [])` → int count. Writes translations:
  for non-active langcodes into `language config overrides` (merged with existing, deleted when empty);
  for the active storage language into active config when that language is translatable.

## Export flow (`ExportConfigForm::submitForm`)
1. `getComponentNames([])` → all config names.
2. `exportConfigTranslations($names, [$langcode])` → `PoItem[]`.
3. Write to a `temporary://po_*` file via `PoStreamWriter` with a `PoHeader` (project = site name).
4. Return a `BinaryFileResponse` as attachment `<langcode>.po`.
(The parent locale export's content-scope options are hidden: `content_options['#access'] = FALSE`.)

## Import flow (`ImportConfigForm::submitForm`, extends core `locale` `ImportForm`)
1. Attach uploaded file + run core `locale_translate_batch_build()` (fills locale string tables).
2. Load `config_translation_po.bulk.inc` and run
   `config_translation_po_config_batch_update_components($options, [$langcode])`, which batches config
   names (20 per op) into `config_translation_po_config_batch_refresh_name()` →
   `CtpConfigManager::updateConfigTranslations()`.

## Batch helpers (`config_translation_po.bulk.inc`, procedural)
- `config_translation_po_config_batch_update_components(array $options, array $langcodes = [], array $components = [])`
- `config_translation_po_config_batch_build(array $names, array $langcodes, array $options = [])`
- `config_translation_po_config_batch_refresh_name(array $names, array $langcodes, &$context)`
- `config_translation_po_config_batch_finished($success, array $results)`

Access to both forms is the standard core `translate interface` trust boundary (same as core locale
import/export) — no elevated capability is added.
