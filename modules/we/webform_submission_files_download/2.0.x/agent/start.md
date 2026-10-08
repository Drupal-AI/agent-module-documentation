<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submission Files Download — agent start

**What**: Adds a per-submission **Files download** op that zips all managed files of one
webform submission. Depends on `webform` + `pclzip/pclzip`. Permission-gated.

## Set up
1. `composer require pclzip/pclzip`; `drush en webform_submission_files_download -y`.
2. Grant **download any webform submission managed files** to trusted roles.
3. Use the **Files download** operation on a submission (or hit the route directly).

## Key facts
- Route: `entity.webform_submission.files_download`
  `/admin/structure/webform/manage/{webform}/submission/{webform_submission}/files_download`,
  `_permission: 'download any webform submission managed files'` (restrict access).
- Controller `DefaultController::download_download()` collects file IDs from the webform's
  managed-file elements, zips real paths, returns a `BinaryFileResponse` (force-download).
- Permission is admin/staff-level ("any" submission), not per-owner.
