Colorbox Inline Text Filter adds a text-format filter that wraps every inline `<img>` in rich-text content with a Colorbox link to the image's own source, so images in body fields open in a Colorbox lightbox. It depends on the Colorbox module.

---

The module provides one filter plugin, `ckeditor_colorbox_inline` ("Colorbox Inline Text Filter", a `TYPE_TRANSFORM_IRREVERSIBLE` filter), that you enable per text format at *Administration → Configuration → Content authoring → Text formats and editors*. When the filter processes text it loads the HTML, finds every `<img>`, and — unless the image's `class` contains `noColorbox` — inserts an `<a>` around it whose `href` is the image's `src`, sets the anchor's class to the configurable CSS classes (default `colorbox`), and adds `data-colorbox-gallery="ckeditor-colorbox-inline"` so all such images form one Colorbox gallery. The only filter setting is `css_classes` (a space-delimited class string). `hook_page_attachments` attaches Colorbox's own assets (via the `colorbox.attachment` service) plus the module's `ckeditor_colorbox_inline` library on every page. There is no admin settings page of its own (configuration is the per-format filter settings) and no permissions, Drush, or plugin types. Despite the name it is not a CKEditor plugin — it is a display-time output filter, so it also affects images that were added by any means, not just via CKEditor.

---

- Make inline body images open in a Colorbox lightbox when clicked.
- Turn all images in a rich-text field into a single Colorbox gallery.
- Enable the effect per text format (e.g. Full HTML but not Basic HTML).
- Set custom CSS classes on the generated links (default `colorbox`).
- Exclude specific images from the lightbox by adding the `noColorbox` class.
- Provide a lightweight image lightbox without embed/media configuration.
- Let editors get lightbox behavior automatically without adding link markup.
- Apply Colorbox to images regardless of how they were inserted into the HTML.
- Group a body's images so users can page through them in the lightbox.
- Reuse the site's existing Colorbox settings/styling for inline images.
- Add lightbox behavior to legacy content by enabling the filter on its format.
- Keep image markup clean in source, adding the link only at display time.
- Style the lightbox trigger differently by supplying multiple classes.
- Avoid per-image manual linking to full-size images for lightbox display.
- Ensure product or gallery images in descriptions are zoomable.
- Combine with Colorbox's slideshow option for an automatic image slideshow.
- Give documentation/article screenshots click-to-enlarge behavior.
- Opt a single decorative image out of the gallery with `noColorbox`.
- Provide a consistent lightbox experience across all content types sharing a format.
- Quickly add lightbox support to a site that already uses the Colorbox module.
