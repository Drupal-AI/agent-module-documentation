<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Paragraphs Clipboard extends Paragraphs Clipboard to the Layout Paragraphs builder, adding "Copy to clipboard" controls to components and "Paste from clipboard" (with or without an edit form) entries to the builder's insert menu.

---

This submodule of `paragraphs_clipboard` requires `layout_paragraphs`. `hook_preprocess_layout_paragraphs_builder_controls` adds a **Copy to clipboard** link to each saved component, pointing at the AJAX route `layout-paragraphs-builder/{layout}/copy_clipboard/{source_uuid}`; `CopyClipboardController` stores the component paragraph's UUID in the private tempstore under `copy_clipboard_uuid` (via the shared `ParagraphsClipboardService`). A `LayoutParagraphsAllowedTypesSubscriber` listens to `LayoutParagraphsAllowedTypesEvent` and, when the clipboard holds an access-allowed paragraph that fits the target field's bundles and cardinality, injects two pseudo component types into the builder's "add component" chooser: **Paste from clipboard** (immediate) and **Paste from clipboard with edit** (opens a dialog form). Pasting is handled by `PasteClipboardController::pasteClipboard`, which re-checks `ParagraphsClipboardAccess` (paragraph `update` + allowed bundle) and cardinality, duplicates the source component (recursing into a layout section's children when the copied component is itself a layout), inserts it before/after a sibling, into a region, or appended per the request's `placement`/`sibling_uuid`/`parent_uuid`/`region` query params, and persists the layout to tempstore. `PasteClipboardFormController` + `PasteClipboardComponentForm` (extending Layout Paragraphs' insert-component form) provide the edit-before-paste variant. All routes are guarded by `_layout_paragraphs_builder_access`. No settings, no permissions, no schema of its own.

---

- Copy a component inside the Layout Paragraphs builder and paste it elsewhere in the same layout.
- Paste a copied component into a specific region of a layout section.
- Paste a component before or after a chosen sibling component.
- Paste a copied layout section, duplicating all of its child components.
- Choose "Paste from clipboard with edit" to adjust fields in a dialog before inserting.
- Reuse an approved component across different Layout Paragraphs fields.
- Copy a component from its builder control without leaving the page (AJAX).
- Only show paste options when the clipboard paragraph's bundle is allowed in the target layout.
- Respect the target field's cardinality before offering paste.
- Enforce update access on the clipboard component before pasting.
- Speed up assembling landing pages from repeated layout components.
- Duplicate nested layouts (rows/columns) with their contents intact.
- Share the same clipboard entry between the classic Paragraphs widget and the Layout builder.
- Insert a pasted component and refresh only the affected part of the builder.
- Open the paste-with-edit form pre-populated from the copied paragraph type.
- Build consistent page structures by cloning a template component.
- Avoid rebuilding complex multi-region sections manually.
- Keep the copied component available across builder reloads within the session.
- Cancel a paste cleanly with an error message if the clipboard is empty.
- Combine with the parent module's node-widget copy/paste for a unified clipboard workflow.
