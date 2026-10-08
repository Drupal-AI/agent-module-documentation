Universal Media formatter adds a single field formatter (`universal_media`) for entity-reference fields that target Media, rendering each referenced media item through a chosen **responsive image style** directly from the referencing entity — no per-image-style media view mode required.

---

The module registers one field formatter, **Universal Media formatter** (`universal_media`),
available on any entity-reference field whose target type is `media`. Instead of creating a
separate media view mode per image style, you pick a **responsive image style** (and optional
link, loading, fetchpriority, width/height, aspect-ratio, border-radius, and fallback view mode)
right in *Manage display*. For each referenced media item it pulls the media's `thumbnail` file,
copies the source field's `alt` text onto it, and renders JPEG/PNG thumbnails via the
`responsive_image_formatter` theme and SVGs via the `image_formatter` theme. When the thumbnail
is the generic video icon it falls back to rendering the media entity in its default view mode.
It extends core's `ImageFormatterBase`, checks `view` access on each referenced media, and adds
proper cache tags for the responsive image style, image styles, and media entities. Requires the
core **Media** and **Responsive Image** modules. There is no global config, permissions, schema,
or Drush — all settings are per formatter instance on a display.

---

- Show a media reference field as a responsive image without a dedicated media view mode.
- Render an image-media reference at a specific responsive image style.
- Display media thumbnails in a card/teaser using one image style setting.
- Inline SVG media (rendered via the image formatter, bypassing image styles).
- Fall back to the default media view mode for video media (renders the video, not a still).
- Set native `width`/`height` attributes on the rendered image.
- Apply `loading="lazy"` (or eager) to media images for performance.
- Set `fetchpriority` high/low on above-the-fold or background media.
- Apply a CSS `aspect-ratio` to keep media placeholders stable.
- Round media corners with a `border-radius` setting.
- Link the media image to its host content or to the media item.
- Reuse the referenced media's alt text from the source field automatically.
- Standardize image rendering across many bundles with one formatter.
- Avoid view-mode sprawl when you need the same media at several sizes.
- Respect media `view` access so unpublished/restricted media isn't leaked.
- Keep responsive `srcset`/`sizes` output via core responsive image styles.
- Provide art-directed responsive images for editorial media fields.
- Configure a fallback view mode for non-image media types.
- Ensure correct cache invalidation when an image style or media item changes.
- Replace custom preprocess/twig hacks that rendered media thumbnails by hand.
