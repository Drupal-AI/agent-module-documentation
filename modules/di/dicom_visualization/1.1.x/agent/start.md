<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dicom visualization (dicom_visualization) — agent index

Renders DICOM (`.dcm`) medical imaging files on Drupal's **core File field** via two
field formatters plus a file widget. The interactive viewer is client-side Cornerstone.js
(loaded from a CDN); the server side only builds render arrays and passes an absolute file
URL and tag configuration to JavaScript. No custom entity, controller, service or database
table is added.

- **Package:** Dicom · **License:** GPL-2.0-or-later
- **Core:** `^9.3 || ^10 || ^11` · **Depends on:** `drupal:file` only
- **Configure route:** `dicom_visualization.configuration` → `/admin/dicom-configuration`
  (permission `administer site configuration`); menu link `dicom_visualization.configuration`.
- **Config object:** `dicom_visualization.settings` (no config/schema shipped).

## What it provides

Field plugins (in `src/Plugin/Field/`):

- **Formatter `dicom_file_formatter`** — "DICOM File Formatter (Legacy)".
  Class `DicomFormatter`. Reads `dicom_visualization.settings`, builds per-quadrant tag
  overlay config, themes with `dicom_file_template`, attaches library
  `dicom_visualization/dicom-file-formatter`.
- **Formatter `dicom_adv_file_formatter`** — "Dicom Advanced File Formatter".
  Class `DicomAdvancedFormatter`. Per-display settings: `viewer_theme` (15+ options) and
  `multi_file_display` (`individual` | `combined`); themes with
  `dicom_advanced_file_template`, attaches `dicom_visualization/dicom-advanced-file-formatter`.
- **Widget `dicom_visualization`** — "Dicom File Widget". Class `DicomWidget` extends core
  `FileWidget`; adds one cosmetic `additional_setting` textfield.

Module file `dicom_visualization.module`:

- `hook_theme()` → `dicom_file_template`, `dicom_advanced_file_template`.
- `dicom_visualization_dicom_tags()` — static list of 48 DICOM tag definitions.
- `dicom_visualization_tag_display_positions()` — quadrant option list.

Libraries (`dicom_visualization.libraries.yml`): `cornerstone-base` (external CDN scripts:
hammerjs, dicom-parser, cornerstone-core/math/tools/wado-image-loader) + two formatter
libraries wrapping `js/dicomVisualization.js` and `js/dicom-advanced-visualization.js`.

## Solution docs

- [Global settings form](config/settings.md) — `dicom_visualization.settings`, per-tag
  mapping, quadrants, overlay colour, zoom.
- [Formatters & widget](fields/formatters.md) — how to enable the viewers on a File field.
