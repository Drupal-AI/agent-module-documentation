<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Inline Frame — agent index

Adds one Media **source plugin**, `inline_frame` ("Inline frame"), whose source field is an
`iframe` URL field. No settings form, no `configure` route, no permissions, no Drush, no
plugin types of its own. Depends on `media` + the contrib `iframe` field module.

- **Create/inspect an iframe media type; source field name, formatter, media-library add form** →
  [configure/media-source.md](configure/media-source.md)

Key facts:
- Plugin: `@MediaSource(id="inline_frame", allowed_field_types={"iframe"})` in
  `src/Plugin/media/Source/InlineFrame.php`.
- Source field default name `field_media_inline_frame`, type `iframe`, label "Inline Frame URL".
- View display is prepared with the `iframe_default` formatter (label `visually_hidden`).
- Media Library add form (`media_library_add_iframe`) shows one "Iframe URL" input.
- Config schema `media.source.inline_frame` (`media.source.field_aware`); default thumbnail `iframe.png`.
