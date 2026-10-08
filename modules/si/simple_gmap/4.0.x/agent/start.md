# simple_gmap — agent start

Provides one field formatter, `simple_gmap` ("Google Map from one-line address"), that renders a
plain-text address field as an embedded Google Map iframe, a static map image, a link to Google
Maps, and/or the raw address text. No field type, no permissions, no admin settings page — you apply
it per-display on **Manage display** (or as a Views field). Applies to `string`, `string_long`,
`computed`, `computed_string` field types. Depends on core `field` + `text`. The dynamic iframe map
and the map link need no API key; only the static map does.

- Apply the formatter and configure its settings (zoom, map type, size, dynamic/static/link, API key) → [configure/simple_gmap.md](configure/simple_gmap.md)
- Override the map output template / theme hook → [theming/simple_gmap.md](theming/simple_gmap.md)
