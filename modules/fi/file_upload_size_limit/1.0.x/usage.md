<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Upload Size Limit adds client-side (JavaScript) file-size limiting to file fields, warning users before an over-size file is uploaded.

---

File Upload Size Limit (JS) adds client-side file-size limiting to file/upload fields — using
JavaScript to check a selected file's size in the browser and warn/block before the upload starts, so
users get immediate feedback instead of waiting for a server rejection. It depends on core File and is
configured at `file_upload_size_limit.settings`.

Use it to improve upload UX by catching over-size files early. **Important security caveat: this is a
client-side (JavaScript) check only — it is a usability aid, not a security control.** A client-side
size limit is trivially bypassed (disable JS, craft the request directly), so it must **not** be relied
on to enforce upload limits. The real, enforced limits come from Drupal field settings and PHP
configuration (`upload_max_filesize`/`post_max_size`); keep those set correctly server-side. Treat this
module purely as front-end feedback layered on top of the server-enforced limits.

---

- Limit upload size in the browser.
- Warn before an over-size upload.
- Give immediate upload feedback.
- Depend on core File.
- Configure at file_upload_size_limit.settings.
- Catch over-size files early.
- Improve upload UX.
- Know it is client-side only.
- Not rely on it as a security control.
- Understand it is trivially bypassable.
- Enforce real limits server-side.
- Set PHP upload_max_filesize.
- Set field size limits server-side.
- Treat it as front-end feedback.
- Avoid server rejections after wait.
- Layer on server-enforced limits.
- Block large files in JS.
- Provide upload-size UX.
- Warn on file selection.
- Not enforce limits (JS only).
