<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export routes, actions & links

## Single-reference export

Route `bibcite_export.export`:
`/bibcite/export/{bibcite_format}/{entity_type}/{entity}` → `ExportController::export`.
- `{bibcite_format}` is resolved to a `bibcite_format` plugin (param converter).
- Requirements: permission `access bibcite export` **and** `_entity_access: entity.view`.
- Streams the entity serialized in that format (extension from the format plugin, e.g. `.bib`).

Example: `/bibcite/export/bibtex/bibcite_reference/12` downloads reference 12 as BibTeX.

## Bulk export

- `entity.bibcite_reference.export_multiple_form` → `/admin/content/bibcite/reference/export-action`
  (`ExportMultipleForm`, permission `access bibcite export`) — export a chosen set.
- `bibcite_export.export_all` → `/admin/content/bibcite/reference/export`
  (`ExportAllForm`, permission `administer bibcite`+`access bibcite export`) — export every
  reference.
- `bibcite_export.download` → `/admin/content/bibcite/reference/export/download/{file}`
  (`ExportDownload::download`, custom access `DownloadFileAccess`) — download the generated file.

## Action plugins (over `bibcite_reference`)

| Action id | Label | Use |
|---|---|---|
| `bibcite_export_multiple` | Export reference | admin bulk export (confirm form) |
| `bibcite_export_multiple_vbo` | Download Selected Citations | Views Bulk Operations |

The shipped action config entity `system.action.bibcite_export_multiple`:

```yaml
id: bibcite_export_multiple
label: 'Export reference'
type: bibcite_reference
plugin: bibcite_export_multiple
configuration: {  }
```

Create one in code:

```php
use Drupal\system\Entity\Action;
Action::create([
  'id' => 'bibcite_export_multiple',
  'label' => 'Export reference',
  'type' => 'bibcite_reference',
  'plugin' => 'bibcite_export_multiple',
  'configuration' => [],
])->save();
```

## Export links on a reference

`Plugin/bibcite/link/Export.php` with deriver `FormatExportLink` adds an `export:<format>`
`bibcite_link` derivative per enabled export format, so a rendered reference shows a download link
for each format (`export:bibtex`, `export:ris`, `export:marc`, …).

## Available export formats

Formats whose encoder is a Symfony `EncoderInterface`:

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::service("plugin.manager.bibcite_format")->getExportDefinitions()));'
```
