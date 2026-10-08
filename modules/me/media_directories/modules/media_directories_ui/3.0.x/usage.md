<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories UI is the **deprecated** (`lifecycle: deprecated`) jQuery/Entity Browser-based media management UI that Media Directories shipped before 3.x; on new sites use `media_directories_browser` instead.

---

The submodule builds a folder-tree media browser on top of contrib `entity_browser`. It ships two entity browsers in `config/install` (`media_directories_overview`, the standalone admin page, and `media_directories_modal`, the field-widget dialog), a supporting view `views.view.media_directories_base`, and an image style `browser_thumbnail`. Its own `@EntityBrowserWidget(id = "media_directories_browser_widget")` — `DirectoryBrowser` — renders the jsTree directory sidebar plus a media grid, and a `TargetBundles` widget-validation plugin constrains selections. A controller (`MediaDirectoriesController`) exposes ten AJAX endpoints under `/admin/media_directories/...` for directory tree/content/add/rename/delete/move and media add/edit/move/delete, all gated by its own permission **`access media directories ui browser`** (note: distinct from the browser submodule's permission). Two custom AJAX commands (`LoadDirectoryContent`, `RefreshDirectoryTree`) drive the client, and forms cover file upload, oEmbed, combined upload, media edit/delete and directory delete. Configuration lives in `media_directories_ui.settings` — `hide_media_library_media_tab`, `hide_media_library_files_tab`, `hide_admin_toolbar_links`, `enable_combined_upload`, `combined_upload_media_types` — and is edited not on its own page but through `hook_form_media_directories_config_form_alter()`, which injects a **"Media browser UI"** details element into the parent module's settings form. The same hooks class removes the core Media/Files local tasks and the `admin_toolbar_tools` media links when those settings are on, strips `entity_browser`'s CSS on its own route, denies block access inside the browser iframe, adds a `StringContainsArgument` views argument, and registers three theme hooks (`media_directories_browser`, `media_directories_add`, `views_view_unformatted__media_directories_base`). Because it is deprecated, prefer it only when you are maintaining an existing Entity Browser-based site.

---

- Keep an existing Entity Browser-based media UI working after upgrading Media Directories.
- Offer a folder-tree media browser to sites that cannot run the Vue.js browser.
- Use `media_directories_overview` as a standalone admin media page.
- Use `media_directories_modal` as an entity-browser dialog for media reference fields.
- Attach the `media_directories_browser_widget` entity-browser widget to a custom entity browser.
- Constrain a browser's selection to specific media bundles with the `TargetBundles` validator.
- Hide core's *Media* tab on `/admin/content` (`hide_media_library_media_tab`).
- Hide core's *Files* tab on `/admin/content` (`hide_media_library_files_tab`).
- Remove the `admin_toolbar_tools` media links so editors only see the folder browser.
- Offer one combined upload form that routes files to a media type by extension.
- Restrict combined upload to a chosen set of media types.
- Upload files straight into the currently open directory.
- Add remote media via the oEmbed form inside the browser.
- Rename, move or delete a directory through the browser's AJAX endpoints.
- Move selected media between directories in bulk.
- Delete media from within the browser.
- Grant `access media directories ui browser` to editorial roles only.
- Theme the browser through `media-directories-browser.html.twig` and `media-directories-add.html.twig`.
- Customise the media grid via `views.view.media_directories_base` and its unformatted-row template.
- Re-use the `browser_thumbnail` image style for other compact media previews.
- Filter the base view with the `StringContainsArgument` contextual filter.
- Adapt the jsTree sidebar styling for the Gin admin theme (dedicated CSS ships for it).
- Audit whether a site still depends on this deprecated UI before removing entity_browser.
- Plan a migration to `media_directories_browser`, whose settings supersede these.
