<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Drush command that searches for a text string across every eligible table and column of the Drupal database and reports the matches.

---

Database Text Searcher adds one Drush command, `db-text-searcher:search` (alias `db-text-search`), that takes a single search string and runs a partial (`LIKE '%term%'`) match against the textual columns of nearly all tables in the site's database — skipping tables whose names contain `batch`, `revision`, `cache`, or `tmgmt`, and columns named like `deleted`, `delta`, or `langcode`. It reads the table and column inventory from `information_schema`, adapts the search text to each column's character set, extracts a short context snippet (and any matched URLs) around each hit, de-duplicates results, resolves a direct entity URL for common tables (node, user, taxonomy term, media, block, menu link, redirect), prints the results to the console, and writes them to a timestamped CSV file in the site's public files directory. It is a developer/CLI diagnostic tool with no web UI, routes, permissions, or configuration; it declares a dependency on the `embed` module in its info file although the command code itself does not use it.

---

- Find which table and column stores a particular string when debugging where content lives.
- Locate every occurrence of a phone number, email, or name across the whole database during a content audit.
- Track down leftover references to an old URL, domain, or path before or after a migration.
- Verify that a data-migration step copied specific values into the expected tables.
- Discover stray copies of a value duplicated across multiple entity or field tables.
- Search for a hard-coded string or token that a module left in the database.
- Confirm a search-and-replace or find/replace operation actually reached every table.
- Audit for potentially sensitive text (e.g. a test credit-card number or secret placeholder) sitting in plain-text columns.
- Export a CSV of all matches for a value, for offline analysis or record-keeping.
- Identify the node, user, term, media, or block behind a matched row via the resolved entity URL.
- Investigate why a value appears on the site by finding its storage location.
- Trace a Cohesion layout entity back to its parent when a match is in `cohesion_layout_field_data`.
- Check whether a string survives in JSON-encoded field data (the command also searches a JSON-escaped form of the term).
- Sweep the database for occurrences of a brand name or product code before a rebrand.
- Provide developers a quick CLI alternative to writing ad-hoc SQL `LIKE` queries by hand.
- Spot orphaned configuration or content still referencing a removed feature.
- Locate where a specific rendered link or absolute URL is stored in body/field text.
- Run repeatable text searches from a shell script or CI job during QA.
- Gather a report of every field containing a compliance-relevant term for documentation.
- Quickly enumerate the primary key(s) of every row matching a search string per table.
