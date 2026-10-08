<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Streamlike oEmbed

Route `streamlike_oembed.settings_form` → `/admin/config/media/streamlike-oembed`, permission `administer streamlike_oembed configuration`. Config object `streamlike_oembed.settings`.

- `discover_media_id_source` — newline-separated `route_name|field_name` pairs, e.g.:
  ```
  entity.node.canonical|field_streamlike_video
  entity.taxonomy_term.canonical|field_video_id
  ```

Runtime (`StreamlikeOembed::getMediaId`): only fires when the current route is an `entity.*.canonical` route; matches the route against the source list, loads the page's main entity, and returns the mapped field's media ID. For a field of type `vpx_media_field` it returns `->emid`; otherwise the field's `->value`. `isValidMediaId()` expects a 16-character string.
