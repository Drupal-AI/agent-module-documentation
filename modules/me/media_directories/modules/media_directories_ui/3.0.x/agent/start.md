<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories UI — agent index

> **DEPRECATED** — `media_directories_ui.info.yml` declares `lifecycle: deprecated`.
> New work should use `media_directories_browser` (the Vue.js browser). This submodule is the
> legacy `entity_browser` + jsTree UI.

- **Settings keys, where the form lives, routes, permission, entity browsers** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Depends on `media_directories` **and contrib `entity_browser`**; requires the `jstree`
  library (see the project's `composer.libraries.json`).
- Permission: **`access media directories ui browser`** — *not* the same as
  `media_directories_browser`'s `access media directories browser`.
- Config object **`media_directories_ui.settings`**: `hide_media_library_media_tab`,
  `hide_media_library_files_tab`, `hide_admin_toolbar_links`, `enable_combined_upload`,
  `combined_upload_media_types`. There is **no route of its own for the form** — it injects a
  *"Media browser UI"* details element into the parent module's settings form via
  `hook_form_media_directories_config_form_alter()`.
- Shipped config: `entity_browser.browser.media_directories_overview`,
  `entity_browser.browser.media_directories_modal`,
  `views.view.media_directories_base`, `image.style.browser_thumbnail`.
- Entity Browser widget id **`media_directories_browser_widget`**
  (`@EntityBrowserWidget`, class `DirectoryBrowser`) — same *string* as
  `media_directories_browser`'s **field widget**, but a different plugin type.
- Ten AJAX routes under `/admin/media_directories/…` (`directory/tree`, `…/content`,
  `…/add`, `…/rename`, `…/delete`, `…/move`, `media/add`, `media/edit`, `media/move`,
  `media/delete`).
