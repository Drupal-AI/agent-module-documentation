# Apply & configure the Simple Google Map formatter

There is **no module settings page** (`configure` is null) and no permissions. All configuration is
per field-display, set on the field's formatter.

## Applying the formatter

1. Add a plain **Text** field to an entity bundle. Supported field types: `string` (single-line),
   `string_long` (multi-line), `computed`, `computed_string`. No custom field type is defined.
2. Enter a Google-recognizable address as the field value, e.g. `100 Madison Ave, New York, NY`
   (or a multi-line address in a long-text field). The module does **no** validation of the address.
3. On **Manage display** (`/admin/structure/types/manage/{bundle}/display`) — or when adding the
   field to a View — choose the formatter **"Google Map from one-line address"** (id `simple_gmap`).
4. Click the gear to edit the formatter settings below.

## Formatter settings

Config schema: `field.formatter.settings.simple_gmap` (`config/schema/simple_gmap.schema.yml`).
Stored on the entity view display; exports with `drush config:export`. Defaults from
`SimpleGMapFormatter::defaultSettings()`:

| Setting | Default | Meaning |
|---|---|---|
| `include_map` | `true` | Include an embedded **dynamic** map (iframe). No API key needed. |
| `include_static_map` | `false` | Include an embedded **static** map image. **Requires** `apikey`. |
| `include_link` | `false` | Include a text link to Google Maps (opens in new tab). No API key needed. |
| `include_text` | `false` | Also print the original address text. |
| `apikey` | `''` | Google Maps API key — only used for the static map image. |
| `iframe_width` | `'200'` | Map width. px or percent (`600px`, `100%`); static maps need bare px (`600`). |
| `iframe_height` | `'200'` | Map height, same rules as width. |
| `iframe_title` | `''` | iframe `title` attr for screen readers. `[address]` token → the address value. |
| `static_scale` | `1` | 1 = normal, 2 = Retina (double-size) static image. Static map only. |
| `zoom_level` | `'14'` | Zoom 1 (min) – 20 (max); applies to embedded **and** linked maps. |
| `map_type` | `'m'` | `m` Map, `k` Satellite, `h` Hybrid, `p` Terrain. Embedded + linked. |
| `link_text` | `'View larger map'` | Link text; the literal `use_address` reuses the address as link text. |
| `langcode` | `'en'` | Two-letter Google language code, or the literal `page` for the current page language. |
| `alt_text` | `'Map location: %address'` | Required alt text for the static map image; `%address` token → address. |

Notes:
- The dynamic iframe map (`include_map`) and the link (`include_link`) work **without** any Google
  Maps API key; only `include_static_map` requires `apikey`.
- The three outputs are independent — you can show map, static map, link, and text in any combination.
- Static maps only accept sizes in bare pixels (no `px`/`%` suffix).
- Set via drush by editing the view display config, e.g.
  `drush cget core.entity_view_display.node.{bundle}.default` then `drush cset ... content.{field}.settings.zoom_level 16`.
