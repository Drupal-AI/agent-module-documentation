<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Views Entity Revisions — agent index

Submodule of **rest_views**. Adds an export formatter for `entity_reference_revisions` fields
(Paragraphs) so they serialize as nested structures in a Views REST Export. Requires
`entity_reference_revisions` + `rest_views`. No config/route/permissions/Drush.

- **Export an ERR / Paragraphs field: the formatter + serializable handler** →
  [configure/revisions-export.md](configure/revisions-export.md)

Key facts: field formatter id **`entity_reference_revisions_export`** (class
`EntityReferenceRevisionsExportFormatter` extends the parent's `EntityReferenceExportFormatter`,
field type `entity_reference_revisions`). It only works with the `field_export` serializable
handler, which rest_views already provides for ERR fields (no extra views_data_alter here).
