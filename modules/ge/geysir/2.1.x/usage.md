Geysir lets content authors add, edit, delete, reorder (cut/paste) and translate individual Paragraphs directly from the rendered front-end of a node using AJAX modal dialogs, instead of switching to the entity edit form in the Drupal backend.

---

Geysir depends on the Paragraphs and Entity modules and works on any `entity_reference_revisions` field that targets `paragraph` entities on a node. It adds no configuration UI (`configure` is null) and defines a single permission, `geysir manage paragraphs from front-end`. When a user holds that permission and can update the current node, `hook_preprocess_field()`/`hook_preprocess_node()` inject per-paragraph action buttons (Add before/after, Edit, Delete, Cut, Paste, Translate) that open Drupal modal dialogs via `use-ajax` links. The modal forms are custom entity forms registered in `hook_entity_type_build()` (`geysir_modal_edit`, `geysir_modal_delete`, `geysir_modal_add`) that save the paragraph and re-save a new revision of the parent entity, then AJAX-replace just the field wrapper markup. Routes live under `/geysir/...` and carry the full context (parent entity type/bundle/revision, field name, delta, paragraph id/revision) as path parameters. A toolbar tab (`hook_toolbar()`) toggles visibility of the buttons. The only extension point is `hook_geysir_paragraph_links_alter()`, which lets other modules add or change the action links (e.g. move up/down). Geysir only renders buttons for nodes (not nested paragraph parents) and disables Add/Cut/Paste on translated parents.

---

- Let editors add a new Paragraph between two existing Paragraphs without leaving the page.
- Edit a single Paragraph's fields in a modal dialog straight from the front-end.
- Delete an individual Paragraph from the rendered page.
- Reorder Paragraphs by cutting one and pasting it before/after another.
- Add the first Paragraph to an empty Paragraphs field from the node view.
- Translate a Paragraph in-context when viewing a translated parent node.
- Speed up landing-page / page-builder workflows built on Paragraphs.
- Give reviewers a fast way to tweak copy in a Paragraph without opening the backend form.
- Provide a live-preview-like editing experience on Paragraph-based layouts.
- Restrict front-end paragraph management to trusted roles via a single permission.
- Add a "Start adding content" call-to-action on nodes whose Paragraph field is empty.
- Support multiple Paragraph fields on the same node, each with its own controls.
- Respect field cardinality (hides Add when the field is full) and required fields (blocks deleting the last item).
- Add custom per-paragraph action links via `hook_geysir_paragraph_links_alter()` (e.g. move up/down, clone).
- Toggle the front-end editing buttons on/off with the Geysir toolbar tab.
- Keep a revision history: every add/edit/delete/paste saves a new parent entity revision.
- Select the Paragraph type from a modal when adding, honoring the field's allowed (or negated) target bundles.
- Use it as a lighter-weight alternative to full Layout Builder for Paragraph-driven pages.
- Let authors work on the latest revision only (buttons are hidden on non-latest revisions).
- Give a paste/cut clipboard workflow for moving a Paragraph within a field.
