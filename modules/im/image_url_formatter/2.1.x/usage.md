Image URL Formatter adds a field formatter that renders an image field as just its URL in plain text (optionally through a chosen image style), instead of a full `<img>` tag.

---

The module provides a `image_url_formatter` field formatter (plugin id `image_url_formatter`, label "Image URL Formatter") for `image` fields, plus a companion `file_url_formatter` for plain `file` fields. Most of its code derives from core's `ImageFormatter`, but the render output is the file's URL as text rather than an image tag. On a bundle's **Manage display** page (or in a View's field settings) you select the formatter and configure three settings: `url_type` (0 = Full URL with scheme/host, 1 = Absolute file path with leading slash, 2 = Relative file path), an optional `image_style` (run the URL through an image style preset, or "None (original image)"), and `image_link` (wrap the URL in a link to the Content or the File, or Nothing). The output is produced by the `image_url_formatter` theme hook and its `image-url-formatter.html.twig` template, which simply prints the resolved `url`. Under the hood `viewElements()` builds the file URL with the `file_url_generator` service; when an image style is set its `buildUrl()` is used and the style's cache tags are merged in. Absolute/relative variants are produced by stripping `$base_url` (or `$base_url . '/'`) from the full URL in the preprocess function. It has no admin settings form, no permissions, and no dependencies beyond core `image`. Typical use is exposing an image URL to another template, a data attribute, a JSON/REST-style View, or a meta tag such as `og:image`.

---

- Output an image field as a bare URL string instead of an `<img>` tag.
- Feed an image URL into a `<meta property="og:image">` tag for social sharing.
- Emit an image URL as a `content` field in a View used as a JSON/data feed.
- Populate a CSS `background-image` value from a field's image URL in a Twig template.
- Pass an image URL into a custom HTML attribute (e.g. `data-src` for lazy loading).
- Render the URL of a specific image style preset (e.g. `thumbnail`, `large`) as text.
- Output the original (un-styled) image URL by leaving the image style as "None".
- Emit a full absolute URL (with scheme and host) using URL type "Full URL".
- Emit a root-relative path (leading slash) using URL type "Absolute file path".
- Emit a path with no leading slash using URL type "Relative file path".
- Provide an image URL to a decoupled/front-end consumer reading rendered View output.
- Wrap the printed URL in a link to the host content entity (`image_link` = Content).
- Wrap the printed URL in a link to the file itself (`image_link` = File).
- Supply an image URL to an email template built from rendered field output.
- Reference an image URL inside a Layout Builder or custom block template.
- Expose a logo or hero image URL for use in a theme's inline styles.
- Build a sitemap or structured-data snippet that needs the image URL as text.
- Use the companion `file_url_formatter` to print a plain file field's URL as text.
- Output a document/download URL from a file field for use in links or attributes.
- Get an image-style-derived URL to hand to a JavaScript widget via a data attribute.
- Avoid writing a custom formatter just to grab an image field's URL in a template.
- Configure the formatter per view mode so different displays emit different URL forms.
- Combine with Views REST/data export to serve image URLs to an API consumer.
