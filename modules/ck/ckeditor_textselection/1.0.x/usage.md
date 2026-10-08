<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Text Selection preserves the editor's text selection when you toggle Source Editing mode.

---

CKEditor Text Selection is a CKEditor 5 plugin that keeps your cursor position or highlighted text when you switch between the rich-text (WYSIWYG) view and the Source (HTML) view, and scrolls the selection back into view. It is the CKEditor 5 equivalent of the CKEditor 4 "textselection" addon. It adds no toolbar button and needs no configuration.

It is a CKEditor 5 plugin with no content or access role of its own. Depends on core `ckeditor5` and on the `levmyshkin/ckeditor5-textselection` asset library (installed under `/libraries`); supports Drupal 10, 11, and 12.

---

- Preserve the cursor position when toggling Source Editing.
- Preserve a text selection (not just the cursor) across mode switches.
- Scroll the selection back into view in both modes.
- Work automatically whenever Source Editing is enabled.
- Support the `ckeditor_codemirror` (CodeMirror) source editor.
- Add no toolbar item and no allowed HTML tags.
- Require no configuration.
- Handle all failures silently, never crashing the editor.
- Depend on core `ckeditor5`.
- Support Drupal 10, 11, and 12.
- Carry no content or access role.
- Run entirely client-side (no server component).
- Replicate the CKEditor 4 Text Selection addon.
- Integrate with the CKEditor 5 WYSIWYG.
- Improve the source-editing workflow.
- Keep the enhancement lightweight.
