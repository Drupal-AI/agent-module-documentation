# Configure the Universal Media formatter

No admin/global config. Enable it per field on **Manage display**.

## Enable

*Structure → (content type / entity) → Manage display* (or a view mode). For an
entity-reference field whose target is **Media**, set **Format** to **Universal Media formatter**
(`universal_media`), then open the settings gear. The formatter only appears for media-target
reference fields (`UniversalMediaFormatter::isApplicable()`).

## Settings (`defaultSettings()` / `settingsForm()`)

| Setting | Type | Notes |
|---|---|---|
| `responsive_image_style` | select (**required**) | A responsive image style that has image-style mappings. Used for JPEG/PNG. |
| `image_link` | select | Empty / `content` (link to host entity) / `file`. Builds the link via `getMediaThumbnailUrl()`. |
| `loading` | select | `lazy` (default) or `eager` → `loading` attribute. |
| `fetchpriority` | select | `high` / `low` (or auto) → `fetchpriority` attribute. |
| `width`, `height` | number | Native `width`/`height` attributes. |
| `aspect_ratio` | textfield | Emitted as inline `aspect-ratio:<value>` style. |
| `border_radius` | textfield | Emitted as inline `border-radius:<value>` style. |
| `view_mode` | select (**required**) | Fallback media view mode (used for video and passed as `#view_mode`). |

## Render behavior (`viewElements()`)

- Loads each referenced media's `thumbnail` file and copies the source field's `alt` onto it.
- MIME `image/jpeg|jpg|png` → `#theme => responsive_image_formatter` with the chosen responsive
  image style and `#url` from `getMediaThumbnailUrl()`.
- MIME `image/svg+xml` → `#theme => image_formatter` (no image style; SVG served as-is).
- Thumbnail URI `public://media-icons/generic/video.png` (generic video icon) → renders the media
  entity in its **default** view mode instead of a still.
- Access: `checkAccess()` defers to each media's `view` access (via `getEntitiesToView()`), so
  restricted media is not rendered.
- Cacheability: merges cache tags from the responsive image style, its image styles, and each
  media item.

## Dependencies

Requires core **Media** and **Responsive Image**. Define your responsive image styles at
`/admin/config/media/responsive-image-style` before selecting one here.
