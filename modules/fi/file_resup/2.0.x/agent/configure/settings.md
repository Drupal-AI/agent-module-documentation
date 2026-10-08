<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure file_resup

## Enable resumable upload on a field (per-field, third-party settings)

Resumable upload is off until enabled on a **file field** (`target_type: file`). The
settings appear on the *Field settings / edit* form (`field_config_edit_form`) in a
**"Resumable Upload Settings"** details group (added by `FieldConfigFormAlter`), and are
saved as `file_resup` third-party settings on the `field.field.*.*.*` config entity:

| Third-party key | Type | Meaning |
|---|---|---|
| `enabled` | bool | Master switch — widget is only altered when `enabled === 1`. |
| `max_upload_size` | string | Optional per-field cap, e.g. `512`, `80 KB`, `50 MB` (`Bytes::toNumber`). Only raises the effective limit when larger than the field's existing `FileSizeLimit`. Validated with `Bytes::validate`. |
| `auto_upload` | bool | Start uploading as soon as files are added (no "Upload" click). |

Schema: `field.field.*.*.*.third_party.file_resup` in `config/schema/file_resup.schema.yml`.

Set programmatically:

```php
$field = \Drupal::entityTypeManager()->getStorage('field_config')
  ->load('node.article.field_video');           // entity_type.bundle.field
$field->setThirdPartySetting('file_resup', 'enabled', 1);
$field->setThirdPartySetting('file_resup', 'max_upload_size', '2 GB');
$field->setThirdPartySetting('file_resup', 'auto_upload', 1);
$field->save();
```

The widget itself is untouched in *Manage form display* — file_resup hooks
`hook_field_widget_complete_form_alter` and injects a hidden `resup` element into whatever
file widget the field already uses, provided `enabled === 1`.

## Global settings

Route `file_resup.settings` → `/admin/config/system/file-resup-settings`
(`FileResupSettingsForm`, permission `administer file resup`). Config object
`file_resup.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `prevent_duplicates` | bool | (unset) | When true, after a successful upload the `file_resup` tracking record keeps the resulting `fid`; a later upload with the same generated `upload_id` reuses that file instead of re-uploading. When false the tracking record is deleted after finalising. |

```bash
ddev drush cset file_resup.settings prevent_duplicates 1 -y
```

## Chunk size (no UI)

`file_resup_chunksize()` reads `\Drupal::config('file_resup')->get('default_chunk_size')`
and falls back to `FILE_RESUP_DEFAULT_CHUNKSIZE` = `2 * 1024 * 1024` (2 MB). Note this reads
the `file_resup` config object (not `file_resup.settings`), which has no `config/install`
default and no form — set it explicitly if you need a non-default chunk size:

```bash
ddev drush cset file_resup default_chunk_size 5242880 -y   # 5 MB chunks
```

## Permissions

- `administer file resup` (`restrict access: true`) — gates the settings form and is the
  entity `admin_permission` for the internal `file_resup` entity. It does **not** gate the
  upload endpoint (that is `access content`; see `api/upload-protocol.md`).
