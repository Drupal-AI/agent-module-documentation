<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File History provides a custom Form API element (`file_history`) and field widget for uploading/selecting a file while retaining a history of previously uploaded versions — aimed at managing successive versions of a configuration file. It also exposes a controller route for downloading the managed (non-public) files.

---

- Requires core `file`; Drupal 10.
- Enable with `drush en file_history`.
- Use the `file_history` form element in a custom form (set the mandatory `#upload_location`, plus optional `#no_upload`/`#no_use`/`#no_download`, `#legacy`, `#create_missing`).
- Or use the provided field widget on a file field.
- Files are downloaded via `/file_history/download/{file}` (permission: "download file histoy files").
- A test submodule (`test_file_history`) demonstrates the element in example forms.

---

- Keep a history of uploaded versions of a file.
- Re-use a previously uploaded file instead of re-uploading.
- Provide a download link for managed/non-public files.
- Embed a versioned file picker in custom forms.
- Manage a canonical configuration file with change history.
- Toggle upload/use/download affordances per element.
- Support a legacy mode and auto-create-missing option.
- Require a specific upload location per element.
- Integrate as a field widget on file fields.
- Restrict downloads behind a dedicated permission.
- Show progress indicator during upload.
- Validate uploads with standard file validators.
- Roll back to an earlier uploaded version.
- Audit who changed a configuration file over time.
- Use the test submodule as an implementation example.
- Track file usage for retained versions.
