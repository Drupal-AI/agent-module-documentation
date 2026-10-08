# TacJS Media — agent index

Submodule of TacJS. Provides one consent-aware oEmbed field formatter so remote videos load only
after tarteaucitron consent. No config, no schema, no permissions.

- **The `tacjs_oembed` formatter: how to select it and what it renders** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter plugin id `tacjs_oembed`, label "oEmbed content (TacJS integration)", class
  `TacJSOEmbedFormatter extends OEmbedFormatter`; field types `link`, `string`, `string_long`.
- Selected on a field's *Manage display*; stored in the `entity_view_display` config as the
  component `type: tacjs_oembed`.
- Requires `tacjs` + core `media`; also enable the matching TacJS service (youtube/vimeo/dailymotion).
