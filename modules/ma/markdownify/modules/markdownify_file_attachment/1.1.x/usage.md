Markdownify File Attachment makes `file` fields render inside an entity's Markdown output — embedding the actual text contents of small allowed-type attachments (e.g. `.txt`, `.json`, `.yml`) inline, and otherwise linking them — so AI consumers see attached file data, not just a link.

---

The submodule implements `hook_markdownify_entity_build_alter()`: while an entity is being
rendered for Markdown, every `file`-type field is re-rendered with the module's own field
formatter, `md_file_attachment_file_embed` (`MdFileAttachmentFieldFormatter`), configured from
`markdownify_file_attachment.settings`. That formatter, for each referenced file, compares the
file's extension against `allowed_extensions` and its size against `max_file_embed_size`
(capped at the PHP upload max): if both pass it reads the file from disk
(`file_get_contents(realpath)`) and inlines the contents into the Markdown ("Attached file X …
follows: <contents>"); otherwise it emits just the filename, extension and absolute URL.
Defaults are `allowed_extensions: [txt, yml, yaml, wsdl, json]` and `max_file_embed_size:
1 MB`. Configuration is at `/admin/config/services/markdownify/file-attachment` (settings form
`markdownify_file_attachment.settings`, gated by the core `administer site configuration`
permission). It requires core `file` and the parent `markdownify`, needs Drupal 10.2+, and has
no permissions or plugin types of its own.

---

- Inline the contents of an attached `.txt` readme into a node's Markdown so an AI reads it directly.
- Embed a `.json` data file attached to content into the Markdown output.
- Expose attached `.yml`/`.yaml` config samples inline for documentation crawlers.
- Give LLM ingestion pipelines the text of small attachments without a second fetch.
- Limit which file types are embedded via the `allowed_extensions` setting.
- Cap inline embedding to a size (e.g. 1 MB) with `max_file_embed_size` so huge files are only linked.
- Fall back to a filename + absolute URL for disallowed types or oversized files.
- Add `.md` or `.csv` to the allowed list to embed those attachments too.
- Include `.wsdl` service descriptions inline for API-doc content.
- Provide attachment context to an AI agent summarising a page.
- Keep large binaries (images, PDFs) as links while inlining small text files.
- Configure embedding centrally for all `file` fields at once (applies to every file field).
- Surface log/manifest text files attached to release notes in Markdown.
- Combine with the parent module's `.md` routes to serve attachment-rich Markdown pages.
- Tune allowed extensions per site policy from a single settings form.
- Ensure attachment data appears in `/node/1.md` alongside the body content.
- Let a knowledge base expose attached snippets to retrieval-augmented generation.
- Standardise how file fields appear across all Markdown output.
