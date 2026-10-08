<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure

Config object `media_folders.settings` (schema `config/schema/media_folders.schema.yml`). Form at
`/admin/config/media-folders` (route `media_folders.configuration`, permission
`access media folders configuration`).

| Key | Default | Meaning |
|---|---|---|
| `default_view` | `thumbs` | Default browser view mode (`thumbs` / list). |
| `default_order` | `date-desc` | Default sort order of items in a folder. |
| `disable_ckeditor` | `0` | Disable the CKEditor 5 Media Folders plugin. |
| `show_thumbnails` | `0` | Show image thumbnails in the browser. |
| `pager_limit` | `500` | Files shown per "page" (load-more chunk). |
| `form_mode` | per-bundle `default` | Media edit form mode used per bundle (`audio`, `document`, `image`, `video`, `remove_video`). |

The config form also builds an **Extension bundles** section: a select per detected file extension
mapping it to the Media bundle used when a file of that extension is uploaded.

## Installed config

- Vocabulary `taxonomy.vocabulary.media_folders_folder` (+ default term form/view displays) — the
  folder tree.
- Optional action `system.action.media_add_to_folder_action`.

## Key routes

| Route | Path | Access |
|---|---|---|
| `media_folders.collection` | `/admin/content/media-folders` | `access media overview` |
| `media_folders.collection.folder` | `/admin/content/media-folders/{folder}` | `access media overview` |
| `media_folders.configuration` | `/admin/config/media-folders` | `access media folders configuration` |
| `media_folders.sync` | `/admin/config/media-folders/sync` | `administer modules` |
| `media_folders.add_folder` / `edit_folder` / `delete_folder` | `.../{folder}/*-folder` | `_custom_access` → taxonomy perms |
| `media_folders.add_file` / `upload_file.ajax` / `move_into.ajax` | `.../{folder}/*` | `_custom_access` → media create perms |

Menu links put the browser under *Content* and settings under *Configuration → Media*.
Many `*.ajax` routes power navigation, search, load-more, preview, upload, move, and the field widget.
