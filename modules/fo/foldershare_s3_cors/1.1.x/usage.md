<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enables direct-to-S3 uploads for FolderShare files.

---

FolderShare S3 CORS enables FolderShare files to be uploaded directly to S3 — configuring CORS so a browser can upload a file straight to an S3 bucket (bypassing the Drupal server for the file transfer), improving large-file upload performance for the FolderShare file-management module.

S3 credentials/bucket config should be stored securely (env-backed) and the bucket CORS/policy scoped tightly. Depends on `foldershare`; supports Drupal 10 and 11.

---

- Enable direct-to-S3 uploads.
- Configure CORS for browser upload.
- Bypass Drupal for the transfer.
- Speed up large-file uploads.
- Serve the FolderShare module.
- Store S3 credentials securely.
- Scope the bucket policy tightly.
- Depend on `foldershare`.
- Support Drupal 10 and 11.
- Configure the connection.
- Aid file management.
- Handle S3 uploads
- Support Drupal.
- Support Drupal.
- Support Drupal.
