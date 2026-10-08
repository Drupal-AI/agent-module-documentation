<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File to Media — agent index

Turns an existing managed file into a Media entity. Two pieces, **no config of its own**:
a Views field that renders a "Create <media type>" dropbutton per file, and an add-form
route. No settings page, no permissions of its own, no Drush, no config schema, no plugin
types.

- **Add the "Create media" button to a view / the Views field `file_to_media`** →
  [configure/views-field.md](configure/views-field.md)
- **The add-form route, compatibility rules, and access checks (what the button does)** →
  [api/conversion.md](api/conversion.md)

Key facts:
- Views field id / plugin / table: **`file_to_media`** on base table **`file_managed`**
  (registered via `hook_views_data_alter`). Add it to a view of files to get the dropbutton.
- Route `file_to_media.add_form` → `/file/to-media/{file}/{media_type}`, permission
  **`access files overview`**; builds the media add-form with the file pre-assigned.
- The link only appears for a file that is **public**, **not already used by a media entity**,
  and for media types whose **source field's `file_extensions`** include the file's extension.
