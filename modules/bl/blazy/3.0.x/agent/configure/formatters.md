# Blazy field formatters

Blazy ships field formatters (in `src/Plugin/Field/FieldFormatter/`) selectable on
**Manage display** for image/media/entity fields. Choose one, then configure via the formatter
settings summary form (`blazy.admin.formatter`).

Formatters:
- `BlazyImageFormatter` — image fields, lazy + responsive + grid + lightbox.
- `BlazyMediaFormatter` / `BlazyOEmbedFormatter` — media entities and remote video/oEmbed.
- `BlazyFileSvgFormatter*` — SVG images/inline SVG.
- `BlazyEntityFormatter` — entity-reference cards with lazy media.
- `BlazyTextFormatter`, `BlazyTitleFormatter` — text/title alongside media in grids.

Common settings keys (also global defaults in `config/install/blazy.settings.yml`):
- `image_style` / `responsive_image_style` — which image style(s) to serve.
- `media_switch` — lightbox/switcher (e.g. `blazy` box, or a lightbox from another module).
- `grid`, `grid_medium`, `grid_small` — columns per breakpoint for grid display.
- `ratio` — aspect-ratio box (fluid/fixed) to prevent layout shift.
- `background`, `loading` (`lazy`/`eager`/`defer`), `preload`, `blur` — lazy/LQIP behavior.

Global engine settings (Blazy UI, `blazy.settings`): `blazy.offset`, `blazy.loadInvisible`,
`io.rootMargin`, `io.threshold`, `fx` (blur effect), `one_pixel`, `placeholder`,
`use_oembed`, `privacy_consent`. See the [Blazy UI](../../../blazy_ui/3.0.x/agent/start.md) submodule.

Config is exportable per view/field display like any `core.entity_view_display.*` config.
