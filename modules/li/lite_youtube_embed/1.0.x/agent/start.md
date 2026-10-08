# Lite YouTube embed — agent index

Adds one field **formatter**, `lite_youtube_embed` ("Lite YouTube embed (with oEmbed fallback)"),
that renders YouTube videos with Paul Irish's `lite-youtube` web component (a click-to-load facade)
and falls back to the core oEmbed iframe for non-YouTube providers. Depends on `media`. No configure
route (`configure: null`), no permissions, no Drush.

- **Select the formatter, where it applies, its settings, and the required JS library** →
  [configure/formatter.md](configure/formatter.md)
- **The `lite_youtube_embed` theme hook + Twig (`<lite-youtube>` web component)** →
  [theming/template.md](theming/template.md)

Key facts: the formatter is only offered on **media** entity fields whose media type uses an
**oEmbed** source (`isApplicable()`), for `link`/`string`/`string_long` field types. It is stored as
the component `type` in a `core.entity_view_display.media.<bundle>.<mode>` config entity. The
`lite-youtube` JS/CSS must be installed into `/libraries/lite-youtube-embed/src` — it is **not**
bundled. Settings `max_width`/`max_height` apply only to the non-YouTube fallback.
