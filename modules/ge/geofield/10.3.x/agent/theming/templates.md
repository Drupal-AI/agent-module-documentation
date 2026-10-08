# Geofield templates & theme hooks

Registered in `geofield_theme()` (`geofield.module`). Override in your theme by copying the
twig files from `templates/`.

## `geofield_latlon` → `geofield-latlon.html.twig`
Renders the centroid as a lat/lon pair. Variables:
- `lat` — latitude value.
- `lon` — longitude value.

Output: `<span class="latlon latlon-lat">{{ lat }}</span>, <span class="latlon latlon-lon">{{ lon }}</span>`

## `geofield_dms` → `geofield-dms.html.twig`
Renders coordinates in Degrees/Minutes/Seconds. Variable:
- `components` — keyed (`lat`, `lon`); each has `orientation`, `degrees`, `minutes`, `seconds`.

Used by the `geofield_latlon` formatter (output format `dms`) and the DMS widget summary.

## Libraries (`geofield.libraries.yml`)
- `geofield/geofield_general` — base CSS.
- `geofield/geolocation` — HTML5 geolocation JS for the lat/lon widget.
- `geofield/proximity_origin_summary_update` — JS for proximity handler summaries.
