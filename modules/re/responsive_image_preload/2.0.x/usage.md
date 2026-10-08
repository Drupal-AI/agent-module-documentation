Responsive Image Preload lets site builders flag any field rendered with core's Responsive Image formatter so it emits `<link rel="preload" as="image">` tags (with `imagesrcset`/`imagesizes` matching the responsive image style) into the page head, improving Largest Contentful Paint.

---

The module adds a single boolean third-party setting, `generate_preloads`, to the core `responsive_image`
field formatter (via `hook_field_formatter_third_party_settings_form()` and a summary alter). When enabled
on a display component, `hook_preprocess_field()` runs `FieldPreprocessor`, which loads the effective
`entity_view_display`, checks the flag, and calls `PreloadGenerator::generatePreloads()`. That service walks
the field's rendered image items, loads the referenced `responsive_image_style` and its breakpoint group,
and for each breakpoint/multiplier mapping (both `sizes` and `image_style` mapping types) builds the derivative
URLs. It produces one `link` render element per file/style/breakpoint with `rel=preload`, `as=image`, an
`imagesrcset` built from the image-style derivative URLs and their widths, plus `media` (from the breakpoint
media query) and `imagesizes` where a `sizes` mapping exists. These are attached to `#attached['html_head']`
so they bubble into the document `<head>`. There is no admin settings page (`configure` is null), no
permissions, no Drush, and no plugins — it is purely a formatter add-on. It requires core `responsive_image`
and provides a config schema for the third-party setting.

---

- Preload above-the-fold hero images rendered with the Responsive Image formatter to cut LCP.
- Emit `<link rel=preload as=image>` with a correct `imagesrcset` matching the responsive image style.
- Preload a node's banner/teaser image without hand-writing head tags in a template or preprocess hook.
- Improve Core Web Vitals (LCP) scores on content-heavy landing pages.
- Preload the right derivative per breakpoint using the responsive image style's `sizes` mappings.
- Preload art-directed images that use per-breakpoint `image_style` mappings and multipliers.
- Attach the correct `media` query to each preload so browsers pick the matching source.
- Attach `imagesizes` so the browser selects the correct candidate before layout.
- Enable/disable preloading per view mode (e.g. only on full page, not teaser) via the display component.
- Preload images on any fieldable entity (node, media, block content, etc.) using the responsive formatter.
- Turn preloading on for one field's formatter with a single checkbox in Manage display.
- Avoid preloading everywhere (which hurts performance) by scoping it to specific display components.
- Show a "Preloads will be generated" note in the formatter settings summary for site builders.
- Preload media-library-referenced images shown through a responsive image style.
- Provide preload hints for CDN-served image derivatives (URLs come from the file URL generator).
- Combine with lazy-loading of below-the-fold images: preload only the hero, lazy-load the rest.
- Keep preload markup in sync automatically when the responsive image style or breakpoints change.
- Use the `responsive_image_preload.preload_generator` service directly in custom code to build preloads.
- Support multi-value image fields — one preload set is generated per delta/file.
- Drop-in performance win with no configuration UI to learn.
