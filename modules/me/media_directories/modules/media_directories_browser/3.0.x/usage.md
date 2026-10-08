<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories Browser is the Vue.js asset manager for Media Directories: a full-page and modal media browser with a drag-and-drop folder tree, upload, bulk edit, quick edit, translations and CKEditor 5 integration, all driven by a JSON API on `/api/media-directories-browser/*`.

---

The module ships a compiled Vue 3 single-page app (`dist/media-directories-browser-app.iife.js`) mounted by `MediaDirectoriesBrowserController::adminPage()` at **`/admin/content/media-browser`** (route `media_directories_browser.admin`, permission **`access media directories browser`**). Everything the app does goes through ~25 JSON routes on `ApiController` — listing and paginating media, media counts per directory, uploading files, creating media from a URL, updating/deleting/moving media, CRUD and reordering of directories, entity autocomplete, styled image URLs and translation saves — all guarded by the same permission and `_auth: [basic_auth, cookie]`. Six services do the work: `DirectoryService` (term-tree CRUD keyed by UUID, honouring the `directory_sort` mode), `MediaService` (the big one: listing, upload, derivative URLs, entity_usage links), `MediaTypeService` (per-bundle editable-field metadata and `getFileBasedBundles()`), `MediaTranslationService` (per-language field values, optional `content_translation`), `FocalPointService` (no-op without `drupal/focal_point`) and `EntityAutocompleteService`. Runtime behaviour is configured on one config object, `media_directories_browser.settings` (~22 keys: remember-* local-storage toggles, `page_size`, bulk actions and their per-bundle field lists, preview/selection drawers, directory counts and sort mode, combined upload, `embed_image_styles`, translation types, date formats and three `experimental_*` flags), which `hook_page_attachments()` serialises into `drupalSettings.mediaDirectoriesBrowser` on every page so the CKEditor integration can read it. On the editing side it adds a field widget (`media_directories_browser_widget`, for entity_reference fields, multi-value), an off-canvas quick-edit form (route `media_directories_browser.media_quick_edit`, using a `media_library` form operation registered via `hook_entity_type_alter()`), three CKEditor 5 plugins (`media_directories_browser_media_directories_browser` which replaces core's media dialog with the Vue browser, `media_directories_browser_image_options` which adds a unified size/view-mode dropdown emitting `data-image-style`/`data-width`/`data-height`, and `media_directories_browser_media_file_link` which links files from the CKEditor link form) and one text filter, `media_directories_default_view_mode`, that stamps a per-bundle default `data-view-mode` onto `<drupal-media>` tags before core's Embed media filter runs. It also takes over the "Media" links in the admin toolbar and the core Navigation module so they point at the browser.

---

- Give editors a full-screen folder-based media manager at `/admin/content/media-browser`.
- Replace CKEditor 5's media dialog with the directory browser when embedding media.
- Let editors create, rename, move, reorder and delete media folders by drag and drop.
- Upload many files at once into a specific folder.
- Create media from a remote URL (oEmbed-style sources) without leaving the browser.
- Drag media items between folders to re-file them.
- Use `media_directories_browser_widget` on an entity reference field so content forms open the browser.
- Limit a field widget's browser to the bundles allowed by the field's `handler_settings.target_bundles`.
- Quick-edit a media item's metadata in an off-canvas drawer without leaving the host form.
- Turn on bulk actions and edit a chosen set of fields across many selected media at once.
- Restrict which fields bulk actions expose, per media bundle (`bulk_action_fields`).
- Show a per-directory media count badge in the sidebar (`show_directory_counts`).
- Page the media grid in chunks other than the default 100 (`page_size`).
- Remember an editor's last folder, sort, sidebar and grid/list choice in browser local storage.
- Sort the directory tree alphabetically or by term weight (`directory_sort`).
- Offer a single "upload anything" control that routes files to the right media type by extension (`enable_combined_upload`).
- Curate exactly which image styles CKEditor offers in its display dropdown (`embed_image_styles`).
- Give each media bundle a default view mode for embeds with the `media_directories_default_view_mode` filter.
- Set explicit width/height on an embed via the `data-width`/`data-height` attributes the image-options plugin emits.
- Translate media metadata per language from the browser's edit modal (needs `content_translation`).
- Pick which media types get translation tabs (`translation_types`).
- Set a focal point on an image inside the edit modal (needs `drupal/focal_point`).
- Show a "where is this used" link on a media item (needs `drupal/entity_usage`).
- Try the experimental full-screen layout, floating add button and top-bar add button.
- Grant only trusted roles the `access media directories browser` permission.
- Drive the same API from a custom script or a headless client (cookie or basic auth).
