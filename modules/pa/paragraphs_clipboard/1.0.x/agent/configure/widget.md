<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling & using copy/paste (no settings page)

There is no config form. The actions attach automatically to the standard Paragraphs widget.
Sources: `paragraphs_clipboard.module`, `src/Plugin/Field/FieldWidget/ParagraphsClipboardWidget.php`,
`paragraphs_clipboard.routing.yml`, `paragraphs_clipboard.links.contextual.yml`,
`js/paragraphs_clipboard_visibility.js`.

## Requirements to see the buttons

- The field is `entity_reference_revisions` targeting `paragraph` and uses the Paragraphs widget
  (EXPERIMENTAL/stable) with reference changes allowed.
- **Copy** appears in each *saved* paragraph's dropdown actions (`#disabled` while the paragraph is
  new/unsaved).
- **Paste from clipboard** appears in the field's *Add more* area only when: the clipboard holds a
  paragraph, the field still has cardinality room, and access passes (see below). It is added inside
  `add_more` (works with `select`, `modal`, and default add modes).

## Copy paths

1. **In the edit form** — `hook_paragraphs_widget_actions_alter` adds a `Copy to clipboard` submit
   button; `paragraphs_clipboard_copy_clipboard_submit` stores `paragraph_id`+`revision_id` in the
   clipboard tempstore and messages the user (or warns if the item is unsaved).
2. **AJAX route** — `paragraphs_clipboard.copy` = `paragraphs-clipboard/paragraphs/{paragraph}/copy`
   (format JSON), requirement `_entity_access: paragraph.update`, handled by `CopyClipboardController`.
   Exposed as a contextual link (`paragraphs_clipboard.links.contextual.yml`) and, when
   `paragraphs_edit` is enabled, on the rendered paragraph via `hook_paragraph_view_alter`; also added
   to the admin **paragraphs** view (`page_admin_paragraphs`, the `nothing` field) via
   `hook_preprocess_views_view_field` (only if the row entity is view-accessible).

## Paste

`paragraphs_clipboard_paste_clipboard_submit`:
- Reloads the clipboard paragraph; re-checks cardinality and `ParagraphsClipboardAccess` (paragraph
  `update` + bundle allowed by the target field's `target_bundles`/`negate`).
- Clones via `replicate.replicator` if the `replicate` module is installed (deep, reference-aware),
  else `createDuplicate()`.
- Inserts the clone into the widget state at the prepared delta and rebuilds the form (AJAX).

The paste button's availability is also mirrored to JS via
`drupalSettings.paragraphsClipboard.fields[<field_id>].hasAccess`; the
`paragraphs_clipboard.clipboard_visibility` library shows/hides it accordingly.

## Optional integrations

- `replicate` — better cloning of complex/nested paragraphs.
- `paragraphs_edit` — adds the copy link on rendered paragraphs.
- `layout_paragraphs` — install the `layout_paragraphs_clipboard` submodule for the Layout Paragraphs
  builder.
