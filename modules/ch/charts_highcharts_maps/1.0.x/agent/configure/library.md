<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install the Highcharts Maps library & satisfy requirements

`charts_highcharts_maps.libraries.yml` declares two libraries:

- **`charts_highcharts_maps`** — the JS glue (`js/charts_highcharts_maps.js`); depends on
  `core/drupalSettings`, `charts/global`, `core/once`.
- **`highmap`** — the Highcharts Maps engine (`map.js`). Declared `remote`/`cdn`:
  `https://code.highcharts.com/maps/12.1.1/modules/map.js`; local path expected at
  `/libraries/highcharts_maps/map.js`. License is declared `Non-commercial` (CC BY-NC 3.0,
  `gpl-compatible: false`).

`Highmap::preRender()` attaches, in order: the base Highcharts engine
(`charts_highcharts/highcharts` if **charts_highcharts** is enabled, else `charts_highstock/default`
if **charts_highstock** is enabled), then `charts_highcharts_maps/highmap`, then the glue library.
When **charts_highcharts** is present it also conditionally attaches its `accessibility`,
`annotations`, `boost`, and `data` sub-libraries based on the chart configuration.

## Local install (recommended, per README)
The library is not bundled. Place `map.js` at `libraries/highcharts_maps/map.js`. The lookup
(`charts_highcharts_maps_find_library()`) searches, in order:
`profiles/<profile>/libraries`, `libraries`, and `<site.path>/libraries` — for
`highcharts_maps/map.js`.

Composer recipe (from README): register a `drupal-library` package `highcharts/maps` whose `dist.url`
is `https://code.highcharts.com/maps/<ver>/modules/map.js` with `installer-name: highcharts_maps`,
then `composer require highcharts/maps:<ver>`. (Note a version drift: the README example pins
`11.1.0` while the `highmap` library definition's CDN points at `12.1.1` — align these to the version
you intend to serve.)

## CDN toggle
The CDN fallback is controlled by the **Charts** module setting `charts.settings` →
`advanced.requirements.cdn` (Charts UI → Advanced tab), not by this module. Behaviour of
`hook_requirements` (runtime) for the `charts_highcharts_maps_js` check:

| Local library found | `advanced.requirements.cdn` | Status report |
|---------------------|-----------------------------|---------------|
| yes | — | OK "Installed" |
| no | true | WARNING "Available through a CDN" |
| no | false | ERROR "Not Installed" |

## Other requirement checks (`hook_requirements`)
- **`charts_highcharts_dependency`** — ERROR unless **charts_highcharts** or **charts_highstock** is
  enabled (one of them provides the base Highcharts engine this module builds on).
- A legacy-library check — if the old libraries API (`libraries_detect('highmap')`) is present and
  finds an `exporting-server` sample directory inside that library, the check reports an error asking
  you to remove that leftover sample directory before use. It does not trigger for a modern
  `libraries/highcharts_maps/` install.

Check everything with `admin/reports/status` (or `drush core:requirements`) after enabling.
