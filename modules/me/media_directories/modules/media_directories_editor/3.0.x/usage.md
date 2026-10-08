<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories Editor is the **deprecated** (`lifecycle: deprecated`) `entity_embed`-based CKEditor integration for Media Directories; on Drupal 11 use the CKEditor 5 integration in `media_directories_browser` instead.

---

It depends on `media_directories_ui`, contrib `embed` (≥ 8.x-1.6) and `entity_embed`, and ships three config objects in `config/install`: the embed button `embed.button.media_directories` (label *Media*, icon a folder SVG, entity type `media`, entity browser `media_directories_editor_browser`, display plugin `entity_reference:media_directories_image_dimensions`), the entity browser `entity_browser.browser.media_directories_editor_browser` (an iframe browser reusing the UI submodule's directory widget) and `media_directories_editor.settings` (a single nested key, `embed_dialog.image_styles`). `hook_install()` adds the standard `image` and `remote_video` bundles to the button when they exist, plus a `view_mode:media.full` display plugin; `hook_uninstall()` deletes the browser and button config again. Configuration is injected into the **parent** module's settings form by `hook_form_media_directories_config_form_alter()`, which adds an *"Editor Settings"* details element with a multi-select of image styles for the embed dialog (empty means "show all") and prepends `media_directories_editor_config_form_submit()` to the form's submit handlers. A second alter, `hook_form_entity_embed_dialog_alter()`, only fires for the `media_directories` embed button: it replaces the selected-entity markup with a linked `media_library`-styled thumbnail, JSON-decodes stringified `data-entity-embed-display-settings` for image media, and attaches a `target_bundles` entity-browser validator built from the button's own bundle settings. A preprocess hook strips `data-entity-embed-display-settings` from the rendered embed container. The module also provides one field formatter, `media_directories_image_dimensions` (`MediaDirectoriesImageDimensionsFormatter extends MediaThumbnailFormatter`), which renders a media thumbnail at explicit width/height, plus an `image-resize` library (jQuery-based) used inside the embed dialog. Its image-style setting has a forward path: `media_directories_browser_update_11004()` migrates `embed_dialog.image_styles` into `media_directories_browser.settings:embed_image_styles`.

---

- Keep an existing `entity_embed`-based CKEditor media workflow running after upgrading.
- Give CKEditor a *Media* embed button backed by the Media Directories folder browser.
- Restrict the embed dialog to a curated list of image styles.
- Show every image style in the embed dialog by leaving the style list empty.
- Embed media at explicit pixel dimensions with the `media_directories_image_dimensions` formatter.
- Preview the selected media as a linked thumbnail inside the embed dialog.
- Limit which media bundles the embed button can select (the `target_bundles` validator).
- Add `image` and `remote_video` to the embed button automatically at install time.
- Add a `view_mode:media.full` display option to the embed button.
- Use `entity_browser.browser.media_directories_editor_browser` as an iframe media picker.
- Clean up rendered markup by dropping `data-entity-embed-display-settings` from the container.
- Support legacy content whose embeds are `<drupal-entity>` tags (pair with `media_directories_compat`).
- Migrate the curated style list forward to the Vue browser via `media_directories_browser_update_11004()`.
- Identify sites still relying on `entity_embed` before removing it.
- Style the embed dialog's resize widget through the module's `image-resize` library.
- Provide editors a folder-based picker without enabling the Vue.js browser.
- Reuse the folder embed-button icon (an inline base64 SVG) for a custom button.
- Audit `embed.button.media_directories` to see which bundles and display plugins are allowed.
- Remove the button and browser cleanly by uninstalling the module (`hook_uninstall` deletes both).
- Keep CKEditor 4-era editorial habits during a phased CKEditor 5 rollout.
- Compare `embed_dialog.image_styles` with `media_directories_browser.settings:embed_image_styles` during migration.
- Decide whether the deprecated module can be dropped by checking for remaining `<drupal-entity>` content.
- Keep the media label linked to the media page from within the dialog for quick checks.
- Plan the switch to `media_directories_browser`'s `media_directories_browser_image_options` plugin.
