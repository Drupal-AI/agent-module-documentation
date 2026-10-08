<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insert adds a small JavaScript "Insert" button to file and image field widgets on entity edit forms, letting editors drop the uploaded file/image (as a link, `<img>`, `<audio>`/`<video>`, or a chosen image style) straight into a nearby text area or CKEditor body field.

---

Insert is a field-widget enhancement, not a new field type. It attaches to configured file/image field widgets (by default the core `file_generic` and `image_image` plugins, listed in the global `insert.config` object) and, per widget, exposes an **Insert** fieldset on *Manage form display* whose choices are stored as a `third_party_settings.insert` array on that form-display component. That per-widget setting controls which *insert styles* (the AUTOMATIC pseudo-style, "Link to file", "Embed audio/video", "Original image", and every configured image style) are offered, the default style, an automatic image style, an optional "link image to" style, a maximum insert width, and rotation controls. At edit time `insert_form_alter()` marks flagged elements, `_insert_field_process()` builds hidden HTML templates for each enabled style, and `js/insert.js` copies the chosen markup into the focused text field. A set of hooks (`hook_insert_widgets`, `hook_insert_styles`, `hook_insert_process`, `hook_insert_variables`, `hook_insert_render`, plus `hook_insert_config_form`) lets other modules register new source widgets, styles, and rendering — which is exactly how the bundled `insert_media`, `insert_colorbox`, and `insert_responsive_image` submodules extend it. Global settings (`/admin/config/content/insert`) also cover absolute vs relative URLs, treating images uploaded to generic file fields as images, extra CSS classes, and audio/video file-extension detection.

---

- Let editors insert an uploaded image into a node's body field without leaving the edit form.
- Add a "Link to file" button to a document/PDF file field so the link drops into the WYSIWYG.
- Offer only specific image styles (e.g. `thumbnail`, `large`) for inline insertion on an image field.
- Force a single image style to be used automatically by enabling exactly one insert style.
- Set the default insert style (AUTOMATIC) so editors get a sensible choice pre-selected.
- Constrain inserted images to a maximum width in the HTML output without resizing the file.
- Give editors rotation controls on an image field before inserting.
- Embed uploaded `.mp3`/`.mp4` files as `<audio>`/`<video>` by mapping those extensions in Insert config.
- Allow `<img>` tags to be inserted from a *generic file* field via the "file field images enabled" toggle.
- Add custom CSS classes to every image or file link Insert produces, site-wide.
- Emit absolute URLs (full base URL) instead of relative paths for inserted media.
- Enable Insert on a contrib widget by adding its plugin id to `insert.config` widgets lists.
- Insert media-library items in a chosen view mode via the `insert_media` submodule.
- Insert Colorbox-enabled images or galleries via the `insert_colorbox` submodule.
- Insert responsive images (srcset/sizes) via the `insert_responsive_image` submodule.
- Standardise inline image markup across many content types by configuring each image widget.
- Provide a "Original image" insert option alongside styled derivatives.
- Link an inserted image derivative to a larger style (e.g. thumbnail links to full image).
- Migrate Drupal 7 insert widget settings via the bundled migration integration.
- Build a custom insert type (e.g. text snippets) by implementing the Insert hooks.
- Keep inserted markup intact in CKEditor 5 by installing `insert_media`'s allowed-HTML plugin.
- Let content authors add several styled copies of the same uploaded image into one body.
- Turn Insert off for a field by selecting no styles in its widget settings.
- Restrict which widgets show the Insert button by editing the global widgets lists.
- Present audio/video players inline for media attachments on articles or pages.
