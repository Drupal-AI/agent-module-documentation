# Podcast theming — templates, theme hooks, preprocess

## Theme hooks

`podcast_theme()` registers two hooks, each a variant of a core Views RSS template:

| Hook | `base hook` | Template file |
|---|---|---|
| `views_view_rss_podcast_feed` | `views_view_rss` | `templates/views-view-rss-podcast-feed.html.twig` |
| `views_view_row_rss_podcast_feed` | `views_view_row_rss` | `templates/views-view-row-rss-podcast-feed.html.twig` |

They are selected automatically by the style (`theme = "views_view_rss_podcast_feed"`) and
row (`theme = "views_view_row_rss_podcast_feed"`) plugins — you do not wire them up.
Override by copying the template into your theme and clearing cache.

## Preprocess behaviour (`podcast.module`)

- `podcast_preprocess_views_view_rss(&$variables)` — only acts when the style is the
  podcast `Rss` plugin. Unsets core `title`/`description`/`link` and builds
  `$variables['podcast_elements']` from `$style->podcastElements`. Each element's
  `attributes` array is wrapped in a Twig `Attribute` object; elements with nested
  `values` (no scalar `value`) are serialized to markup by
  `podcast_process_nested_channel_element()` (which emits `<key attr...>content</key>` or a
  self-closing tag) and stored back in `value`.
- `podcast_preprocess_views_view_row_rss(&$variables)` — for the podcast row, unsets core
  `link`/`description` (the plugin emits its own).
- `podcast_preprocess_views_view_field(&$variables)` — when the style is the podcast `Rss`
  plugin, wraps the output of fields mapped to `description` or `itunes:summary`
  (matched via the style/row option keys) in `<![CDATA[ ... ]]>` using
  `ViewsRenderPipelineMarkup`, so HTML bodies/summaries are valid inside the feed.

## The `podcast_elements` variable (for template overrides)

Each entry passed to the channel template is a keyed array:
- `key` — the XML tag name (e.g. `itunes:image`, `generator`, `podcast:funding`).
- `value` — scalar content or pre-serialized `Markup` for nested elements.
- `attributes` — a Twig `Attribute` object (may be empty).

Iterate `podcast_elements` in the channel template to render each tag; the row template
renders the item `elements` array built by `RssFields::render()` the same way core does.
No CSS/JS libraries are involved — output is XML only.
