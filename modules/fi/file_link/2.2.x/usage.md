File Link provides a `file_link` field type that extends core's Link field to point **only at files** and automatically stores each target file's **size** and **MIME type** as extra field metadata.

---

The module's core is the `file_link` field type (`Drupal\file_link\Plugin\Field\FieldType\FileLinkItem`,
extending core's `LinkItem`). On top of a normal link (uri + title) it adds two stored columns,
`size` (int) and `format` (MIME type string), populated by performing an HTTP request to the
target URL when the field is saved (reading `Content-Length` and `Content-Type` headers). A site
builder configures, per field, the **allowed target file extensions** (`file_extensions`, default
`txt`), whether **URLs with no extension** are allowed (`no_extension`), and whether metadata
fetching is **deferred to cron** (`deferred_request`) instead of done immediately on save. A
`LinkToFile` validation constraint enforces that the URI points to a file (with an allowed
extension), not a directory. It ships the `file_link_default` widget and two formatters —
`file_link` (a single link that can show the formatted file size) and `file_link_separate` (title
and link rendered separately) — plus their Twig templates and a `format_size` formatter option.
Deferred requests are handled by the `file_link_metadata_update` queue worker, which updates
size/format for queued entities during cron. Two `settings.php` flags tune HTTP behaviour:
`file_link.follow_redirect_on_validate` (default TRUE) toggles following redirects during
validation, and `file_link.disable_http_requests` (default FALSE) turns off all HTTP requests
entirely — recommended for bulk content imports. The module has no admin settings page
(`configure: null`), no permissions and no Drush; everything is configured through the field's
storage/field/display settings.

---

- Add a "Download" field that links to a file and shows its size and type automatically.
- Store a document's MIME type and byte size alongside the link without a managed File entity.
- Restrict a link field so editors can only point it at PDF files (`file_extensions: pdf`).
- Allow several download types by listing multiple extensions (e.g. `pdf doc docx zip`).
- Display a formatted human-readable file size (e.g. "1.2 MB") next to a download link.
- Render the link title and the URL separately with the `file_link_separate` formatter.
- Link to external files on another server and capture their size/type via an HTTP HEAD/GET.
- Allow extension-less URLs (e.g. API endpoints) with the `no_extension` setting.
- Validate that a link points to a real file, not a directory, using the LinkToFile constraint.
- Defer metadata fetching to cron for large imports so saves stay fast (`deferred_request`).
- Process queued metadata updates via the `file_link_metadata_update` queue worker on cron.
- Disable all outbound HTTP during a migration with `$settings['file_link.disable_http_requests'] = TRUE`.
- Stop following redirects during validation with `$settings['file_link.follow_redirect_on_validate'] = FALSE`.
- Show attachment metadata on a publications or resources content type.
- Build a media/downloads listing where each row exposes file size for the visitor.
- Capture file size/type for reporting or Views without importing the file into Drupal.
- Provide a consistent download component across content types using one field type.
- Keep link fields honest by rejecting links to disallowed extensions on validation.
- Re-fetch size/format automatically whenever the URL or entity changes on save.
- Offer a "spec sheet" link that displays the document's format to end users.
- Use the stored `size`/`format` properties in tokens, Views fields, or theme code.
- Migrate legacy file references to metadata-aware links without managed files.
- Present a separate, accessible link label and URL for screen-reader-friendly downloads.
