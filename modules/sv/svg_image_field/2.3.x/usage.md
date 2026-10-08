SVG image field adds a dedicated "Vector image" field type, upload widget and display formatters so SVG files (which core's Image field rejects) can be uploaded, sanitized and rendered on Drupal sites.

---

Core's image field is backed by GD/ImageMagick and does not accept SVG, so this module ships its own field type (`svg_image_field`, id "Vector image") built on the core File field, plus a matching widget and two formatters. The widget shows an inline SVG preview at a configurable max size and supports optional Alt and Title fields just like the image field. The main formatter (`svg_image_field_formatter`) can render the SVG inline in the DOM or as an `<img>`, apply width/height dimensions, force-fill, link the image to content or file, and — importantly — sanitize the markup on output using the bundled `enshrined/svg-sanitize` library to strip scripts and other unsafe content (with a separate option for remote SVGs). A second formatter (`svg_image_url_formatter`) outputs just the file URL. A media source plugin (`svg`) lets you build an SVG media type so SVGs work with the Media Library, and a validation constraint (`FileIsSvgImage`) verifies uploaded files are genuinely SVG by checking MIME type and content. The module also integrates with Views and provides a media-library stylesheet. An optional submodule, `svg_image_field_media_bundle`, imports a ready-made "Vector image" media type (and Acquia Site Studio components when present) so you don't have to configure the media type by hand.

---

- Add an SVG upload field to a content type, taxonomy vocabulary or any entity.
- Display crisp, resolution-independent logos and icons that scale on any screen.
- Render SVGs inline in the DOM so their paths can be styled/animated with CSS.
- Output SVGs as `<img>` tags with configurable width and height.
- Sanitize uploaded SVGs on output to strip embedded scripts and XSS vectors.
- Sanitize remote SVGs separately before rendering them.
- Provide Alt and Title text on SVG images for accessibility.
- Require Alt text on SVG fields to enforce accessible markup.
- Build an SVG media type using the provided `svg` media source plugin.
- Use SVG media in the core Media Library with proper previews.
- Show a live SVG preview in the edit form at a bounded max width/height.
- Output only the SVG file's URL (via the URL formatter) for use in templates or CSS.
- Link an SVG image to its entity or to the raw file.
- Force-fill an SVG to a container's dimensions.
- Validate that uploaded files are true SVGs by MIME and content sniffing.
- Reject disguised or malformed files that are not valid SVG images.
- Use SVG fields as sources/filters in Views listings.
- Ship a preconfigured "Vector image" media bundle via the submodule.
- Store scalable brand assets (logos, badges) as first-class media entities.
- Serve small vector icons instead of large raster PNGs to improve performance.
- Provide illustrations that remain sharp on high-DPI/retina displays.
- Apply a default SVG image when a field is left empty.
