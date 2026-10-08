# The `file_link` field type

A drop-in extension of core's Link field that must point at a **file** and stores that file's
**size** and **MIME type**.

## Field type

- id `file_link` — `Drupal\file_link\Plugin\Field\FieldType\FileLinkItem` (extends
  core `Drupal\link\Plugin\Field\FieldType\LinkItem`).
- `default_widget = "file_link_default"`, `default_formatter = "link"`.
- Constraints: `LinkAccess`, **`LinkToFile`**, `LinkExternalProtocols`, `LinkNotExistingInternal`.

### Stored value / properties

Everything a link stores (`uri`, `title`, `options`) **plus**:

| Property / column | Type | Meaning |
|---|---|---|
| `size` | integer (big, unsigned) | target file size in bytes. |
| `format` | varchar(255) | target file MIME type (e.g. `application/pdf`). |

Both are indexed. They are populated from the target's HTTP response headers
(`Content-Length` / `Content-Type`) when the field is saved, or later by cron when deferred.

## Field settings (per field)

`defaultFieldSettings()` adds to the link settings:

| Setting | Default | Meaning |
|---|---|---|
| `file_extensions` | `'txt'` | space-separated list of allowed target extensions (enforced by `LinkToFile`). |
| `no_extension` | `FALSE` | allow URLs with no file extension. |
| `deferred_request` | `FALSE` | skip immediate validation/fetch and update size/format via cron instead. |

Configured on the field's settings form (*Manage fields → field → settings*), stored under
`field.field.<entity>.<bundle>.<field>.settings`.

## Add a file_link field (code)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_download',
  'entity_type' => 'node',
  'type' => 'file_link',
  'cardinality' => 1,
])->save();
FieldConfig::create([
  'field_name' => 'field_download',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Download',
  'settings' => [
    'file_extensions' => 'pdf txt',
    'no_extension' => FALSE,
    'deferred_request' => FALSE,
  ],
])->save();
```

Read back: `drush cget field.field.node.article.field_download settings` → `file_extensions`, etc.

## Widget

- `file_link_default` — `FileLinkWidget` (extends the core link widget; settings schema
  `field.widget.settings.file_link_default` = the link default widget schema).

## Formatters

| id | Class | Renders |
|---|---|---|
| `file_link` | `FileLinkFormatter` | the link, optionally with formatted file size (option `format_size`). Template `file_link_formatter`. |
| `file_link_separate` | `FileLinkSeparateFormatter` | title and URL as separate elements + size/format. Template `file_link_formatter_link_separate`. |

Formatter setting `format_size` (bool) controls whether `size` is shown as a human-readable size.
The core `link` formatter also works (default), but only `file_link*` formatters expose the
metadata.
