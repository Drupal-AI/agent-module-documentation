<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor5 Media Resize lets editors drag-resize embedded `<drupal-media>` images inside CKEditor 5, storing the chosen width as a `data-media-width` attribute and rendering it as an inline `width:` style — optionally swapping in a matching image style so the browser downloads a correctly-sized derivative.

---

The module adds one CKEditor 5 plugin (`ckeditor_media_resize_mediaResize`) and one text filter (`filter_resize_media`, "Resize media images"). The CKEditor plugin extends core's `drupalMedia` configuration with `resizeUnit: 'px'`, a `resizeMediaImage:original` resize option, a `resizeMediaImage` toolbar item and `dataAttribute: data-media-width`, so the editor writes the resize result onto the `<drupal-media>` tag rather than onto a wrapper. It declares `<drupal-media data-media-width>` as an allowed element and is only offered on text formats where the **Resize media images** filter is enabled, the `drupalMedia` toolbar item is present and core's `media_media` plugin is active. On render, `FilterResizeMedia::process()` walks the DOM for any element carrying `data-media-width`, removes that attribute, and merges `width:<value>` into the element's inline `style` while adding the class `media-embed-resized`. When the plugin's `apply_image_styles` setting is on (default `TRUE`) — and the filter is *not* running for the in-editor `media.filter.preview` route — it also picks a `data-view-mode` for the node by finding the smallest of the configured image styles whose scale width is `>= ` the requested width. The four styles it ships (`cke_media_resize_small` 200px, `_medium` 500px, `_large` 800px, `_xl` 1200px) plus matching media view modes and image view displays come from `config/install` and `config/optional`. The filter is `TYPE_TRANSFORM_REVERSIBLE` with weight 90 and **must run before core's "Embed media" filter**, which requires "Limit allowed HTML tags and correct faulty HTML" to be active. Its only settings live on the CKEditor plugin (`apply_image_styles`, `image_styles`) inside the editor config entity; there is no module settings page (`configure` is `null`).

---

- Let editors drag the corner of an embedded image in CKEditor 5 to set its display width.
- Give a `<drupal-media>` embed an explicit inline `width:` without hand-editing HTML source.
- Serve a smaller image derivative for a small inline embed instead of the full-size original.
- Add the `resizeMediaImage` toolbar item to the media balloon toolbar of a text format.
- Restore an image to its original size using the `resizeMediaImage:original` option.
- Style all resized embeds through the generated `media-embed-resized` class.
- Map a requested pixel width to a media view mode automatically (`cke_media_resize_small/medium/large/xl`).
- Turn off automatic image-style swapping and keep only the CSS width, via the plugin's "Apply image styles" checkbox.
- Reduce page weight on content-heavy pages by not shipping 3000px originals for 200px thumbnails.
- Add the "Resize media images" filter to a Basic/Full HTML text format.
- Order the filter before "Embed media" so the resize data survives into the rendered markup.
- Preserve an author's manual width when other filters also rewrite `style` attributes (existing `width:` is replaced, not duplicated).
- Support percentage widths (`data-media-width="50%"`) as well as pixel widths.
- Keep the in-editor preview un-styled while still applying styles on the rendered page (the filter skips the `media.filter.preview` route).
- Reuse the shipped `cke_media_resize_*` image styles (`image_scale`, `upscale: true`) for other display purposes.
- Replace the shipped resize styles with your own by editing the plugin's `image_styles` list in the editor config entity.
- Give each resize step its own media view display so alt/title handling differs per size.
- Migrate legacy content by adding `data-media-width` to existing `<drupal-media>` tags and letting the filter convert them.
- Debug an embed by checking whether `data-media-width` survived the text-format filter chain.
- Audit which text formats offer media resizing by inspecting `editor.editor.*` settings for `ckeditor_media_resize_mediaResize`.
- Enforce a maximum inline width by capping the configured image styles.
- Keep responsive-image behaviour intact because the filter only sets a CSS width and a view mode, never a hard `width` attribute on `<img>`.
- Combine with core's media embed view-mode override to control both the size and the display mode of an embed.
- Provide art-directed sizes for editorial layouts without building a custom CKEditor plugin.
