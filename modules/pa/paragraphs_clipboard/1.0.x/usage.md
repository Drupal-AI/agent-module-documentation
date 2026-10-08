<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Clipboard adds "Copy to clipboard" and "Paste from clipboard" actions to the Paragraphs field widget, letting editors duplicate a saved paragraph into another paragraph field (even on a different node) preserving its data.

---

The module hooks the Paragraphs widget without replacing it. `hook_paragraphs_widget_actions_alter` adds a **Copy to clipboard** dropdown action to each saved paragraph item; its submit handler stores the paragraph's id + revision id in the user's private tempstore (`ParagraphsClipboardService`, key `copy_clipboard`). `hook_field_widget_complete_form_alter` adds a **Paste from clipboard** button to any `entity_reference_revisions`→`paragraph` field when the clipboard holds a compatible paragraph and the field still has cardinality room; its submit handler clones the stored paragraph (via the `replicate` service when available, else `createDuplicate()`) and appends it to the widget state. A dedicated AJAX route `paragraphs-clipboard/paragraphs/{paragraph}/copy` (JSON, guarded by `_entity_access: paragraph.update`) powers the "copy to clipboard" link shown on the admin Paragraphs view and on rendered paragraphs when `paragraphs_edit` is installed. Access to paste is checked by `ParagraphsClipboardAccess`, which requires `update` access on the clipboard paragraph AND that the paragraph's bundle is allowed by the target field's `handler_settings` (`target_bundles`/`negate`); the same result is also exposed to JS via `drupalSettings` to show/hide the button. There is no settings page (`configure` null) and no module-specific permissions — it relies on standard paragraph/entity access. An optional submodule, `layout_paragraphs_clipboard`, extends the same clipboard to the Layout Paragraphs builder.

---

- Copy a paragraph from one node and paste it into another node's paragraph field.
- Duplicate a complex paragraph (with nested paragraphs) without rebuilding it by hand.
- Reuse a call-to-action or hero paragraph across many pages.
- Paste a copied paragraph into a different paragraph field on the same form.
- Clone a saved paragraph using the `replicate` module for deep, reference-safe copies.
- Copy a paragraph from the admin Paragraphs listing view via an AJAX link.
- Copy a paragraph directly from its rendered display when `paragraphs_edit` is enabled.
- Only offer paste when the target field's allowed bundles include the copied type.
- Prevent pasting into a field that has reached its cardinality limit.
- Restrict copying to paragraphs the user may update (entity access enforced).
- Speed up building repetitive layouts by copy/pasting section paragraphs.
- Move boilerplate content blocks between content types that share paragraph bundles.
- Keep a paragraph on the clipboard across form rebuilds within a session (private tempstore).
- Paste at a chosen delta position within the paragraphs widget.
- Auto-collapse other open paragraphs when a pasted one is added to the widget.
- Show or hide the paste button dynamically in JS based on access.
- Copy layout paragraphs components in the Layout Paragraphs builder (via the submodule).
- Avoid re-uploading media and re-entering fields when replicating content.
- Standardise recurring content patterns by copying an approved paragraph.
- Support both "select" and "modal" Paragraphs add modes for the paste button.
- Warn when trying to copy an unsaved paragraph (only saved items can be copied).
