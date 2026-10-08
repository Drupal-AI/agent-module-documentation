<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submission Files Download

Adds a **Files download** operation to each webform submission that gathers every managed
file uploaded through that submission's file elements, zips them, and streams the archive
back to the browser. Access is controlled by a single dedicated permission,
**download any webform submission managed files** (`restrict access: TRUE`). Requires the
`pclzip/pclzip` library.

---

## Summary

`hook_entity_operation()` adds a `files_download` operation linking to route
`entity.webform_submission.files_download`
(`/admin/structure/webform/manage/{webform}/submission/{webform_submission}/files_download`),
guarded by `_permission: 'download any webform submission managed files'`. The controller
`DefaultController::download_download()` loads the webform and submission, iterates the
webform's managed-file elements (`getElementsManagedFiles()`), collects each element's file
IDs from the submission, loads the `File` entities, adds their real paths to a temporary zip
via the archiver plugin, and returns a `BinaryFileResponse` with force-download headers.

The permission is the sole access gate — it is an admin/staff-level "download **any**
submission's files" grant. Grant it only to trusted roles.

---

## Use cases

- Let staff download all files from one submission as a single zip.
- Bundle a job applicant's CV + attachments into one archive for review.
- Retrieve all uploaded documents for a support/intake submission at once.
- Add a quick "download files" action to the submission listing for admins.
- Collect multi-file uploads (photos, receipts) per submission for processing.
- Hand off a submission's attachments to another team as one file.
- Archive a submission's managed files for record-keeping.
- Avoid clicking through individual file elements to save uploads one by one.
- Give a reviewer role controlled access to submission attachments via one permission.
- Export attachments for a grant/scholarship application submission.
- Package event-registration uploads (ID, waivers) for check-in staff.
- Provide a repeatable download of a submission's files during moderation.
- Combine with Webform submission views to reach the download action fast.
- Zip large sets of uploads server-side rather than manually.
- Keep the download capability behind a restricted, auditable permission.
