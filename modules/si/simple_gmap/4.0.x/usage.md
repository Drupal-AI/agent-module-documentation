Simple Google Maps adds a field formatter that renders a plain-text (address) field as an embedded Google Map iframe, a static map image, a link to Google Maps, or any combination — with no field of its own and no API/JavaScript needed for the basic iframe map.

---

Simple Google Maps is deliberately minimal: it defines a single field formatter (`simple_gmap`, labelled "Google Map from one-line address") and nothing else — no custom field type, no field validation, no permissions, no admin settings page. You add an ordinary core Text field (`string` or `string_long`, also `computed`/`computed_string`) to a content type, enter a one-line or multi-line address that Google Maps can recognize (e.g. `100 Madison Ave, New York, NY`), then on **Manage display** (or in a View) choose this formatter for the field. Per-display formatter settings let you toggle an embedded dynamic map (iframe), an embedded static map image, a link to a Google Map, and the original address text — independently. You control the iframe width/height (px or percent) and iframe title (for screen readers, with an `[address]` token), the zoom level (1–20, default 14, shared by embedded and linked maps), the map type (Map/`m`, Satellite/`k`, Hybrid/`h`, Terrain/`p`), the link text (or `use_address` to reuse the address), the language code (a two-letter code or `page` for the current page language), and required alt text (`%address` token). The dynamic iframe map and the map link require no Google Maps API key; only the static map image needs one (set via the `apikey` setting). Settings are stored per view-mode display and export as configuration (schema `field.formatter.settings.simple_gmap`). The output is themeable via the `simple_gmap_output` theme hook / `simple-gmap-output.html.twig` template.

---

- Show a Google Map of a business or event address on a content type's display.
- Turn a plain single-line Text field holding `100 Madison Ave, New York, NY` into an embedded map.
- Use a long-text field to hold a multi-line address and render it as a map.
- Display an embedded dynamic Google Maps iframe with no API key required.
- Display a static Google Map image (PNG) instead of an interactive iframe.
- Provide an API key so static maps render (static maps do not work without one).
- Render only a text link to Google Maps ("View larger map") rather than an embedded map.
- Show the map, a link, and the original address text all at once by toggling each option.
- Set the embedded map size in pixels (e.g. `600px`) or percent (e.g. `100%`).
- Size a static map in bare pixels (e.g. `600`) as the Static Maps API requires.
- Add an iframe title for accessibility, injecting the address via the `[address]` token.
- Provide required alt text for the static map image, injecting the address via `%address`.
- Choose the zoom level (1 minimum to 20 maximum, default 14) for embedded and linked maps.
- Switch the map type to Satellite, Hybrid, or Terrain instead of the default road Map.
- Use the address itself as the link text by setting link text to `use_address`.
- Localize the map by entering a two-letter language code Google Maps recognizes.
- Follow the current page language automatically by setting the language to `page`.
- Load a Retina (2x) static map image for high-density displays via the static scale option.
- Apply the formatter to a field displayed inside a View (as a Views field).
- Add a location map to nodes, users, taxonomy terms, or any fieldable entity with a text field.
- Export the per-display formatter settings as configuration and deploy between environments.
- Override the map markup by overriding the `simple-gmap-output.html.twig` template.
- Avoid installing a heavyweight geo/mapping stack when you just need a simple embedded map.
- Give editors a single plain address field while automatically rendering a map from it.
- Show a driving-directions style link that opens the address in Google Maps in a new tab.
