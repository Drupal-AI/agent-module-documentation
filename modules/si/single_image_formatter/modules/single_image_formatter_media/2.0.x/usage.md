Submodule of Single Image Formatter that renders only the first value of a multi-valued media reference field using core's media thumbnail formatter.

---

Provides one field formatter, `single_media_formatter` (label "Single media thumbnail"), that extends core `MediaThumbnailFormatter` and overrides `getEntitiesToView()` to return only the first referenced item. It applies to `entity_reference` fields (media reference fields) and inherits all media-thumbnail settings (image style, link to content/media); its config schema reuses `field.formatter.settings.media_thumbnail`. Requires the core `media` module. Select it on **Manage display**. No settings page, permissions, or code API of its own.

---

- Show only the first referenced media item's thumbnail in a multi-value media field.
- Display a single lead media thumbnail in a teaser while storing several references.
- Render one representative media image per node in a listing.
- Keep a "primary media" convention (first delta) without limiting field cardinality.
- Link the single media thumbnail to content or to the media entity via inherited settings.
- Apply an image style to just the first media reference.
- Provide a consistent single-media thumbnail for card/grid layouts.
- Show one product media thumbnail in a catalog listing.
- Drive a search-result thumbnail from the first media reference.
- Reuse a multi-media field for both a gallery and a single-thumbnail display across view modes.
- Present the lead media of a media-set field for social/preview contexts.
- Replace a dedicated single media-reference field with a first-value formatter.
- Show one avatar/logo from a repeatable media reference field.
- Standardize single-media display across templates without extra fields.
- Fall back to the first media item's thumbnail for gallery fields.
