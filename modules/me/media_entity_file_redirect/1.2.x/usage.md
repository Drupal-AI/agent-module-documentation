Media Entity File Redirect adds a `/document/{media}` route that 302-redirects to the actual file URL of a file-source media entity, giving files a stable, media-id-based URL. It also ships optional Linkit integration so editors can link to that path.

---

The module registers one route, `media_entity_file_redirect.file_redirect` at `/document/{media}` (`{media}` constrained to `\d+`), whose access is `_entity_access: media.view` — i.e. the same view access as the media entity. `MediaEntityFileRedirectController::redirectToFile()` loads the media type, and only proceeds if the media's source is a core `File` source AND the media type has the module's third-party setting `enabled` turned on (off by default); otherwise it throws a 404. It then loads the file from the source field value and returns a `CacheableRedirectResponse` to the file's absolute URL (generated via `file_url_generator` inside a render context to capture cache metadata), varying by `url.site` and adding the media type, media, and file as cache dependencies. The redirect target is derived entirely from the file's own URI — it is never taken from a request parameter, so there is no open-redirect surface, and access is enforced by `media.view` (private-file URIs still route through core's own file access on download). The per-media-type toggle is added to the media type edit form by `media_entity_file_redirect.module` (`hook_form_media_type_edit_form_alter` + an entity builder) and stored as `media.type.*.third_party.media_entity_file_redirect.enabled` (schema in `config/schema`). Two optional Linkit plugins let editors pick this path in the Linkit autocomplete dialog: a Matcher (`entity:media_entity_file_redirect`) that returns `/document/{id}` instead of `/media/{id}`, and a Substitution (`media_file_redirect`) usable as a Linkit profile substitution. There are no permissions, no settings page (`configure` null), and no Drush commands.

---

- Give file-based media a clean, stable `/document/{id}` URL that redirects to the real file.
- Let site visitors download a media file without exposing the raw `/sites/default/files/...` path in links.
- Provide a permanent link to a document that keeps working even if the file is replaced on the media entity.
- Enable file redirect only for specific media types (e.g. "Document", "PDF") via the per-type toggle.
- Keep media canonical pages disabled while still offering a working file URL.
- Link to a media file from CKEditor using Linkit's `Media: File Redirect` matcher.
- Use the `media_file_redirect` Linkit substitution in a Linkit profile so links resolve to the file.
- Serve PDFs/documents through a memorable URL for print or email distribution.
- Respect media view access on file links (the redirect uses `media.view`).
- Return a proper 404 for media types where the redirect feature is not enabled.
- Vary the redirect cache per site URL to support multi-domain setups correctly.
- Avoid confusing editors with `/media/{id}` paths in the Linkit dialog (matcher shows `/document/{id}`).
- Build "download" buttons/fields that point at `/document/{id}` for file media.
- Support both public and private file schemes (private files still enforce core file access on download).
- Attach cache metadata (media type, media, file) so redirects invalidate correctly.
- Migrate legacy document URLs to media entities while keeping a predictable path pattern.
- Expose a REST/JSON-friendly stable file URL keyed by media id.
