<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Download All Files adds a "download everything" link to a core File or Image field — a formatter that bundles an entity's attached files into a single zip generated on demand.

---

Any page carrying several documents produces the same request: a tender with twelve annexes, a course with its handouts, a planning application with its drawings, a press kit. Downloading them one at a time is tedious and error-prone, and the alternative most sites reach for is asking editors to upload a second, manually maintained zip that immediately falls out of step with the field it duplicates. Generating the archive on demand from the field itself removes that whole class of problem. You use it by choosing the **Table of files with download all link** formatter (`file_download_all`) on a `file` or `image` field's **Manage display**; the field then renders as a table of its files with one **Download All** link. That link points at `/download_all_files/{entity_type}/{entity}/{field_name}`, whose controller loads each referenced file, adds it to a `\ZipArchive`, and streams the result as an attachment named after the entity and field. The formatter has several display options — link text and icon, a `details` disclosure wrapper, a header-vs-above link position, a "simple theme" (name + direct download link), and using each file's description as its link text. It depends only on core's **File** module, runs on Drupal `^10.2 || ^11`, ships no settings page or permissions, and is minimally maintained (maintenance fixes only) with security-advisory coverage.

---

- Download all a page's attachments at once.
- Bundle a tender's annexes into a zip.
- Provide a course's handouts together.
- Download a press kit as one file.
- Avoid a manually maintained zip file that drifts.
- Offer all drawings on a planning page.
- Add a "download all" link to a node's file field.
- Bundle report appendices.
- Provide a dataset's files together.
- Reduce clicks on a documents page.
- Keep the archive in step with the field.
- Show attachments as a table with file sizes.
- Use each file's description as its link text.
- Wrap the file table in a collapsible details disclosure.
- Bundle a product's specification sheets.
- Download meeting papers as one file.
- Provide conference materials together.
- Package a project's deliverables.
- Simplify a document library page.
- Offer bulk download of an image field's files.
