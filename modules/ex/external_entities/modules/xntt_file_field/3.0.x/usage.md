# xntt_file_field — usage

External Entities file and image fields support. This submodule lets file and image fields on an
external entity type be backed by a file path or URL coming from the remote source, instead of a Drupal
managed-file id. Once a field uses the provided File field mapper, all the usual file/image features —
image styles, field formatters, Views, lightboxes — work on the remote files.

---

It ships a `file` field mapper (for `file` and `image` field types) and a custom `xntt://` stream
wrapper. On load, external file fields are given synthetic ids of the form
`xntt-{type}-{id}-{field}#{delta}`; hooks intercept those ids, resolve them through the stream wrapper
to the real source URI, and let Drupal read the file (for example to build an image-style derivative).
Access is read-only — original files are never altered. An optional per-mapping regular expression can
restrict which URIs are accepted, and a forced file extension can be set when a URL omits one.

---

- Show a remote image URL as a Drupal image field with image styles.
- Attach a remote document URL as a file field on an external entity.
- Generate and cache local thumbnails from remote images.
- Use standard image/file field formatters on externally-sourced media.
- Restrict accepted URIs with a regular expression (e.g. only a trusted host).
- Restrict accepted URIs to HTTPS URLs only.
- Force a file extension when the source URL lacks one so the MIME type is detected.
- Map extra properties such as image Alt text and Title from the source.
- Use remote images in Views and slideshows that rely on file/image fields.
- Reference remote files without importing them into Drupal's file system.
