# Markdownify File Attachment — agent index

Submodule of **markdownify**. Makes `file` fields render inside an entity's **Markdown**
output, inlining the text contents of small allowed-type attachments. Requires `file` +
`markdownify`, Drupal ≥ 10.2.

- **Config keys, the settings form, and the include/link decision** →
  [configure/settings.md](configure/settings.md)
- **The `md_file_attachment_file_embed` field formatter and the `entity_build_alter` hook
  that applies it** → [plugins/formatter.md](plugins/formatter.md)

Key facts:
- Config object `markdownify_file_attachment.settings`: `allowed_extensions`
  (default `[txt, yml, yaml, wsdl, json]`), `max_file_embed_size` (default `1 MB`).
- Settings form `markdownify_file_attachment.settings` →
  `/admin/config/services/markdownify/file-attachment` (perm: `administer site configuration`).
- Implements `hook_markdownify_entity_build_alter()` to swap every `file` field to the
  `md_file_attachment_file_embed` formatter during Markdown rendering.
- Allowed type **and** within size → inlines `file_get_contents` of the file; else emits
  filename + URL only.
