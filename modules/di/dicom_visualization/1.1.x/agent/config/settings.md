<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings — `dicom_visualization.settings`

Form `src/Form/DicomConfiguration.php` (`DicomConfiguration extends ConfigFormBase`,
form id `dicom_visualization_settings`) edits the single config object
`dicom_visualization.settings`. Route `dicom_visualization.configuration` →
`/admin/dicom-configuration`, requirement `_permission: 'administer site configuration'`,
menu link parent `system.admin_config`. No `config/install` default or `config/schema`
is shipped — the object is created on first save, and every read uses an inline `?? default`
fallback.

## Tag source

`dicom_visualization_dicom_tags()` (in the `.module`) returns 48 fixed tag definitions,
each `['tag' => '00100020', 'name' => 'Patient ID', 'description' => '…']`. The form loops
over them and renders a `details` element per tag.

## Keys written by `submitForm()`

Per DICOM tag `<TAG>` (e.g. `00100020`):

- `<TAG>_prefix` (string) — label printed before the value; default `"<Name>: "`.
- `<TAG>_enabled` (bool) — show this tag on the overlay; default `TRUE`.
- `<TAG>_order` (int) — stacking order within its quadrant; default = list index.
- `<TAG>_position` (string) — one of `''`, `top_left`, `top_right`, `bottom_left`,
  `bottom_right` (from `dicom_visualization_tag_display_positions()`).

Aggregated, rebuilt on every save:

- `<pos>_tags` (array of tag ids) — for each of the four quadrants, the enabled tags whose
  `_position` equals that quadrant.

Global:

- `dicom_zoom` (bool, default `TRUE`) — enables mouse zoom / window-level / pan tools.
- `dicom_tag_color` (string hex, default `#ffffff`) — overlay text colour (`#type => color`).

## How the settings reach the viewer

`DicomFormatter::getProcessedTagsConfig()` reads `<pos>_tags`, keeps only entries that are
`_enabled` and whose `_position` matches the quadrant, sorts by `_order` (`<=>`), and reverses
the bottom quadrants. The result plus `dicom_zoom` and `dicom_tag_color` is passed both into
the `dicom_file_template` variables and `drupalSettings` (`tags_config`, `zoomDicom`,
`dicom_tag_color`). `js/dicomVisualization.js` reads each tag value from the parsed DICOM with
`image.data.string('x'+tag)` and writes `prefix + value` into an overlay `div` via
`textContent`. The advanced formatter does **not** use this config — it only consumes its own
per-display `viewer_theme` / `multi_file_display` settings.

Cache: the legacy formatter adds `#cache['tags'] = $config->getCacheTags()`, so saving the
form invalidates rendered fields.

## Drush

```
drush config:set dicom_visualization.settings dicom_zoom 0
drush config:get dicom_visualization.settings
```
