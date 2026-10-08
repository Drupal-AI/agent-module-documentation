# Sitemap — theming

Theme hooks registered in `sitemap_theme()` (preprocessors in `sitemap.theme.inc`).
Templates live in `templates/`.

| Template | Theme hook | Purpose |
|---|---|---|
| `sitemap.html.twig` | `sitemap` | The whole sitemap page wrapper |
| `sitemap-item.html.twig` | `sitemap_item` | A single section/item wrapper |
| `sitemap-menu.html.twig` | `sitemap_menu` | Rendered menu tree |
| `sitemap-taxonomy-term.html.twig` | `sitemap_taxonomy_term` | A taxonomy term line |
| `sitemap-frontpage-item.html.twig` | `sitemap_frontpage_item` | Front-page section item |
| `sitemap-feed-icon.html.twig` | `sitemap_feed_icon` | RSS feed icon |

Preprocessors: `template_preprocess_sitemap_item()`,
`template_preprocess_sitemap_taxonomy_term()`,
`template_preprocess_sitemap_frontpage_item()`, plus `_sitemap_rss_feed_icon()` helper.

Theme-suggestion hooks (override per-item / per-menu):
- `sitemap_theme_suggestions_sitemap_item()`
- `sitemap_theme_suggestions_menu_alter()`

Styling: the `sitemap.theme` library (`css/sitemap.theme.css`) is loaded when
`include_css` is true ([../configure/settings.md](../configure/settings.md)); disable it
to fully control styles in your theme. Copy any template into your theme to override.
