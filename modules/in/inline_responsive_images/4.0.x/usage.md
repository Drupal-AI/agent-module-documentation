Inline Styled Images (project `inline_responsive_images`) lets editors pick a Drupal **image style** or **responsive image style** for images inserted through the CKEditor 5 image dialog, instead of typing raw pixel dimensions.

---

The module ships two text-format filters — **Display image styles** (`filter_imagestyle`) and **Display responsive images** (`filter_responsive_image_style`) — plus two matching CKEditor 5 plugins. You enable one of the filters on a text format and tick the image styles (or responsive image styles) you want editors to be able to choose. Each filter stores its allowed styles as a list under `settings.image_styles` in the format config. In the editor, the CKEditor 5 plugin adds a style dropdown to the image balloon toolbar; the chosen style id is written onto the `<img>` as a `data-image-style` or `data-responsive-image-style` attribute. At render time the filter (a `TYPE_TRANSFORM_REVERSIBLE` filter, weight 100) reads that attribute together with the image's `data-entity-uuid`, loads the file, and replaces the tag with a themed `image_style` or `responsive_image` render array. Because the transform is reversible, the stored markup keeps only the data-attribute, so editors are never locked into fixed width/height. The module has no admin settings page or configure route — all configuration lives on the text format. It requires core Editor, Image, CKEditor 5 and (for responsive styles) Responsive Image.

---

- Let editors choose a predefined image style for inline images instead of manual width/height.
- Offer a curated set of responsive image styles (`<picture>` with breakpoints) inside CKEditor 5.
- Enforce structured, consistent image sizing across body content site-wide.
- Add a "Drupal image style" dropdown to the CKEditor 5 image balloon toolbar.
- Add a "Drupal responsive image style" dropdown to the CKEditor 5 image balloon toolbar.
- Remove the free-form dimensions box from the editor image dialog so authors can't hard-code sizes.
- Serve smaller derivatives for inline article images to improve page performance.
- Ship art-directed responsive images (different crops per breakpoint) from within rich text.
- Restrict a specific text format (e.g. "Basic HTML") to only a few approved image styles.
- Store only a `data-image-style` attribute in the body markup and generate the real `<img>` at render time.
- Store only a `data-responsive-image-style` attribute and generate a `<picture>` element at render time.
- Keep editor markup clean and reversible so switching styles later just changes one attribute.
- Apply lazy-loadable, correctly sized inline images without a custom media type.
- Give a WYSIWYG equivalent of the image-style selection editors already have on image fields.
- Let different text formats expose different sets of allowed styles.
- Migrate legacy body images to responsive images by enabling the filter and re-selecting a style.
- Present editors with live previews of each image style in the (CKEditor 4) image dialog.
- Prevent oversized originals from being embedded at full resolution in articles.
- Standardise thumbnail vs. full-width inline images through named styles.
- Combine with core's file/UUID tracking so embedded images survive file moves.
- Ensure only image styles explicitly checked in the filter settings appear to editors.
- Avoid writing a custom CKEditor plugin just to add image-style selection.
- Deploy the allowed-styles configuration as part of a text format's exported config.
- Provide accessible, aspect-ratio-safe inline images without editors touching HTML.
