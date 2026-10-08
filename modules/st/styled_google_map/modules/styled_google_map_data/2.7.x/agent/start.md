<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styled Google Map Demo Data — agent index

Example submodule that fills the `styled_google_map_demo` `real_estate` entity with sample
data and installs a ready-made "Styled Google Map" View. No configuration, no plugins, no
API — it is install-time demo content plus one exported View. Depends on
`styled_google_map_demo` (and, transitively, `styled_google_map`).

## What it does on install (`styled_google_map_data.install`)

1. Imports `images/*.png` as managed files (pin icons).
2. Creates three `real_estate` taxonomy terms: **Condo, Multi-Family, Residential**, each
   with a pin `field_icon`.
3. Runs a batch (`demo.batch.inc`) importing `csv/demo.csv` (Sacramento housing sales:
   street, price, latitude, longitude, type) into `real_estate` entities.

`hook_uninstall()` deletes those terms and the imported content.

## The bundled View (`views.view.styled_google_map`)

- Id `styled_google_map`, uses the parent Views style `styled_google_map`.
- Example page displays: `/heatmap`, `/cluster-map`, `/cluster-map-spiderified`,
  `/map-controls`, plus a single-item display.
- `hook_preprocess_page()` prints links to those pages + an "add your Google Maps API key"
  reminder; `hook_form_views_exposed_form_alter()` turns the exposed filter into an on-map
  control (position `TOP_LEFT`) on the `map-controls` page.

## Install gotcha

The exported View config depends on the **`svg_image`** module, so this submodule cannot be
enabled until `svg_image` is installed (`drush en` fails with an unmet-dependency error
otherwise). It is a hidden/demo helper — not for production.

Parent module API: [`../../../../2.7.x/agent/start.md`](../../../../2.7.x/agent/start.md).
Entity type reference: [`../../../styled_google_map_demo/2.7.x/agent/api/entity.md`](../../../styled_google_map_demo/2.7.x/agent/api/entity.md).
