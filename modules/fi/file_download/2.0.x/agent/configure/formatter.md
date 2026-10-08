<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the download formatters

There is **no admin settings page**. You configure File Download per field on the entity's
*Manage display* (`entity_view_display` config), by choosing one of its two formatters.

## `file_download_formatter` (file + image fields)

Renders each file as a forced-download link. Settings (schema
`field.formatter.settings.file_download_formatter`):

| Setting | Type | Values / meaning |
|---|---|---|
| `link_title` | string | What the link text is: `file` (the filename, default), `entity_title` (parent entity title), `description` (the field item's description), `empty` (no text — icon only), `custom` (use `custom_title_text`). |
| `custom_title_text` | label | Text used when `link_title` = `custom`. **Token-aware** (tokens for current `user`, the `file`, and the parent entity), accepts limited HTML. Placeholder default "Download". |
| `file_size` | boolean | When true, appends the human-readable file size next to the link. |

Default settings: `link_title: file`, `custom_title_text: ''`, `file_size: false`.

## `file_download_uri_formatter` (file + image fields)

Renders just the download **URL string** (no anchor). Settings
(`field.formatter.settings.file_download_uri_formatter`):

| Setting | Type | Meaning |
|---|---|---|
| `absolute_url` | boolean | Output an absolute URL (scheme + host) instead of a root-relative one. |

## Set it via the UI

1. Go to the bundle's *Manage display*, e.g. Article: `/admin/structure/types/manage/article/display`.
2. In the file/image field's **Format** column pick **File Download** (or **File Download URI**).
3. Click the cog to set `link_title` / custom text / `file_size` (or `absolute_url`), **Update**, **Save**.

## Set it via drush / config (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_attachment', [
  'type'   => 'file_download_formatter',
  'label'  => 'hidden',
  'region' => 'content',
  'settings' => ['link_title' => 'custom', 'custom_title_text' => 'Download [file:name]', 'file_size' => TRUE],
])->save();
```

Read it back:

```bash
drush cget core.entity_view_display.node.article.default content.field_attachment
# look for type: file_download_formatter and its settings
```

The download links produced point at `/file-download/download/{scheme}/{fid}` — see
[../api/download.md](../api/download.md) for the route, headers and access.
