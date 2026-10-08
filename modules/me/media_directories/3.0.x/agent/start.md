<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories — agent index

Adds a **`directory`** entity-reference base field to `media`, pointing at a taxonomy
vocabulary you nominate. Terms = folders, term nesting = folder nesting. The base module has
no permissions, no Drush commands and no plugin types of its own — just one settings form,
one selection handler and two Views handlers. Everything visual lives in the submodules.

- **Pick the directory vocabulary, root behaviour, config keys, drush recipes** →
  [configure/settings.md](configure/settings.md)
- **The `directory` base field, `MediaDirectoryRoot::VALUE`, reading/writing it in code** →
  [api/directory-field.md](api/directory-field.md)
- **Views filter `media_directory`, argument `media_directory`, selection handler
  `media_directory:default`** →
  [plugins/views-and-selection.md](plugins/views-and-selection.md)

Submodules (each has its own doc tree under `modules/media_directories/modules/…/3.0.x/`):

| Submodule | What it adds |
|---|---|
| `media_directories_browser` | Vue.js browser at `/admin/content/media-browser`, REST-ish API, field widget, CKEditor 5 integration |
| `media_directories_file_link` | CKEditor 5 "Insert file link" button + `media_directories_file_link` filter |
| `media_directories_ai` | AI alt text + AI translations for the browser (requires `drupal/ai`) |
| `media_directories_image_resize` | `media_directories_image_resize` filter — physically resizes `<img width height>` |
| `media_directories_compat` | `media_directories_legacy_embed` filter — `<drupal-entity>` → `<drupal-media>` |
| `media_directories_ui` | **deprecated** — old entity_browser-based UI |
| `media_directories_editor` | **deprecated** — old entity_embed/CKEditor 4 integration |

Key facts:
- Config object **`media_directories.settings`**: `directory_taxonomy` (vocabulary id,
  string) and `all_files_in_root` (bool, default `false`).
- Configure route **`media_directories.config_form`** → `/admin/config/media/media_directories`,
  permission `administer site configuration`.
- Root directory sentinel is **`-1`** (`Drupal\media_directories\MediaDirectoryRoot::VALUE`),
  deliberately not `0` because Views treats `0` as empty. Stored value for "root" is `NULL`.
- Changing `directory_taxonomy` **flushes all caches** (the base field definition depends on it).
- `hook_install()` adds an exposed `directory` filter to the `media_library` and `media` views;
  `hook_uninstall()` removes it.
