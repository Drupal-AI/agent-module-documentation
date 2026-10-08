<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Library Loader (dynamic_library_loader) — agent index

Conditionally attaches asset libraries (`theme_or_module/library`) to rendering
contexts (content type, node ID, taxonomy vocabulary, paragraph type, paragraph
ID, custom block type, view/display) from an admin UI, so per-component CSS/JS
aggregates with the page instead of loading late from Twig. Also overrides core's
CSS/JS collection renderers to append a cache-busting query string to local assets.

- **Version dir:** 2.0.x (documented from installed 2.0.8). Core: `^10 || ^11 || ^12`.
- **Dependencies:** none (Paragraphs dependency was dropped in 2.x).
- **Permissions:** none of its own; all routes require core `administer site configuration`.
- **Storage:** all mappings in the `dynamic_library_loader.settings` config object
  (no custom DB tables; `dynamic_library_loader_update_1003` migrates legacy tables → config).
- **Plugins/entities:** none. Config-driven via a plain settings object.

## What it provides
- **Hooks** (`.module`): `hook_preprocess_node`, `hook_preprocess_paragraph`,
  `hook_preprocess_block`, `hook_preprocess_taxonomy_term`, `hook_views_pre_render`;
  helper `dynamic_library_loader_get_library_mappings()`.
- **Forms:** `Form\DynamicLibraryLoaderListForm` (list/add entries),
  `Form\DynamicLibraryLoaderEntryForm` (edit one entry's rows).
- **Controller:** `Controller\DynamicLibraryLoaderController::delete()` (delete an entry).
- **Service providers:** `DynamicLibraryLoaderServiceProvider` and
  `AssetCacheBustServiceProvider` both re-class `asset.css.collection_renderer` and
  `asset.js.collection_renderer` to `AssetCachingCSSCollectionRenderer` /
  `AssetCachingJSCollectionRenderer` (cache-bust query-string append).
- **Routes** (`.routing.yml`, all `_permission: administer site configuration`):
  `list_entries`, `edit_entry`, `delete_entry`. Menu link under
  `system.admin_config_development`.

## Solution docs
- [Configuration & data model](config/settings.md) — the settings object, entry/row
  schema, context types, routes, forms, and the migration update.
- [Attachment & renderer internals](api/attachment.md) — how mappings are matched and
  attached per context, and the CSS/JS cache-bust renderer override.
