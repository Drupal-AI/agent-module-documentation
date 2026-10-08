<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories Editor — agent index

> **DEPRECATED** — `media_directories_editor.info.yml` declares `lifecycle: deprecated`.
> It is the legacy `entity_embed` / CKEditor 4-era integration. On Drupal 11 use the
> CKEditor 5 plugins in `media_directories_browser` instead.

- **The config it ships, the one setting, the formatter and the hooks** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Depends on `media_directories_ui`, contrib `embed (>=8.x-1.6)` and `entity_embed`.
- Config object **`media_directories_editor.settings`** with a single nested key
  **`embed_dialog.image_styles`** (sequence of image style ids; **empty = show all styles**).
- **No settings route of its own** — it injects an *"Editor Settings"* details element into
  the parent module's form at `/admin/config/media/media_directories`, and prepends
  `media_directories_editor_config_form_submit()` to `$form['#submit']`.
- Ships `embed.button.media_directories` (label *Media*, entity type `media`, entity browser
  `media_directories_editor_browser`, display plugin
  `entity_reference:media_directories_image_dimensions`) and
  `entity_browser.browser.media_directories_editor_browser`.
- Field formatter **`media_directories_image_dimensions`**
  (`MediaDirectoriesImageDimensionsFormatter extends MediaThumbnailFormatter`).
- Migration: `media_directories_browser_update_11004()` copies
  `embed_dialog.image_styles` into `media_directories_browser.settings:embed_image_styles`
  (with the important behavioural change that the new list has **no "show all" fallback**).
