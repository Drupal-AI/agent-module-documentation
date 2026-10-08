# Responsive Image Preload — agent index

Adds a `generate_preloads` boolean third-party setting to the core `responsive_image` field
formatter. When on, the module emits `<link rel="preload" as="image">` head tags (with
`imagesrcset`/`imagesizes`/`media`) for that field's images to improve LCP. No admin page
(`configure` null), no permissions, no Drush, no plugins. Depends on core `responsive_image`.

- **How to enable per display, the service pipeline, and the generated markup** →
  [configure/preload.md](configure/preload.md)

Key facts:
- Enable it in *Manage display* → the `responsive_image` formatter's settings cog → check
  **Generate preloads** (stored as component `third_party_settings.responsive_image_preload.generate_preloads`).
- Services: `responsive_image_preload.preload_generator` (`PreloadGenerator`),
  `.third_party_settings`, `.field_preprocessor`.
- `hook_preprocess_field()` → `FieldPreprocessor::preprocessField()` reads the display component flag
  and, if set, attaches generated preloads to `#attached['html_head']`.
- Config schema: `field.formatter.third_party.responsive_image_preload` (only `generate_preloads`).
