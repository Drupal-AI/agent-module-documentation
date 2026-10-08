Adds field formatters that render only the **first** value of a multi-valued image/media/entity-reference field, so you can keep several values on an entity but display just one (e.g. a teaser/hero) without changing field cardinality.

---

The base module provides one field formatter plugin, `single_image_formatter` (label "Single image formatter"), that extends core's `ImageFormatter` and overrides `getEntitiesToView()` to `reset()` the loaded file list and return at most the first item. All the normal image-formatter settings (image style, link to content/file, loading attribute) are inherited unchanged, and its config schema simply reuses `field.formatter.settings.image`. You select it on an entity's **Manage display** tab for any `image` field. Two optional submodules apply the same "first value only" trick to other display types: `single_image_formatter_responsive` (formatter `single_responsive_image_formatter`, extends core `ResponsiveImageFormatter`, needs `responsive_image`) and `single_image_formatter_media`, which ships two formatters — `single_media_formatter` (extends core `MediaThumbnailFormatter`) and `single_entity_formatter` (extends core `EntityReferenceEntityFormatter` for a "Single rendered entity" display), both needing `media`. In 2.1.x the media thumbnail formatter can optionally render the original image from the media source field through a chosen responsive image style (via a `<picture>` element) instead of the thumbnail. Requires Drupal core 10.2+ (also 11/12) and PHP 8.1+. There is no settings page, no permissions, and no code API beyond the plugins — the module is a set of tiny formatter subclasses.

---

- Show only the first image of a multi-value gallery field in a teaser/card view.
- Display a single hero image from a field that editors can populate with several images.
- Render one representative thumbnail per node in a listing without limiting field cardinality.
- Keep a "primary image" convention (first delta) while storing many images on the entity.
- Use a responsive image style but render just the first image via the responsive submodule.
- Show the first referenced media item's thumbnail via the media submodule.
- Render the first referenced media item's original image through a responsive image style instead of its thumbnail.
- Render only the first referenced entity with a chosen view mode via "Single rendered entity".
- Avoid a separate single-value field just to have a "main" image.
- Apply an image style to only the first image in different view modes (full vs teaser).
- Link the single displayed image to the content or to the file, using inherited formatter settings.
- Build a grid/list where each row shows one image drawn from a multi-image field.
- Present the lead photo of a photo-set field in search results.
- Drive an Open Graph / social preview from the first image of a multi-value field.
- Reuse the same multi-image field for both a gallery (all images) and a card (first image) across view modes.
- Show a single product image in a catalog listing while the product stores many.
- Render the first slide image as a static fallback for a slideshow field.
- Display one avatar/logo from a repeatable image field.
- Provide a consistent single-image thumbnail for media reference fields.
- Swap in the responsive single-image formatter for art-directed, breakpoint-aware first-image display.
