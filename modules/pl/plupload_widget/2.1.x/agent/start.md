<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plupload file widget — agent index

Provides Plupload-powered **field widgets** for core File and Image fields (chunked, auto-submitting
uploads with progress). No field type, no settings form, no config route. Depends on the `plupload`
module.

- **Select the widget on Manage form display; the image widget's preview_image_style setting** →
  [configure/widgets.md](configure/widgets.md)

Key facts:
- Widget `plupload_file_widget` → core `file` fields (no widget settings).
- Widget `plupload_image_widget` → core `image` fields; one setting `preview_image_style`
  (schema `field.widget.settings.plupload_image_widget`).
- Renders a `#type => plupload` element with `#autoupload` + `#autosubmit`; chunked upload with
  `chunk_size` / `max_file_size` derived from PHP `upload_max_filesize` / `post_max_size`.
- No permissions, no Drush, no plugin types (provides instances of the core widget plugin type).
