Plupload Integration adds a `plupload` Form API element that wraps the Plupload JavaScript library, giving Drupal forms a chunked, multi-file, drag-and-drop upload widget that can move large files past normal PHP upload limits.

---

The module's entire public surface is a single render/form element of `#type` `plupload` (`\Drupal\plupload\Element\PlUploadFile`, a `@FormElement`). When rendered it attaches the `plupload/plupload` library and points the browser at the `plupload.upload` route (`/plupload-handle-uploads`, permission `access content`, CSRF-protected) which streams each chunk to a temporary directory and returns JSON. The element does **not** create `file` entities or move files itself: after submit, `$form_state->getValue('<element>')` returns an array of uploaded-file descriptors — each with `name`, `tmpname`, `status`, and a convenience `tmppath` (the full `temporary://…tmp` URI) — and your submit handler is responsible for validating and saving them (e.g. copying to a destination and creating `File` entities). Server-side validation is applied through core's `FileValidator` using `#upload_validators` (notably `FileExtension`), and filenames are sanitized/transliterated in the element's value callback. The only configuration is `plupload.settings:temporary_uri` (default `temporary://`), the scheme where in-progress chunks are stored — useful to point at shared storage in HA setups. There is no admin UI, no configure route, no permissions of its own, and no Drush. The bundled `plupload_test` submodule provides a demo form at `/plupload-test`.

---

- Add a chunked, resumable upload widget to a custom form so editors can upload very large files (video, archives) past `upload_max_filesize`.
- Let users select and upload **multiple** files at once with a single drag-and-drop area.
- Build a bulk media importer form where dozens of images are queued and uploaded in one go.
- Provide an AJAX auto-upload field that starts sending bytes as soon as a file is chosen (`#autoupload`).
- Auto-submit a form once uploads complete (`#autoupload` + `#autosubmit`).
- Restrict uploads to specific extensions server-side via `#upload_validators['FileExtension']`.
- Enforce a maximum file size on a Plupload element with core file validators.
- Accept a ZIP upload for a site importer and process it in a submit handler (as `plupload_test` does).
- Move uploaded files into a private stream and create managed `File` entities in your own submit handler.
- Point in-progress chunk storage at a shared `temporary://` location for a load-balanced / HA environment (`temporary_uri`).
- Show core's file-upload help text and allowed-extensions hint automatically under the widget.
- Give a long-running import UI a client-side progress bar for each file.
- Wire custom Plupload JS event callbacks (`#event_callbacks`) to a form element for progress or error handling.
- Trigger a specific submit button when uploads finish (`#submit_element`).
- Pass custom Plupload runtime settings (chunk size, filters, URL) via `#plupload_settings`.
- Replace a stock `managed_file` field on a bespoke form when browser upload limits are a problem.
- Collect user-supplied documents (PDF, DOC, ODT) on a submission form with extension whitelisting.
- Sanitize and transliterate uploaded filenames automatically before saving.
- Rename dangerous executable-looking uploads to `.txt` unless `allow_insecure_uploads` is set (inherited safety behavior).
- Handle uploads in code without core's `file_save_upload()`, using the descriptor array (`name`/`tmppath`/`status`).
- Build an avatar or attachment uploader in a multistep wizard where files are staged in `temporary://` before final save.
- Provide a CSRF-protected upload endpoint out of the box for authenticated (`access content`) users.
- Prototype and QA the element quickly with the `plupload_test` demo form at `/plupload-test`.
