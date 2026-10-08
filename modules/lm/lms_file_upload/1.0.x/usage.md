<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS File Upload provides an ActivityAnswer plugin to allow file uploads to the private file system for the LMS module.

---

LMS File Upload provides an ActivityAnswer plugin for the LMS module — allowing learners to answer a
course activity by uploading a file, stored in Drupal's **private file system** so the submissions aren't
publicly accessible. It depends on core File and the LMS module, in the LMS package.

Use it for file-upload assignments in an LMS course. The security-relevant points are handled well and worth
keeping correct: submissions go to the **private filesystem** (good — private-scheme files are access-checked
on download rather than served directly), so ensure the private file system is configured and that download
access is restricted to the appropriate users (learner/instructor); and, as with any user upload, keep
allowed extensions restricted (core's upload validation) to prevent dangerous file types. It has no
access-control role of its own beyond the LMS/file access. Configure the activity and allowed file types.

---

- Allow file-upload answers in the LMS.
- Store submissions in the private filesystem.
- Provide an ActivityAnswer plugin.
- Depend on core File and LMS.
- Keep submissions non-public (private scheme).
- Ensure the private filesystem is configured.
- Restrict download access appropriately.
- Keep allowed extensions restricted.
- Prevent dangerous file types.
- Have no access-control role of its own.
- Configure the activity.
- Handle file-upload assignments.
- Upload course answers.
- Configure allowed file types.
- Store learner uploads privately.
- Handle LMS uploads.
- Restrict submission access.
- Configure the plugin.
- Accept file answers.
- Upload to private files.
