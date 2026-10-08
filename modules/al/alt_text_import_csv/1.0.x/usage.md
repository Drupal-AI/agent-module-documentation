<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alt text import CSV bulk-updates the alt text on images referenced by content, from an uploaded CSV of page URL, image URL and new alt text.

---

Alt text import CSV adds an admin form at *Configuration › Media › Alt text CSV import* where you upload a CSV whose three columns are **page URL, image URL, alt text**. For each row it resolves the image URL to a managed `file` entity (unwinding image-style derivative paths), uses the **Entity Usage** module to find every content entity that references that file, ascends the reference chain (paragraph → node, media → node, etc.) to confirm the entity is displayed at the given page URL, and writes the new alt text onto the matching image reference field, then saves the host entity. Processing runs in a Batch API job so large files import row by row. An optional email report lists any rows that failed to import, and a results page shows the same failures in a table. Two settings control matching behaviour: whether to update *all* host entities when the page URL cannot be matched, and whether to restrict updates to media host entities only. It depends on core **Media** and **Path**, plus the contrib **Entity Usage** and **Multivalue form element** modules, and is gated by its own restricted permission.

---

- Fix missing or wrong image alt text across a whole site in one bulk operation for accessibility (WCAG) remediation.
- Import alt text produced by an external accessibility audit or spreadsheet as a CSV.
- Update alt text for images embedded in nodes via paragraphs, media references or nested entity references.
- Apply alt text to images displayed on a specific page by matching the page's canonical URL / path alias.
- Update alt text on Media entities only, ignoring other host entity types, via the *media only* setting.
- Update alt text on images used in site-wide block content (which Entity Usage cannot tie to a page) via the *update all host entities* setting.
- Import from CSV files exported by Excel, Google Sheets or LibreOffice using a configurable delimiter (comma, semicolon, tab, etc.).
- Skip a header row automatically — the first row is ignored when neither of its first two columns is a valid URL.
- Handle image URLs that point at image-style derivatives (`/styles/<style>/<scheme>/…`) by resolving them back to the original file.
- Run large imports safely through the Batch API with per-row progress reporting.
- Email a failure report to one or more configured recipients after each import.
- Review failed rows (row number, page URL, image URL, error message) on a results page after the batch completes.
- Correct alt text after a content migration that lost or mangled it.
- Standardise alt text wording across many images to match an editorial style guide.
- Localise alt text by importing a per-language CSV run.
- Delegate alt-text data entry to a non-developer who prepares a spreadsheet, with an admin running the import.
- Re-run an import with a corrected CSV after reviewing the failure report.
- Support Drupal running in a subdirectory — the importer strips the base path when matching page URLs.
- Resolve an empty page path to the configured front page automatically.
- Restrict who can run imports with the dedicated *update image alt texts via csv files* permission.
- Restrict who can change import settings with the separate *administer alt_text_import_csv* permission.
