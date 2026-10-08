Image Replace provides an image style **effect** that swaps the whole source image for a different one when a given image style is rendered — enabling "art direction" where a responsive variant needs a completely different image, not just a crop or resize.

---

Depends on core `image`. You add the **Replace image** effect (`image_replace`) to an image style; then, on any image **field's** configuration edit form, an "Image replace" fieldset lets you map each replace-enabled style to another image field on the same bundle (the "source field"). When an entity is saved, `hook_entity_presave` reads those per-field maps, resolves the target and source image URIs, and stores rows in a custom `{image_replace}` table keyed by `target_style` + a SHA-256 hash of the target URI, with the replacement URI. At derivative-generation time the effect's `applyEffect()` looks up `(style, source-uri)` in that table via the `image_replace.storage` service; if a replacement exists it loads it through the `ImageFactory` and applies the toolkit `image_replace` operation, which swaps the underlying image resource — a GD implementation and an ImageMagick implementation are both provided. On save the module also flushes affected derivatives (`image_path_flush`). Config schema is provided for both the effect (`image.effect.image_replace`, storing the style name) and the field third-party setting (`image_style_map` → `source_field`). There is no global settings page (`configure` null), no permissions, and no Drush commands. A validation warning reminds admins to re-save existing content (and that browser/HTTP caches may still hold old derivatives) whenever the mapping changes.

---

- Swap a hero image for a differently-composed version when rendered at a mobile image style.
- Deliver art-directed responsive images where cropping/resizing is not enough.
- Replace a wide desktop banner with a portrait-oriented image for small screens.
- Provide a text-baked graphic variant per breakpoint via distinct image styles.
- Map a "mobile" image field as the source for a mobile-sized style on a content type.
- Use with core Responsive Image module: each style in the mapping can pull a different source.
- Show a simplified logo/graphic at thumbnail sizes and the full artwork at large sizes.
- Keep the primary image field authoritative while offering optional per-style overrides.
- Let editors upload an alternate image in a second field that automatically replaces the main one for chosen styles.
- Fall back to the original image automatically when no replacement is mapped or uploaded.
- Support both GD and ImageMagick toolkits with the shipped replace operations.
- Rebuild replacement mappings in bulk by re-saving content (e.g. VBO "save" action) after changing the config.
- Flush stale derivatives automatically when an entity with mapped fields is saved.
- Store replacement lookups efficiently via a hashed-URI keyed table.
- Programmatically query/add/remove replacements through the `image_replace.storage` service.
- Configure which styles are "replace-enabled" simply by adding the Replace effect to them.
- Give different image fields on the same bundle a source/target relationship for specific styles.
- Warn editors that CDN/browser caches may need busting after swapping images.
- Build device-specific marketing imagery pipelines without custom image-effect code.
- Combine multiple mapped styles on one field, each pulling from its own source field.
