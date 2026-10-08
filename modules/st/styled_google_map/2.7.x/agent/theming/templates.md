<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — templates & theme hooks

`styled_google_map_theme()` registers two theme hooks (templates in the module's
`templates/`, overridable in your theme):

- **`styled_google_map`** — the map container. Variables: `location`, `settings` (the full
  map-settings array passed to JS via `drupalSettings`), `entity`, `gid` (unique map id),
  `directions_form`, `steps`. `styled_google_map_preprocess_styled_google_map()` builds the
  render array, attaches the `styled_google_map/styled-google-map` library and the map
  settings, and (when directions are enabled) adds the `styled_google_map_directions` element.
- **`styled_google_map_directions`** — the directions widget. Variables: `settings`
  (`enabled`, `type` default `DRIVING`, `steps`) and `id`.

To customise the map markup, copy the template into your theme as
`styled-google-map.html.twig` (or `styled-google-map-directions.html.twig`) and clear caches.
Most visual styling, though, is driven by the JSON map **style** setting and the info-bubble
options (see [../configure/field-formatter.md](../configure/field-formatter.md)), not the Twig template.

The actual map behaviour lives in `js/styled-google-map.js`, driven entirely by the
`settings` array; overriding the JS is rarely needed — prefer the display/Views options and
`hook_styled_google_map_views_style_alter()`.
