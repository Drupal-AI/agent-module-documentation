<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Address Map Link adds formatter settings to core Address fields so a displayed address can be turned into a link that opens an external mapping service (Google Maps, Apple Maps, Waze, OpenStreetMap, and more).

---

The module has no field type, widget, settings form, or configure route of its own. It extends the display of `address` (Address module) fields through `hook_field_formatter_third_party_settings_form()`: on any address field's *Manage display* formatter settings you get a "Link Address to Map" checkbox plus a map provider selector, link position, custom link text, and an "open in new window" toggle. These are stored as third-party settings on the field's component in the `entity_view_display` config entity (`third_party_settings.address_map_link.*`). At render time `hook_preprocess_field()` builds a URL for each address item using the chosen **MapLink plugin** and wraps or appends it to the rendered address. MapLink is a plugin type the module defines (manager service `plugin.manager.map_link`, annotation `@MapLink`, base class `MapLinkBase`); ten providers ship out of the box — `google_maps`, `google_maps_directions`, `apple_maps`, `bing_maps`, `here_wego_maps`, `mapquest`, `openstreetmap`, `yandex_maps`, `waze_directions`, `waze_navigate` — each implementing `getAddressUrl(AddressInterface): Url`. Link position can be the address itself, before it, or after it; the link text supports tokens when the Token module is enabled. The same `plugin.manager.map_link` service can be called programmatically to build a map URL from an address anywhere (e.g. in a preprocess or `hook_ENTITY_TYPE_view()`), independent of the field formatter.

---

- Turn a business's Address field into a clickable Google Maps link on its node page.
- Give visitors a "Get directions" link that opens Waze or Google Maps Directions pre-filled with the address.
- Start turn-by-turn navigation immediately with the Waze - Navigate provider from a mobile page.
- Offer Apple Maps links (with automatic Google fallback for non-iOS users).
- Use OpenStreetMap for a privacy-friendly, no-account mapping link.
- Localize mapping to Yandex Maps for a Russian-language audience.
- Place the map link before or after the address text instead of linking the address itself.
- Provide custom link text such as "View on map" or "Open directions".
- Insert dynamic link text using tokens (e.g. the entity title) when Token is enabled.
- Open the map in a new browser tab so visitors don't lose the page.
- Show a store-locator list where every address links to its map.
- Add a directions link to event locations on a calendar/listing view.
- Link property/real-estate listing addresses to a chosen map provider.
- Point restaurant or venue addresses to Bing Maps or MapQuest per client preference.
- Configure a different provider per view mode (e.g. teaser vs full) via each display's third-party settings.
- Build a map URL in custom code with `plugin.manager.map_link` → `createInstance('google_maps_directions')->getAddressUrl($address)`.
- Add a new mapping provider by writing a `@MapLink` plugin in `Plugin/MapLink`.
- Expose a "directions_url" variable in a node template from an address field programmatically.
- Keep stored address values untouched — the module only affects the rendered display.
- Standardize the map provider across many content types by setting each address formatter's third-party settings.
- Export the configuration (`third_party_settings.address_map_link`) with your `entity_view_display` config for deployment.
