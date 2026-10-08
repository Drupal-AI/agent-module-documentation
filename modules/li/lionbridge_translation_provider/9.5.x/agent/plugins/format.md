<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `FormatPlugin` (export formats)

The module defines its own small plugin type for the file format used to export TMGMT job
items before sending them to Lionbridge.

- **Manager service:** `plugin.manager.tmgmt_contentapi.format` (`Format\FormatManager`,
  `parent: default_plugin_manager`).
- **Annotation:** `@FormatPlugin` (`src/Annotation/FormatPlugin.php`) — fields `id`, `label`.
- **Interface:** `Drupal\tmgmt_contentapi\Format\FormatInterface`.
- **Discovery directory:** `Plugin/tmgmt_contentapi/Format` (in any module).
- **Default UI:** `\Drupal\tmgmt\SourcePluginUiBase`.

`FormatManager::getLabels()` returns `id => label` for every format; that list populates the
"Export to" radios on the translator form and each job's checkout form. The translator setting
`export_format` (default `contentapi_xlf`) selects which plugin is used.

## Shipped plugin

| Plugin id | Class | Format |
|---|---|---|
| `contentapi_xlf` | `Plugin/tmgmt_contentapi/Format/Xliff` | XLIFF 1.2 export/import with HTML masking (`<bpt>/<ept>`, `<x ctype="lb">`, `<ph ctype="image">`), optional extended processing / CDATA. |

`Xliff` (annotated `@FormatPlugin`) implements `FormatInterface` and does the bidirectional
work: `export()` builds the XLIFF sent to Lionbridge, and the import side unmasks XLIFF back to
HTML, running an integrity check (element counts must match) before writing translations back
onto the job.

## Add your own format

1. Create `MyModule\Plugin\tmgmt_contentapi\Format\MyFormat` implementing `FormatInterface`.
2. Annotate it:

```php
/**
 * @FormatPlugin(
 *   id = "my_format",
 *   label = @Translation("My format"),
 * )
 */
```

3. Clear caches. It then appears in the "Export to" options; set `export_format` to `my_format`
   on the translator (or per job).
