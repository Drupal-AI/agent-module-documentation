Sub-module of Advanced FileSystem that uses a drupal/ai vision provider to suggest SEO-friendly, lowercase-hyphenated filename slugs for image files and apply them per file, in bulk, or automatically on upload.

---

Advanced Filesystem AI Smart Image sends each image (downscaled and re-encoded to JPEG via GD) to a `drupal/ai` provider that supports the `chat_with_image_vision` operation, along with a configurable prompt, and receives back a single descriptive slug such as `blue-ceramic-mug-top-view`. The slug is sanitized to lowercase letters, digits and hyphens, stored per file in the `adfs_ai_smart_filename` table with a lifecycle status (`suggested` → `applied`/`skipped`, or `failed`), and surfaced three ways: a per-file AJAX form at `/admin/content/files/{fid}/smart-filename` (preview, generate, edit, apply/skip), a Batch-API bulk form, and optional `hook_file_insert` auto-suggest/auto-apply on upload. Applying uses one of two modes — *display name only* (updates `file_managed.filename`, leaves the URI and disk file untouched — safe for referenced files) or *full rename* (moves the file on disk and updates the URI). Filename conflicts are detected against `file_managed` and resolved automatically with `-1`, `-2` suffixes. All API credentials, endpoints and TLS are owned by `drupal/ai`; this module holds no keys and makes no direct HTTP calls. Two permissions gate it: an administer permission for settings/batch and a `use` permission for the per-file form.

---

- Replace meaningless camera filenames (`IMG_4821.jpg`) with descriptive slugs (`golden-retriever-puppy-grass.jpg`) for SEO and findability.
- Rename screenshot dumps (`Screenshot 2026-06-01 at 10.14.png`) into human-readable names automatically.
- Generate a filename suggestion for a single image from the admin file list via the "AI Smart Filename" operation link.
- Review, hand-edit, and apply a slug for one image on the per-file AJAX form without a page reload.
- Bulk-generate suggestions for every unprocessed managed image using the Batch-processing form.
- Re-process already-processed images (regenerate slugs) by ticking "Re-process already-processed images" in the batch form.
- Limit a batch run to a maximum number of files to control AI cost per run.
- Restrict processing to specific image MIME types (JPEG, PNG, WebP, GIF, AVIF).
- Automatically suggest a filename the moment an image is uploaded (`auto_suggest_on_upload`).
- Automatically apply the suggested name on upload for a fully hands-off rename pipeline (`auto_apply_on_upload`).
- Keep file references intact by using *display name only* mode, which changes only the shown filename.
- Physically rename files on disk (and update the URI) with *full rename* mode for freshly uploaded, not-yet-referenced files.
- Avoid filename collisions: the module checks `file_managed` and appends `-1`, `-2`… automatically before applying.
- Downscale large images to a configurable max side (default 1024 px) before sending, reducing AI payload size and avoiding provider size limits.
- Tune the vision prompt to your house style (word count, language, allowed vocabulary) from the settings form.
- Track a suggestion lifecycle per file (suggested, applied, skipped, failed) in the `adfs_ai_smart_filename` table.
- Monitor progress with the live statistics dashboard on the settings page (total, unprocessed, suggested, applied, skipped, failed).
- Mark individual images as "skipped" so they are excluded from future default batch runs.
- Swap the underlying vision model by changing the default `chat_with_image_vision` provider in AI settings — no code change here.
- Delegate all API-key handling and TLS to `drupal/ai`, so this module stores no credentials.
- Run a controlled cost pilot: enable for a small role via the `use` permission before rolling out site-wide.
- Improve accessibility/asset-management workflows by giving media libraries meaningful, searchable filenames.
