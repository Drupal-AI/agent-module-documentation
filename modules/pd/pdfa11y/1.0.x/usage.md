<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDFa11y checks PDF files uploaded through Drupal's Media system for accessibility compliance and records the results against the media item, so the accessibility of documents is visible inside Drupal rather than discovered later by a reader using a screen reader.

---

Accessibility work usually stops at the HTML boundary: a site can pass WCAG audits while its published PDFs have no tag structure, no document language, no title, and no logical heading order — and PDFs are often the documents that matter most, being the forms, policies, and reports people actually need. PDFa11y extends checking inward. When a media entity whose source field accepts `.pdf` is created or its file changes, the module parses the file in-process with the `smalot/pdfparser` library and runs a configurable set of check plugins: tagged-PDF structure, heading hierarchy (starts at H1, no skipped levels), document title, title-is-not-a-filename, document language, and minimum PDF version. Each result (pass, fail, or error) is stored in the `pdfa11y_results` table and shown on a per-media "Accessibility" tab, as a status badge on the media view, and in a site-wide Views report under Reports. At upload the module can either warn editors or, with `block_failed_uploads` on, hard-block a failing PDF via a file-entity validation constraint — with a `bypass blocked pdf uploads` permission for trusted editors. The check set is an extensible plugin type (`AccessibilityCheck`), so developers can add their own checks. For existing libraries there is a Drush command (`pdf-accessibility:check`, alias `pa:check`) and a cron queue worker (`pdfa11y_check`) that batch-check media, with file-size and image-payload guards plus optional forked-subprocess isolation so a single memory-heavy document cannot abort a bulk run. Permissions are split four ways (administer, run checks, view reports, view help) so visibility and re-checking can be granted without the ability to change the ruleset. Requirements: PHP 8.1+, core `^10.2 || ^11`, core `media` and `file`, and `smalot/pdfparser ^2.0` via Composer.

---

- Check an uploaded PDF for accessibility problems automatically on upload.
- Block editors from saving a PDF that fails accessibility checks.
- Warn editors about accessibility issues without blocking the save.
- Grant trusted editors a bypass to save a flagged PDF anyway.
- Find PDFs missing a document title, language, or tag structure.
- Flag PDFs whose title is just a leftover filename.
- Enforce a minimum PDF version for accessibility features.
- Show an accessibility status badge on each media item.
- Give editors a per-document report with remediation guidance.
- Re-run checks after a document is replaced.
- Audit an existing library of PDFs from the command line.
- Enqueue a large PDF library and drain it via cron.
- Resume an interrupted bulk check after a given file id.
- Export accessibility results as CSV or JSON for reporting.
- Build a site-wide Views report of failing documents.
- Add a custom accessibility check as a plugin.
- Support a public-sector accessibility obligation (WCAG, Section 508, ADA).
- Prioritise which documents to remediate first.
- Evidence an accessibility statement with stored results.
- Keep PDF analysis in-process rather than depending on an external service.
- Guard bulk runs against out-of-memory on image-heavy scanned PDFs.
- Track document accessibility over time.
- Complement HTML accessibility tooling with document coverage.
- Provide editors an in-Drupal guide to creating accessible PDFs.
