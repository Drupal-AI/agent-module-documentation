<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a File URL field

There is **no admin settings page** (`configure: null`). You configure File URL per field on
the usual field UI (Manage fields / Manage form display / Manage display), plus one optional
site-wide config value.

## The plugins it provides

| Kind | Plugin id | Notes |
|---|---|---|
| Field type | `file_url` | extends core `FileItem`; default widget `file_url_generic`, default formatter `file_url_default`. Stores a URI in a `target_id` varchar(2048) column. |
| Widget | `file_url_generic` | extends core `FileWidget`; adds an **Upload file / Remote file URL** radio + a URL textfield. |
| Formatter | `file_url_default` | extends core file formatter; setting `mode` = `link` (default) or `plain`. |
| Selection | `file_url_default:file` | entity-reference selection plugin used to validate referenceable file URIs. |

## Create a field (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_attachment',
  'entity_type' => 'node',
  'type' => 'file_url',          // the field type id
])->save();
FieldConfig::create([
  'field_name' => 'field_attachment',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Attachment',
])->save();

// Widget on the default form display.
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article')
  ->setComponent('field_attachment', ['type' => 'file_url_generic'])
  ->save();

// Formatter on the default view display.
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article')
  ->setComponent('field_attachment', [
    'type' => 'file_url_default',
    'settings' => ['mode' => 'link'],   // or 'plain'
  ])
  ->save();
```

## Widget setting

- `add_new_label` (default `Upload a new file or enter a URL`) — the "new item" label; the
  textfield to change it only appears on **multi-value** fields.

## Formatter setting

- `mode`: `link` → themed `file_link` (file name + extension as link text); `plain` → the
  generated file URL as plain markup.

## Site-wide config: the dereference host

Local uploads are rendered as `<host>/file-dereference/{fid}`. `<host>` is the site base URL
unless overridden:

```bash
drush cset file_url.settings dereference_host 'https://files.example.com' -y
drush cget file_url.settings dereference_host
```

Config object: `file_url.settings`, single key `dereference_host` (empty string = use the
site's `$base_url`). Set it when dereference links must point at a canonical/CDN host.

## What a stored value looks like

- Uploaded file → `target_id` = `/file-dereference/{fid}` (or `<dereference_host>/file-dereference/{fid}`).
- Remote file → `target_id` = the raw URL you typed (e.g. `https://example.com/doc.pdf`).
