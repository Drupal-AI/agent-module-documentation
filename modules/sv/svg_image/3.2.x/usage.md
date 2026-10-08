SVG Image lets the standard core Image field accept, preview, and display SVG files by transparently overriding Drupal's image widget and formatters — no separate field or file type needed.

---

Out of the box Drupal's Image field rejects SVG uploads because core validates them as raster images and its formatters cannot render vector markup. SVG Image swaps in replacement classes for the core `image_image` widget and the `image` and `image_url` formatters via `hook_field_widget_info_alter()` and `hook_field_formatter_info_alter()`, so existing Image fields keep working while gaining SVG support. To allow SVGs you simply add the `svg` extension to a field's allowed extensions; the overridden widget then permits the upload, removes the "file is image" validator, and shows a proper preview of the SVG. On display each SVG can be rendered either as an `<img>` tag or as inline `<svg>` markup, and you can force explicit width/height attributes through the formatter settings. Every SVG that is inlined is first run through the `enshrined/svg-sanitize` library to strip scripts and other unsafe content, mitigating XSS from uploaded vector files. Because SVGs have no fixed pixel dimensions, the module derives width/height from the SVG's own attributes (falling back to 64x64) and adds a `no-image-style` class so image styles degrade gracefully. Uninstalling cleanly removes the `svg` extension it added to fields and restores the core Image dependency. A bundled `svg_image_responsive` submodule extends the same treatment to the core Responsive image formatter.

---

- Allow editors to upload `.svg` logos and icons into an existing Image field.
- Display a vector logo crisply at any size using inline `<svg>` output.
- Keep SVGs as `<img>` tags when you prefer them treated like normal images.
- Add SVG support without creating a separate file or media field.
- Sanitize uploaded SVGs to remove embedded scripts and prevent XSS.
- Show a correct thumbnail preview of an SVG in the node edit form.
- Force a fixed width and height on rendered SVGs via formatter settings.
- Serve scalable icons that stay sharp on high-DPI/retina displays.
- Mix raster (JPG/PNG) and vector (SVG) images in the same field.
- Provide clean SVG URLs through the "URL to image" formatter for decoupled front ends.
- Render brand illustrations inline so their colors can be styled with CSS.
- Let image styles fall back gracefully for SVGs that can't be resized on the server.
- Use SVG flags or country icons in a multilingual site.
- Display vector infographics or charts uploaded by content editors.
- Add SVG avatars or profile badges to user Image fields.
- Reduce page weight by shipping small vector icons instead of large PNGs.
- Give designers a no-code path to swap raster images for vectors.
- Support animated SVGs rendered inline on marketing pages.
- Attach SVG pattern/texture backgrounds to content types.
- Enable SVG in existing content models without a migration.
- Keep the original core widget label and formatter IDs so themes/config stay compatible.
- Automatically strip XML declarations and DOCTYPE from inlined SVG markup.
- Cleanly remove SVG support (and the `svg` extension) on uninstall.
- Provide accessible, resolution-independent icons for menus and CTAs.
- Style inline SVG fills and strokes to match a site theme.
