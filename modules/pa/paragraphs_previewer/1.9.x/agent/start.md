<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Previewer — agent index

Adds a **Preview** button per paragraph row by swapping the Paragraphs field widget for one
of its own. No settings form, `configure: null`, no Drush, no plugin types of its own.
Persistent state = (a) the widget `type` on a form-display component, (b) one simple config
key, (c) one permission.

- **Turn it on for a field / choose the widget / set the preview view mode** →
  [configure/enable-previewer.md](configure/enable-previewer.md)
- **The three widget plugin ids and which Paragraphs widget each extends** →
  [plugins/widgets.md](plugins/widgets.md)
- **How the preview is produced (button → AJAX → modal iframe → controller render)** →
  [api/preview-flow.md](api/preview-flow.md)
- **The single permission and the CSRF-protected route it guards** →
  [permissions/view-previews.md](permissions/view-previews.md)

Key facts:
- Widget ids: `paragraphs_previewer` (use this), `entity_reference_paragraphs_previewer`
  (legacy widget), `paragraphs_previwer` (DEPRECATED, hidden from the UI).
- Config object `paragraphs_previewer.settings` → `previewer_view_mode` (default `full`).
- Permission: `view any paragraphs previewer`.
- Route: `paragraphs_previewer.form_preview`, path
  `paragraphs-previewer/form/{form_build_id}/{element_parents}`.
- Requires `paragraphs`; only applies to `entity_reference_revisions` fields.
