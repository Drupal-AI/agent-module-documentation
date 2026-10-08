PDF Metadata automatically writes Title/Author/Subject/Keywords into uploaded PDF files, using entity token patterns configured per file field.

---

PDF Metadata extends Drupal core's File module so that PDF documents attached to content pick up metadata from the entity that owns them. On each supported **file field** — or an **entity-reference field** pointing at file-bearing entities such as media — you enable the feature in the field's settings and enter token patterns (e.g. `[node:title]`) for Title, Author, Subject and Keywords. When the host entity is saved (insert or update), an event subscriber resolves those tokens against the entity and writes the resulting values into every attached PDF. The actual write is delegated to a pluggable provider layer: **Ghostscript** (the default; regenerates the PDF and may flatten interactive forms) or **ExifTool** (edits metadata in place and preserves fillable forms), with automatic fallback to whichever tool is installed. A site-wide settings form lets an administrator pick the provider, report which tools are available on the server, set a custom ExifTool binary path, and pass extra Ghostscript command options. At least one of the two command-line tools must be installed on the server for the module to do anything.

---

- Set a PDF's Title from the parent node's title automatically on every save, using `[node:title]`.
- Stamp the site name and author into every uploaded brochure or datasheet PDF for consistent document properties.
- Populate PDF Keywords from a node's tag/taxonomy tokens to improve document searchability and asset management.
- Keep PDF Author metadata in sync with the content author (`[node:author:display-name]`).
- Apply metadata to PDFs stored on **media entities** by enabling the feature on the media's file field.
- Drive PDF metadata from a **parent node** through an entity-reference (or media) field, so parent tokens populate the referenced file's metadata.
- Re-brand a batch of legacy PDFs by resaving their host content (e.g. `drush entity:save node --bundle=article`).
- Preserve fillable PDF form fields while still updating document properties by selecting the ExifTool provider.
- Use Ghostscript on managed hosting (Acquia, Platform.sh) where `gs` is already available and no extra install is possible.
- Provide a custom ExifTool binary path when the tool lives in a non-standard directory.
- Add extra Ghostscript command-line options (one per line) for sites with specific PDF-generation requirements.
- Give document-heavy sites (reports, contracts, whitepapers) uniform, token-driven PDF document properties without manual editing.
- Ensure PDF Subject metadata reflects a summary/field token for internal document taxonomy.
- Support multi-provider environments where either Ghostscript or ExifTool may be present, relying on automatic fallback.
- Diagnose provider availability from the admin UI, which shows detected binary paths and install instructions.
- Only touch genuine PDFs — non-PDF uploads are skipped by MIME check, so mixed file fields are safe to enable.
- Standardise Title and Keywords across a content type by enabling the field once and letting saves propagate metadata.
- Keep document metadata current as content is edited, since the write fires on both insert and update.
- Enforce a fixed literal Author or copyright string across all uploaded PDFs by using a non-token literal value.
- Combine with the Token module's token browser to build patterns from any available entity token.
