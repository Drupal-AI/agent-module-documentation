<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SD Table provides a field type for building rich, dynamic HTML tables through the UI.

---

SD Table **provides an SD Table field type** — letting editors build rich, dynamic HTML tables (with
formatting, media) through a UI, integrating with CKEditor 5. It depends on core Field, File, Filter, Editor and
CKEditor 5.

Use it for editor-built data tables. It is a content-editing/field feature. Security note: because editors build
**HTML tables** that are rendered, the table content is subject to the **text format's filtering** — ensure the
format sanitizes so table markup can't introduce XSS, and restrict the field/format to trusted editors. It has no
access-control role. Configure the SD Table field.

---

- Provide an HTML-table field type.
- Build rich, dynamic tables via UI.
- Integrate with CKEditor 5.
- Depend on core Field/File/Editor/CKEditor 5.
- Serve content editing.
- Author data tables.
- Render editor-built HTML tables (subject to text-format filtering).
- Ensure the format sanitizes (prevent XSS) + restrict to trusted editors.
- Have no access-control role.
- Configure the SD Table field.
- Handle table fields.
- Build tables.
- Configure the field.
- Author tables.
- Handle the markup.
- Render tables.
- Configure editing.
- Handle the display.
- Add tables.
- Provide an HTML-table field.
