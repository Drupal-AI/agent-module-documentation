<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ProseMirror provides a ProseMirror-based rich-text editor for Drupal.

---

ProseMirror **provides a ProseMirror-based rich-text editor** — a modular, extensible, fully open-source
WYSIWYG editor alternative to CKEditor, with strong headless/decoupled/omnichannel editing support. It provides
its own permissions, in the ProseMirror package.

Use it as an alternative rich-text editor. It is a content-editing/WYSIWYG feature. Security note: like any rich-text
editor, the safety of edited content depends on the **text format's filters** — ensure the format used with
ProseMirror sanitizes output (restricts allowed HTML) so editors can't introduce XSS, exactly as with CKEditor. It
has no access-control role beyond its permission. Configure the ProseMirror editor on a text format.

---

- Provide a ProseMirror rich-text editor.
- Offer an open-source CKEditor alternative.
- Support headless/decoupled editing.
- Provide its own permissions.
- Serve content editing/WYSIWYG.
- Enable rich text.
- DEPEND on the text format's filters for output safety.
- Ensure the format sanitizes (restricts HTML) to prevent XSS.
- Behave like CKEditor for content safety.
- Have no access-control role beyond permission.
- Configure the editor on a text format.
- Handle rich-text editing.
- Edit rich text.
- Configure the editor.
- Format text.
- Handle the WYSIWYG.
- Provide editing.
- Sanitize via the format.
- Restrict HTML.
- Provide a ProseMirror editor.
