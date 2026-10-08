# Build a Data Export display

Configured entirely inside a View — there is no global settings page.

1. Edit a View → **Add** → choose display type **Data export** (`data_export`, extends REST export).
2. Set a **Path** for the standalone download URL, or use **Attach to** to hang the export off an
   existing page display (renders a download link/icon).
3. In **Format** (style `data_export`), pick one or more formats and their options.

## Display options (schema `views.display.data_export`)
| Option | Meaning |
|---|---|
| `displays` (Attach to) | Page displays this export attaches to. |
| `filename` | Downloaded file name. |
| `automatic_download` | Trigger the download immediately (JS `views_data_export_auto_download.js`). |
| `export_method` | `standard` or `batch` (batch handles very large results). |
| `export_batch_size` | Rows processed per batch iteration. |
| `export_limit` | Max rows to export (0 = all). |
| `redirect_path` / `custom_redirect_path` / `redirect_to_display` / `include_query_params` | Where to send the user after a batch export. |
| `facet_settings` | Facet source id for Search API/Facets integration. |
| `export_filesystem` | Let users choose the destination file system. |

## Style / format options (schema `views.style.data_export`)
- **`formats`** — any of `csv`, `xml`, `json`, `xls`/`xlsx` (CSV requires `csv_serialization`;
  XLS requires `xls_serialization`).
- **CSV settings**: `delimiter`, `enclosure`, `escape_char`, `strip_tags`, `trim`, `encoding`,
  `utf8_bom`, `output_header`, `use_serializer_encode_only`.
- **XML settings**: `encoding`, `root_node_name`, `item_node_name`, `format_output`.
- **XLS settings**: `xls_format` plus document metadata (creator, title, company, …).

Exports honor the View's fields, filters, sorts, contextual arguments, and access. File
downloads are access-checked in `hook_file_access()` (a user may download only exports they
generated). Run headless with the [Drush command](../drush/views_data_export.md).
