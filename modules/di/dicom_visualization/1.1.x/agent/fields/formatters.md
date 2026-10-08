<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters & widget — displaying DICOM on a File field

All three plugins target `field_types = {"file"}`, i.e. the core File field. There is no
custom field type; you attach these to an ordinary File field.

## Setup

1. `drush en dicom_visualization` (only dependency is core `file`).
2. On a content type add/edit a **File** field and add `dcm` to *Allowed file extensions*.
   (Extension gating is the core field setting — the module adds none of its own.)
3. **Manage display** → set the field formatter to one of the two below.
4. **Manage form display** → optionally set the widget to *Dicom File Widget*.

## Formatter `dicom_file_formatter` — "DICOM File Formatter (Legacy)"

Class `DicomFormatter` (`src/Plugin/Field/FieldFormatter/DicomFormatter.php`),
`ContainerFactoryPluginInterface`; injects `config.factory`, `file_url_generator`,
`renderer`. `viewElements()`:

- Reads global `dicom_zoom` / `dicom_tag_color` from `dicom_visualization.settings`.
- Builds `tags_config` via `getProcessedTagsConfig()` (see `../config/settings.md`).
- Per file item, themes `dicom_file_template` with `#full_url =
  fileUrlGenerator->generateAbsoluteString($file->getFileUri())`.
- Attaches library `dicom_visualization/dicom-file-formatter` and the same data via
  `drupalSettings`.

`settingsSummary()` renders a link to `dicom_visualization.configuration`. No per-display
settings — all behaviour comes from the global config object. Template
`templates/dicom-file-template.html.twig` outputs a `.wadoURL` div carrying
`data-id`/`data-url`; JS turns the URL into a `wadouri:` image id and calls
`cornerstone.loadAndCacheImage`.

## Formatter `dicom_adv_file_formatter` — "Dicom Advanced File Formatter"

Class `DicomAdvancedFormatter`; injects only `file_url_generator`. Per-display settings
(`defaultSettings()`):

- `viewer_theme` (default `av-theme-default`) — 15 options from `getThemeOptions()`
  (Obsidian, Midnight, Emerald, Ruby, Amethyst, Slate, Ocean, Forest, Volcano, Cyberpunk,
  Bone, Deepsea, plus three light themes). Printed as a CSS class on the viewer div.
- `multi_file_display` (default `individual`) — only shown when field cardinality > 1 or
  unlimited. `individual` = one `dicom_advanced_file_template` per file; `combined` = a
  single template with all URLs joined by `,` and `#multi_file = TRUE` (stack/gallery mode).

Attaches `dicom_visualization/dicom-advanced-file-formatter`
(`js/dicom-advanced-visualization.js` + `css/dicom-advanced-visualization.css`). Template
`templates/dicom-advanced-file-template.html.twig` outputs `.axiom-viewer <theme>` with
`data-src`. This formatter ignores the global tag/overlay configuration.

## Widget `dicom_visualization` — "Dicom File Widget"

Class `DicomWidget extends FileWidget` (core). Adds one `additional_setting` textfield in
`settingsForm()` and copies it onto the element as `#additional_setting`; otherwise identical
to the core file widget. It is a thin extension — upload/validation behaviour is core's.

## Notes for agents

- File URLs are generated from the File entity's own URI; access, public/private scheme and
  cardinality are the core File field's responsibility, not this module's.
- Metadata overlays are rendered client-side into `textContent` (not HTML), and Twig
  autoescapes the template variables.
