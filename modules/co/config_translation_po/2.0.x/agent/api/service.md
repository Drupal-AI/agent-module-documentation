# Config Translation PO — routes, service, batch

## Routes (`config_translation_po.routing.yml`)
| Route | Path | Form | Access |
|---|---|---|---|
| `config_translation_po.export_config_form` | `/admin/config/regional/config-translation/export` | `ExportConfigForm` | `translate interface` |
| `config_translation_po.import_config_form` | `/admin/config/regional/config-translation/import` | `ImportConfigForm` | `translate interface` |

Both appear as local tasks (tabs) on the core config-translation page (`config_translation.mapper_list`),
alongside a `Translate` tab (`config_translation_po.links.task.yml`).

## Services (`config_translation_po.services.yml`)
- `logger.channel.config_translation_po` — `parent: logger.channel_base`, channel `config_translation_po`.
- `ctp.config_manager` — class `Drupal\config_translation_po\Services\CtpConfigManager`,
  `parent: locale.config_manager` (inherits core `LocaleConfigManager` constructor args), with a call
  `setLocaleLanguages(@?Drupal\locale\LocaleLanguages)` (optional service — null-safe on cores that
  lack it).

`CtpConfigManager extends Drupal\locale\LocaleConfigManager`. Key methods:
- `setLocaleLanguages(?object $locale_languages)` — captures core's `LocaleLanguages::isTranslatable`
  as a `\Closure` when available (Drupal 11.5+/12).
- `getComponentNames(array $components = [])` — config object names to process; empty array = all
  (`configStorage->listAll()`).
- `getTranslatableConfig($name)` — translatable elements of one config object (typed-data wrapper).
- `exportConfigTranslations(array $names, array $langcodes)` → array of `PoItem` keyed by context.
  Each translatable element becomes a `PoItem` with `context = implode(':', [config_name, ...keyPath])`,
  source = untranslated string, translation = translated value (empty for the `system` pseudo-language).
  A small `getExludes()` list (`(Empty)`, `‹‹`, `››`, `, `) and empty sources are skipped.
- `updateConfigTranslations(array $names, array $langcodes = [])` → int count. Writes translations:
  for non-active langcodes into `language config overrides` (merged with existing, deleted when empty);
  for the active storage language into active config when that language is translatable.
- `isLangcodeTranslatable(string $langcode)` — via `DeprecationHelper::backwardsCompatibleCall` uses
  the `LocaleLanguages` closure on 11.5+ and `locale_is_translatable()` on older cores.

## Export flow (`ExportConfigForm::submitForm`, extends core `locale` `ExportForm`)
1. `getComponentNames([])` → all config names.
2. `exportConfigTranslations($names, [$langcode])` → `PoItem[]`.
3. Write to a `temporary://po_*` file (`fileSystem->tempnam`) via `PoStreamWriter` with a `PoHeader`
   (project = site name, language = langcode).
4. Return a `BinaryFileResponse` as attachment `<langcode>.po`.
(The parent locale export's content-scope options are hidden: `content_options['#access'] = FALSE`.)

## Import flow (`ImportConfigForm::submitForm`, extends core `locale` `ImportForm`)
1. Resolve the target language; bail with a status message if it is not enabled.
2. Build default import options (`LocaleDefaultOptions::updateOptions()` on 11.4+, else
   `_locale_translation_default_update_options()`), plus `langcode`, `overwrite_options`, `customized`.
3. Attach the uploaded file (`LocaleFile::createFromPath` on 11.4+, else
   `locale_translate_file_attach_properties()`) and build the core locale batch
   (`localeImportBatch->buildBatch()` on 11.4+, else `locale_translate_batch_build()`) — fills locale
   string tables.
4. Load `config_translation_po.bulk.inc` and run
   `config_translation_po_config_batch_update_components($options, [$langcode])`, which batches config
   names (20 per op) into `config_translation_po_config_batch_refresh_name()` →
   `CtpConfigManager::updateConfigTranslations()`.

## Batch helpers (`config_translation_po.bulk.inc`, procedural)
- `config_translation_po_config_batch_update_components(array $options, array $langcodes = [], array $components = [])`
- `config_translation_po_config_batch_build(array $names, array $langcodes, array $options = [])`
- `config_translation_po_config_batch_refresh_name(array $names, array $langcodes, &$context)`
- `config_translation_po_config_batch_finished($success, array $results)`

Access to both forms is the standard core `translate interface` trust boundary (same as core locale
import/export) — no elevated capability is added. No Drush commands; no config schema; no own permissions.
