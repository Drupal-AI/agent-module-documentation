SVG Image Responsive is a submodule of SVG Image that overrides the core Responsive image formatter so SVG files display correctly through responsive image styles.

---

Core's Responsive image formatter builds `<picture>`/`srcset` markup from raster image styles and cannot handle SVG files, which have no fixed pixel dimensions. This submodule swaps in `SvgResponsiveImageFormatter`, a subclass of the core `ResponsiveImageFormatter` that reuses SVG Image's shared `SvgImageFormatterTrait`. For non-SVG files it defers entirely to the parent formatter, so JPG/PNG images keep their normal responsive behavior. When an item is an SVG it instead renders it either as an `<img>` tag (using the responsive style's fallback image style to derive dimensions) or as sanitized inline `<svg>` markup, mirroring the main module's `svg_render_as_image` and `svg_attributes` settings. It also re-points the plain `image` formatter to SVG Image's `SvgImageFormatter` via `hook_field_formatter_info_alter()` and registers config schema for the added responsive-formatter settings. It requires both the parent `svg_image` module and core's `responsive_image` module. Enable it only when your site actually uses responsive image styles.

---

- Render SVG logos through a responsive image style without breaking `<picture>` markup.
- Let raster images stay fully responsive while SVGs are handled specially.
- Show SVG icons as inline `<svg>` in a responsive image display.
- Display SVGs as `<img>` using the responsive style's fallback image style dimensions.
- Force explicit width/height on SVGs in a responsive formatter.
- Serve crisp vector graphics across mobile, tablet, and desktop breakpoints.
- Add SVG support to an existing responsive image field with no field changes.
- Sanitize inline SVGs in responsive displays to prevent XSS.
- Use SVG hero art on a responsive marketing page.
- Mix responsive raster photos and vector illustrations in one field.
- Link responsive SVG images to their file or a content page.
- Keep responsive image config compatible by reusing the core `responsive_image` formatter ID.
- Provide resolution-independent brand assets in responsive layouts.
- Style inline responsive SVGs with theme CSS (fills, strokes).
- Avoid pixelation of vector art on high-DPI screens in responsive displays.
- Reuse the same SVG dimension/inline settings as the main SVG Image module.
- Support SVG country flags in a responsive multilingual header.
- Render responsive vector diagrams uploaded by editors.
- Fall back gracefully to the responsive style's fallback image style for SVG sizing.
- Enable SVGs in decoupled themes that rely on responsive image markup.
