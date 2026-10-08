Submodule of Single Image Formatter that renders only the first value of a multi-valued entity/media reference field — either as a media thumbnail (optionally through a responsive image style) or as a rendered entity.

---

Provides two field formatters. `single_media_formatter` (label "Single media thumbnail") extends core `MediaThumbnailFormatter` and overrides `getEntitiesToView()` to keep only the first referenced item; in 2.1.x it adds an optional `responsive_image_style` setting — when chosen, it renders the original image from the media source field through that responsive image style (a `<picture>` element) instead of the thumbnail, otherwise it behaves exactly like the core thumbnail formatter. `single_entity_formatter` (label "Single rendered entity") extends core `EntityReferenceEntityFormatter` and renders only the first referenced entity using the configured view mode. Both apply to `entity_reference` fields and require the core `media` module; the responsive-thumbnail option additionally needs the core `responsive_image` module (its presence is checked at runtime). Config schemas reuse `field.formatter.settings.media_thumbnail` (with the added `responsive_image_style` mapping) and `field.formatter.settings.entity_reference_entity_view`. Select either on **Manage display**. No settings page, permissions, or code API of its own.

---

- Show only the first referenced media item's thumbnail in a multi-value media field.
- Render the first media item's original source image through a responsive image style instead of its thumbnail.
- Render only the first referenced entity with a chosen view mode via "Single rendered entity".
- Display a single lead media thumbnail in a teaser while storing several references.
- Render one representative media image per node in a listing.
- Keep a "primary media" convention (first delta) without limiting field cardinality.
- Link the single media thumbnail to content or to the media entity via inherited settings.
- Apply an image style to just the first media reference.
- Serve art-directed / breakpoint-aware output for the first media item's source image.
- Provide a consistent single-media thumbnail for card/grid layouts.
- Show one product media thumbnail in a catalog listing.
- Drive a search-result thumbnail from the first media reference.
- Reuse a multi-media field for both a gallery and a single-thumbnail display across view modes.
- Present the lead media of a media-set field for social/preview contexts.
- Replace a dedicated single media-reference field with a first-value formatter.
- Show one avatar/logo from a repeatable media reference field.
- Render the first referenced node/entity as a teaser without limiting cardinality.
- Standardize single-media display across templates without extra fields.
- Fall back to the first media item's thumbnail for gallery fields.
