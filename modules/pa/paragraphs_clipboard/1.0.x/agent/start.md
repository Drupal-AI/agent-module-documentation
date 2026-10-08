<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Clipboard — agent index

Adds "Copy to clipboard" / "Paste from clipboard" actions to the Paragraphs widget so editors can
duplicate a saved paragraph into another paragraph field (any node). No settings page (`configure`
null), no module permissions, no Drush; relies on standard paragraph/entity access. Depends on
`paragraphs`.

- **How copy/paste attaches to the widget, the copy route, and how to enable it** →
  [configure/widget.md](configure/widget.md)
- **`ParagraphsClipboardService` (tempstore), `ParagraphsClipboardAccess`, and the copy controller** →
  [api/service.md](api/service.md)

Submodule (own docs):
- `layout_paragraphs_clipboard` → [../../modules/layout_paragraphs_clipboard/1.0.x/agent/start.md](../../modules/layout_paragraphs_clipboard/1.0.x/agent/start.md)

Key facts:
- Copy button added via `hook_paragraphs_widget_actions_alter`; paste button via
  `hook_field_widget_complete_form_alter` (only for `entity_reference_revisions`→`paragraph` fields
  with clipboard content + cardinality room). Both are form submit handlers, not separate pages.
- Clipboard = user **private tempstore** (`ParagraphsClipboardService`, key `copy_clipboard`) storing
  `paragraph_id` + `revision_id`.
- AJAX copy route `paragraphs-clipboard/paragraphs/{paragraph}/copy` (JSON) guarded by
  `_entity_access: paragraph.update`; shown in the admin Paragraphs view and (with `paragraphs_edit`)
  on rendered paragraphs.
- Paste clones via `replicate.replicator` if present, else `Paragraph::createDuplicate()`; access
  requires paragraph `update` AND the bundle being allowed by the target field's `target_bundles`.
