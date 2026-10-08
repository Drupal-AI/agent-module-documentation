# diff — agent start

Compares two revisions of a node/entity field-by-field, in Split, Unified, or Visual-inline
layouts. Config UI: **Admin → Config → Content authoring → Diff**
(`/admin/config/content/diff`, configure route `diff.general_settings`). Needs the
`mkalkbrenner/php-htmldiff-advanced` library for visual diffs. No permissions of its own —
access is gated by core's `view all revisions` entity permission.

- Global + per-field settings (layouts, context lines, field comparison options) → [configure/settings.md](configure/settings.md)
- Two plugin types — FieldDiffBuilder (per field type) + DiffLayoutBuilder (display) → [plugins/plugins.md](plugins/plugins.md)
- Alter registered diff/layout plugins via hooks → [hooks/hooks.md](hooks/hooks.md)
