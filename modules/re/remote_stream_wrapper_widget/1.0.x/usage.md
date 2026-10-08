Remote Stream Wrapper Widget adds a single field widget (`remote_stream_wrapper`) that lets an editor populate a core **File** or **Image** field by typing a remote `http://`/`https://` URL instead of uploading a file, storing it as a Drupal `file` entity with a remote URI (via the Remote Stream Wrapper module).

---

The module is tiny: one `WidgetBase` plugin, no config, no permissions, no schema. The widget renders a single `#type => url` element per field delta (required if the field is required), pre-filled with the existing file's URI when one is set. On save, `massageFormValues()` looks up an existing `file` entity by that URI and, if none exists, **creates** a new `file` entity (`uri` = the entered URL, `uid` = current user) and saves it, then stores its `target_id` on the field. The actual remote-file handling — registering the `http`/`https` stream wrappers and fetching bytes when the file is read — is provided by the required `remote_stream_wrapper` (^2.1) dependency, not by this module. You attach the widget on an entity's *Manage form display* tab for any `file`/`image` field. It does no MIME/extension validation of its own and stores whatever URL passes the browser's `url` input, so it is best used for fields whose sources are trusted (e.g. a curated CDN).

---

- Reference an externally hosted image by URL instead of uploading it to the site.
- Point a File field at a document on a CDN or partner server.
- Populate a media/file field from a remote asset library without duplicating the bytes locally.
- Let editors embed images that live on an external DAM (digital asset manager).
- Avoid storing large binaries in the local filesystem by keeping them remote.
- Swap an uploaded file for a remote URL on an existing File/Image field.
- Reuse a single remote file entity across multiple entities (dedup by URI on save).
- Provide a URL-based fallback when a normal file upload widget is impractical.
- Attach the widget to an Image field to render a remote image via the file entity.
- Migrate content that already references remote URLs into File fields.
- Keep a canonical remote source (e.g. `https://cdn.example.com/logo.png`) as the field value.
- Build galleries or attachments that mix local uploads and remote URLs across entities.
- Feed remote video/audio file URLs into a File field for downstream formatters.
- Populate File fields programmatically-adjacent workflows where the URL is known at edit time.
- Let non-technical editors set a file source with a plain URL text box.
- Use with the Remote Stream Wrapper API so `http(s)://` URIs behave like Drupal file URIs.
- Replace a file source by editing the URL field rather than re-uploading.
- Track remote assets as first-class `file` entities (with fid, usage, etc.).
