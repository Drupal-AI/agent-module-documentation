<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Content Blocker - Media — agent index

Blocks remote **oEmbed** media until cookie consent, per provider. Submodule of
`cookie_content_blocker` (+ core `media`, `image`). `configure` =
`cookie_content_blocker_media.settings`. No permissions of its own (reuses parent's
`administer cookie content blocker`), no plugin types; provides a config schema and one field
formatter.

- **Per-provider settings form + the `cookie_content_blocker_oembed` formatter** →
  [configure/media.md](configure/media.md)

Key facts:
- Formatter `cookie_content_blocker_oembed` extends core `media` OEmbedFormatter; for `link`,
  `string`, `string_long` fields.
- Blocking is decided by `provider_name` looked up against `cookie_content_blocker_media.settings`
  `providers.<provider>.blocked`; blocked items get `#cookie_content_blocker` (see parent
  `api/blocking.md`).
- Optional preview thumbnail via image style (`blocked_media_teaser` installed by default).
