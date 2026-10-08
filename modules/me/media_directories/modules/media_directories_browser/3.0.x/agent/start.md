<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories Browser — agent index

The Vue.js media browser for Media Directories. Full page at **`/admin/content/media-browser`**,
plus a field widget, a CKEditor 5 media-dialog replacement, an off-canvas quick edit form and
a JSON API under `/api/media-directories-browser/*`. Depends on `media_directories`, `media`,
`ckeditor5`, `media_library`.

- **All ~22 settings keys, the settings form, and drush recipes** →
  [configure/settings.md](configure/settings.md)
- **Routes, the JSON API surface, and the six services** →
  [api/routes-and-services.md](api/routes-and-services.md)
- **Field widget, CKEditor 5 plugins, the default-view-mode filter** →
  [plugins/widget-ckeditor-filters.md](plugins/widget-ckeditor-filters.md)
- **The one permission and what it gates** →
  [permissions/access.md](permissions/access.md)

Key facts:
- Config object **`media_directories_browser.settings`**; settings form at
  **`/admin/config/media/media_directories/browser`** (route
  `media_directories_browser.config_form`, permission `administer site configuration`).
  `configure:` is **not** set in `.info.yml` — it is a local task under the parent module's
  settings page.
- Permission: **`access media directories browser`** — gates the browser page *and every API
  route*.
- Every setting is republished to the front end as
  `drupalSettings.mediaDirectoriesBrowser` by `hook_page_attachments()`.
- Field widget id **`media_directories_browser_widget`** (entity_reference,
  `multiple_values: TRUE`).
- CKEditor 5 plugins: `media_directories_browser_media_directories_browser`,
  `media_directories_browser_image_options`, `media_directories_browser_media_file_link`.
- Filter plugin: **`media_directories_default_view_mode`** ("Media default view mode",
  weight 90, must run **before** `media_embed`).
- Optional integrations degrade silently: `focal_point`, `svg_image`, `entity_usage`,
  core `content_translation`.
