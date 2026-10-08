Editor Paste Plain is a CKEditor 5 plugin that, per text format, forces all clipboard content to be pasted as plain text — the equivalent of always using Ctrl+Shift+V — stripping HTML markup on paste.

---

The module registers a single CKEditor 5 plugin (`editor_paste_plain_text`, PHP class
`ForcePastePlainText`) that is configurable per text format. It has no global settings page (`configure`
is null) and no permissions. You enable it on the *Text formats and editors* form (`/admin/config/content/formats`)
for any format that uses CKEditor 5: under **CKEditor 5 plugin settings** open the **Paste as plain text**
tab and tick **Force pasting as plain text**. That single boolean (`force_paste_plain_text`, schema
`ckeditor5.plugin.editor_paste_plain_text`) is stored in the editor's `settings.plugins`, and the plugin's
`conditions.requiresConfiguration` means the JavaScript only loads when the box is checked. The bundled
JS (`js/build/forcePastePlainText.js`, source in `js/ckeditor5_plugins/forcePastePlainText/src/index.js`)
listens to CKEditor's `clipboardInput` event and rewrites the pasted content through
`plainTextToHtml(dataTransfer.getData('text/plain'))`, so any rich formatting, styles, or markup from the
source is discarded and only text is inserted. The read-only editor state is respected (paste handling is
skipped when the editor is read-only). Depends only on core `ckeditor5`.

---

- Force all pastes in a text format to be plain text, dropping formatting from Word/Google Docs/web pages.
- Prevent editors from importing inline styles and `<span style>` cruft when copying from other sites.
- Keep a "Basic HTML" or "Restricted HTML" format clean by stripping markup at paste time.
- Enforce a house style by removing pasted fonts, colors, and sizes automatically.
- Avoid broken or disallowed tags being pasted and then silently filtered on save.
- Make paste behaviour predictable without training editors to press Ctrl+Shift+V.
- Apply plain-text paste to one format (e.g. comments) while leaving full HTML pastes on another.
- Reduce XSS/markup surface from clipboard content in editor-facing formats.
- Strip tracking pixels and hidden markup copied from marketing emails.
- Clean up nested list/table HTML pasted from spreadsheets into a simple text field.
- Standardize paste behaviour across an editorial team via exported text-format config.
- Remove `data-*` attributes and editor-specific wrappers pasted from another CMS.
- Ensure pasted content matches the format's allowed tags instead of being scrubbed afterwards.
- Prevent accidental pasting of large base64 images embedded as HTML.
- Give a "plain notes" text format that never accepts formatting on paste.
- Keep migration/import staging fields free of source formatting when editors paste content.
- Load the paste-plain JavaScript only where the option is enabled (no overhead on other formats).
- Combine with a minimal toolbar to make a truly plain-text-only authoring experience in CKEditor 5.
