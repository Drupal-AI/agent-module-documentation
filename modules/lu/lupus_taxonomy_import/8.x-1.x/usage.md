<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Import adds an admin form that reads a CSV file and creates taxonomy terms from it — including parent/child hierarchy and term field values — in one upload instead of one add-term form at a time.

---

The mechanism is worth understanding before you build a file, because it is not the obvious one. Hierarchy is expressed by **column position**, not by an indent character or a parent column: the CSV header names its level columns with the numbers `0, 1, 2, …` (0 is the top level), and each data row puts its term name in exactly one of those numbered columns — the column index is the term's depth. A term whose name sits in column `2` becomes a child of the most recent term in column `1` above it. Extra header columns whose names are *not* numbers (`status`, `weight`, `description`, or any real field machine name such as `field_seo_title`) are treated as term fields and set on the created term; a named field that does not exist on the target vocabulary is silently ignored, and entity-reference fields are skipped. Six fields are protected and rejected outright in the header: `changed`, `parent`, `tid`, `uuid`, `vid`, `metatag`. The form (`/admin/config/content/taxonomy/csv_import`) makes you pick the target vocabulary from a select, upload the `.csv`, and optionally tick **Purge existing terms** — which deletes every existing term in that vocabulary *before* importing (and, as its own warning says, breaks any content that referenced them). Validation is strict and up front: the numeric level columns must appear in order starting at 0, the first data row must be a level-0 term, each row may carry only one term, and **every term name in the file must be unique** — a name repeated anywhere (even under a different parent) aborts the import. The importer only ever **creates** terms; it never updates or de-duplicates against what is already there, so re-running the same file without purging produces a second copy of everything (the UI states outright that updating existing terms is not supported). The whole run is synchronous in the form submit — there is no Batch API — so a very large file is bounded by PHP's execution time and memory limits. Access is granted to `administer taxonomy` **or** the dedicated `import taxonomy csv` permission, letting a data-entry role load vocabularies without the wider power to restructure taxonomy. Two downloadable example files (a flat one and a hierarchical one, both with fields) are linked from the form and are the fastest way to see the exact shape.

---

- Import a whole vocabulary from a spreadsheet in one upload.
- Load a supplier's product classification as terms.
- Import a nested category tree, parents and children together, from one CSV.
- Populate a taxonomy during a site build instead of typing terms by hand.
- Load a subject or standards-body classification.
- Import a list of locations, departments, or tags.
- Set term field values (SEO title, description, weight, published status) at import time.
- Give a data-entry role the `import taxonomy csv` permission without full `administer taxonomy`.
- Wipe and reload a vocabulary from a corrected source file using the Purge option.
- Avoid writing a Migrate pipeline for a one-off flat term list.
- Download the bundled example CSVs to learn the exact column-position hierarchy format.
- Build a deep hierarchy by placing each term's name in the numbered column matching its depth.
- Publish or unpublish imported terms in bulk via a `status` column.
- Order imported terms via a `weight` column.
- Attach a description to each term via a `description` column.
- Populate custom term fields (e.g. `field_seo_title`, `field_link`) that already exist on the vocabulary.
- Stage a category tree in a spreadsheet, review it, then import it.
- Re-seed a demo or test site's vocabulary quickly.
- Load a translated term list into a vocabulary.
- Check a term file for structural errors (out-of-order levels, duplicate names, multi-term rows) via the form's validation before committing.
