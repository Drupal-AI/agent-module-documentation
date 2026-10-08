<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Files Upload provides a files upload system.

---

Files Upload provides a file-upload system — a UI/mechanism for uploading and managing files on the
site, as an alternative or complement to core's file handling. Use it where a dedicated upload
system is wanted.

Security note common to any upload feature: the safety rests on Drupal's **server-side upload validation** —
restrict allowed **file extensions**, enforce size limits, and store uploads where they aren't web-executable
(private file system for non-public/sensitive files) so a malicious upload (e.g. a script) can't be executed
or served. Restrict who can upload. It is a content-editing/upload feature with no access-control role beyond
that. Configure the upload behaviour and restrictions.

---

- Provide a file-upload system.
- Upload and manage files.
- Complement core file handling.
- Rely on server-side upload validation.
- Restrict allowed file extensions.
- Enforce size limits.
- Store uploads non-web-executable.
- Use the private FS for sensitive files.
- Restrict who can upload.
- Have no access-control role beyond that.
- Configure upload restrictions.
- Handle file uploads.
- Manage uploads.
- Configure the system.
- Handle uploads securely.
- Restrict uploads.
- Handle file management.
- Configure uploads.
- Validate uploads.
- Manage files.
