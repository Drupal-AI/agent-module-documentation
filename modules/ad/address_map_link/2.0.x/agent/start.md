<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Map Link — agent index

Adds formatter settings to core **Address** fields that turn a displayed address into a link to an
external map service. No field type, no widget, no settings form, no configure route (`configure: null`),
no permissions, no Drush. Depends on `address`. Its only persistent state is **third-party settings on
the address field's component in an `entity_view_display`** config entity.

- **Enable the map link on an address field / settings keys / where stored / provider ids** →
  [configure/formatter.md](configure/formatter.md)
- **The MapLink plugin type — add your own provider** → [plugins/map-link.md](plugins/map-link.md)
- **Build a map URL from an address in code (`plugin.manager.map_link`)** → [api/service.md](api/service.md)

Key facts:
- Setting path: `core.entity_view_display.<entity>.<bundle>.<view_mode>` →
  `content.<field>.third_party_settings.address_map_link.{link_address,map_link_type,map_link_position,map_link_text,map_link_new_window}`.
- Ships 10 providers: `google_maps`, `google_maps_directions`, `apple_maps`, `bing_maps`,
  `here_wego_maps`, `mapquest`, `openstreetmap`, `yandex_maps`, `waze_directions`, `waze_navigate`.
- Only applies to fields of type `address`; rendered via `hook_preprocess_field()`.
