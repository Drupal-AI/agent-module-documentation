# ckeditor_indentblock — agent start

Adds CKEditor 5 **block indentation** (indent/outdent whole paragraphs) via one plugin,
`ckeditor_indentblock_indent`. It has **no toolbar button of its own** — it reuses core's
**Indent** / **Outdent** buttons (the `ckeditor5_indent` plugin), applying CSS classes
`Indent1`…`Indent10` to `<p>` instead of inline styles. Depends on core `ckeditor5`.
No global admin page — everything is configured per **text format** at
`/admin/config/content/formats`, stored on the `editor.editor.<format>` config entity.

- Turn on paragraph indentation in a text format (toolbar + Enable checkbox + allowed tags) → [configure/text-format.md](configure/text-format.md)
- The plugin id, settings key, config schema, and how it hooks into CKEditor 5 → [plugins/indentblock.md](plugins/indentblock.md)
