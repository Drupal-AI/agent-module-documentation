# Theming the map output

The formatter renders through a single theme hook, so you can fully control the markup.

## Theme hook

`simple_gmap_output` — declared in `simple_gmap_theme()` (`simple_gmap.module`), template
`simple-gmap-output.html.twig`. Override it by copying the template into your theme and clearing
caches (`drush cr`), or implement a `theme_suggestions`/preprocess hook.

## Available variables

Passed from `SimpleGMapFormatter::viewElements()`:

| Variable | Meaning |
|---|---|
| `include_map` | Render the embedded **dynamic** map iframe. |
| `include_static_map` | Render the embedded **static** map image. |
| `include_link` | Render the link to Google Maps. |
| `include_text` | Render the original address text. |
| `iframe_width` / `iframe_height` | Map dimensions. |
| `iframe_title` | iframe title attribute (with `[address]` already substituted). |
| `static_scale` | 1 or 2 (Retina) for the static image. |
| `url_suffix` | URL-encoded address, used in every Google URL. |
| `zoom` | Zoom level (int). |
| `link_text` | Link text to display. |
| `address_text` | Address text (empty when not shown). |
| `map_type` | Google map-type code (`m`/`k`/`h`/`p`). |
| `langcode` | Two-letter language code. |
| `static_map_type` | Static-map type name (`roadmap`/`satellite`/`hybrid`/`terrain`). |
| `apikey` | Google Maps API key (static map only). |
| `alt_text` | Alt text for the static image (with `%address` substituted). |

## Default markup (what to override)

- Dynamic map: an `<iframe>` pointing at `https://www.google.com/maps/embed?...` (map type `k`
  toggles satellite via `5e`).
- Static map: `<div class="simple-gmap-static-map"><img src="https://maps.googleapis.com/maps/api/staticmap?...key={{ apikey }}"></div>`.
- Link: `<p class="simple-gmap-link"><a href="https://www.google.com/maps?q=..." target="_blank">…</a></p>`.
- Text: `<p class="simple-gmap-address">{{ address_text }}</p>`.

Override the Twig to change classes, wrap elements, add lazy-loading, or restructure the map/link/text
order.
