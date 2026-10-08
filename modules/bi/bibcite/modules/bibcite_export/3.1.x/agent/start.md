<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - Export (bibcite_export) — agent index

Exports `bibcite_reference` entities in any registered `bibcite_format` (BibTeX, RIS, EndNote,
MARC) — per-reference download links, bulk export of a selection, and export-all. No config UI
(`configure: null`); one permission `access bibcite export`.

- **Export routes, URL pattern, bulk actions, export links** → [api/export.md](api/export.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts: single-reference route `/bibcite/export/{bibcite_format}/{entity_type}/{entity}`
(permission `access bibcite export` + entity view). Bulk Action plugins over `bibcite_reference`:
`bibcite_export_multiple` ("Export reference") and `bibcite_export_multiple_vbo` ("Download
Selected Citations"). Export-all form at `/admin/content/bibcite/reference/export`. Registers
`export:*` derivatives on the `bibcite_link` list. Ships the
`system.action.bibcite_export_multiple` action config entity.
