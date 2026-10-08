# Blazy text filter

`Drupal\blazy\Plugin\Filter\BlazyFilter` (id `blazy_filter`) lazy-loads and optionally
lightboxes images/iframes embedded in formatted text (body, CKEditor).

Enable at **Admin → Config → Content authoring → Text formats and editors** → pick a format →
enable **Blazy** filter. Order it after other image/media filters.

Usage in content:
- Plain `<img data-image-style="large" src="…">` or `[data-entity-uuid]` media get lazy-loaded.
- Add a `data-grid="4 3 2"` / shortcode wrapper to lay images out in a responsive grid.
- Set the filter's lightbox option to make embedded images open in the `blazy` box (or another
  lightbox module's box) — see `media_switch` in the filter settings.

Filter classes live in `src/Plugin/Filter/` (`BlazyFilter`, `Shortcode`, `AttributeParser`);
tips are in `FILTER_TIPS.md`. Config schema: `filter_settings.blazy_filter` in
`config/schema/blazy.schema.yml`.
