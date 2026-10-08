# iFrame Title Filter — agent index

Adds a `title` to title-less `<iframe>`s for WCAG compliance, via a text-format filter and a Media
oEmbed preprocess hook. No global config (`configure` null), no permission, no schema, core-only.

- **Enable & order the `filter_iframe_title` text filter, and the Media oEmbed integration** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Filter plugin `filter_iframe_title` (`Plugin/Filter/FilteriFrameTitle`), `TYPE_TRANSFORM_REVERSIBLE`,
  weight 100. Sets title = "Embedded content from `<host from src>`" on iframes with no `title`.
- Enable per text format at `/admin/config/content/formats`; place **after** HTML/iframe-generating
  filters (Media, video_filter).
- `src/Hook/IframeTitleFilterHooks`: `hook_preprocess_media_oembed_iframe()` titles core Media oEmbed
  iframes (resource title, else provider name) + theme suggestion
  `media_oembed_iframe__iframe_title_filter`.
