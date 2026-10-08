<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — global settings

## Routes
- `file_extractor.settings_form` → `/admin/config/media/file-extractor` (`SettingsForm`).
- `file_extractor.test_form` → `/admin/config/media/file-extractor/test` (`TestForm`).
Both require permission `file_extractor_administer_settings` (`restrict access: true`), `_admin_route`.

## Config object `file_extractor.settings`
Schema in `config/schema/file_extractor.schema.yml`.

| Key | Type | Meaning |
|---|---|---|
| `extraction_method` | string (plugin id) | Active extractor plugin (constrained to an existing `ExtractorPluginInterface` plugin). |
| `extraction_method_settings` | mapping | Per-plugin settings; shape is `file_extractor.plugin.extractor.<method>` (see plugins/extractors.md). |
| `extraction_settings.extractable.excluded_extensions` | string | Space-separated extensions excluded from extraction. Default: `aif art avi bmp gif ico mov oga ogv png psd ra ram rgb flv`. Mapped internally to MIME types. |
| `extraction_settings.extractable.max_filesize` | bytes | Max file size to extract (e.g. `50 MB`); `0` = no limit. |
| `extraction_settings.extractable.exclude_private` | boolean | Skip `private://` files. Default TRUE. |
| `extraction_settings.extraction_result.number_first_bytes` | bytes | Cap on stored/cached extracted text. Default `1 MB`; `0` = unlimited. |

Defaults for the `extraction_settings` block come from
`ExtractionSettingsFormHelper::DEFAULT_EXTRACTION_SETTINGS`.

## Form behavior
- The extraction-method `<select>` uses AJAX to swap in the chosen plugin's own configuration subform
  (`buildExtractorConfigForm` / `buildAjaxExtractorConfigForm`).
- `extraction_method` is bound with `#config_target`; the plugin subform and extraction settings are
  validated/submitted through the plugin's `validateConfigurationForm`/`submitConfigurationForm` and
  `ExtractionSettingsFormHelper::validateConfigurationForm` (validates `max_filesize` and
  `number_first_bytes` as byte strings).

## Test form
Submitting the Test form copies the bundled `data/…test…​.pdf` to a temp file, forces permissive
extraction settings (no exclusions, `max_filesize=0`, `number_first_bytes=1 MB`), runs
`ExtractorManager::extract()` on it, prints the result (or a warning if empty), then deletes the temp
file. It is meant to verify the method works with any `settings.php` config overrides in effect.

## drush
```
drush cget file_extractor.settings
drush cset file_extractor.settings extraction_method pdftotext_extractor
```
No Drush commands are provided by the module.
