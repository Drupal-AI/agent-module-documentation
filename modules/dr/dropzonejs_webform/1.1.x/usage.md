<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform DropzoneJS adds a DropzoneJS-backed drag-and-drop upload element to Webform, giving previews and progress in place of the plain file input.

---

The module provides one Webform element, **DropzoneJS**, listed in the webform element browser under **File upload elements**. It is version **1.1.0** and runs on `^9 || ^10 || ^11`, and it has two hard dependencies: **`webform`** and **`dropzonejs`**. The `dropzonejs` dependency is not pulled in automatically by this project's composer metadata, so it must be installed first (along with the Dropzone JS library that `dropzonejs` itself needs) — enabling `webform_dropzonejs` without `dropzonejs` present fails with a missing-dependency error. Once enabled, add the **DropzoneJS** element to any webform and configure it like a normal managed-file element: allowed file extensions, whether multiple files are accepted (`#multiple`), maximum file size in megabytes, whether the field is required, and the upload destination (the file storage scheme and directory the saved files are written to). Because the element extends webform's `WebformManagedFileBase`, its allowed-extensions setting falls back to the site default at `webform.settings` → `file.default_managed_file_extensions` when left blank, and submitted files become permanent Drupal `file` entities attached to the submission. On the front end the widget lets submitters drag files in, shows a thumbnail preview for images, reports progress, and offers remove links; on an existing submission the previously-uploaded files are re-shown in the Dropzone and can be removed. Uploads reuse the `dropzonejs` core upload endpoint, which is gated by the core **`dropzone upload files`** permission — grant that permission to the roles (including anonymous, for public forms) that should be able to use the element.

---

- Add a drag-and-drop upload element to a webform.
- Collect a CV or resume on a job-application form.
- Attach supporting documents to a grant or funding submission.
- Accept photographs on an insurance or damage claim form.
- Upload artwork or entries for a competition form.
- Let submitters upload several files at once in one field.
- Show image thumbnails as files are added to the form.
- Show upload progress on a form with large attachments.
- Replace the plain `<input type="file">` widget with a nicer uploader.
- Accept scanned documents on a public request form.
- Collect evidence or attachment files on a report-a-problem form.
- Upload a portfolio or work samples on an application.
- Restrict accepted files to a specific extension list per element.
- Cap the number of files a submitter may attach.
- Cap the maximum size of each uploaded file.
- Make a file upload mandatory on a webform.
- Store submitted files in a private file directory.
- Re-show and let users remove already-attached files when editing a submission.
- Accept documents on a tender or procurement form.
- Add multi-file upload to a contact or intake form.
