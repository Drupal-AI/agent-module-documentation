<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Streamlike oEmbed provides oEmbed-style integration for Streamlike: on an entity canonical page it discovers the relevant Streamlike media ID from a configured route/field mapping and embeds the Streamlike player.
---
The `StreamlikeOembed` service (`streamlike_oembed.main`) only acts on entity canonical routes. It reads the admin-configured `discover_media_id_source` list (newline-separated `route_name|field_name` pairs) from `streamlike_oembed.settings`, matches the current route, loads the page's main entity, and returns the value of the mapped field — handling the `vpx_media_field` type specially (`->emid`) and falling back to the field's plain `value`. Helper methods provide the entity's title (`getMediaTitle`) and validate a media ID shape (`isValidMediaId` requires a 16-character string). The settings form lives at `/admin/config/media/streamlike-oembed` behind the `administer streamlike_oembed configuration` permission.

There is no anonymous mutation endpoint; the only route is the permission-gated admin form, and discovery is read-only against the current entity. Setup: enable the module, open the settings form, and list the `entity.node.canonical|field_streamlike` (etc.) source mappings that tell the module where to find the media ID for each route.
---
- Configure `discover_media_id_source` mappings at `/admin/config/media/streamlike-oembed`.
- Map `entity.node.canonical|field_name` to a media-ID field.
- Add multiple route|field mappings, one per line.
- Auto-discover the Streamlike media ID on a node's canonical page.
- Embed the Streamlike player from the discovered media ID.
- Support the `vpx_media_field` field type via its `emid`.
- Fall back to a field's plain `value` for the media ID.
- Get the containing entity's title for the embed.
- Validate a media ID is a 16-character string.
- Restrict discovery to entity canonical routes only.
- Grant `administer streamlike_oembed configuration` to media admins.
- Embed Streamlike videos on taxonomy or user canonical pages.
- Reuse an existing media-ID field for oEmbed embedding.
- Combine with streamlike_media field type as the source.
- Skip pages where no source mapping matches.
- Theme the embedded player output.
- Update mappings when field machine names change.
- Verify a route returns the expected media ID.
