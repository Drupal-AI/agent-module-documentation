<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library Books

Ships a ready-made content model for cataloguing library books: a `library_books` node type, a department taxonomy, listing Views, and a simple issue-count log.

- Installs a content type, taxonomy, and Views via config.
- Tracks how many times each book has been issued.
- Displays the issue count on the book node.
- Targeted at schools, colleges, and institutional libraries.

---

# Installing & configuring

- Require and enable with node, taxonomy, and views (`drush en library_books`).
- Config in `config/install` creates the content type, fields, taxonomy, and views.
- An install hook creates the `library_book_issue_log` table (see `.install`).
- No settings form is provided; the model works out of the box.
- Assign editor roles the usual node permissions for the `library_books` type.

---

# Usage & behaviour

- Editors create `library_books` nodes with a `field_book_is_issued` flag.
- `hook_entity_presave()` logs an issue row the first time a book is marked issued.
- The log row records book nid, issuing user id, and timestamp.
- `hook_node_view()` shows "Issued N times" on each book node.
- The count is a parameterized `SELECT COUNT` against the log table.
- All DB access uses the query builder (no raw string SQL).
- Views provide book listings and department browsing.
- The department taxonomy organizes books by section.
- No custom routes or anonymous endpoints are added.
- No custom permissions are defined; core node/taxonomy permissions apply.
- Issue logging is keyed off the current user at save time.
- Suitable as a starter kit to customize further.
- Uninstalling should remove the content model and log table.
- Works only on Drupal 10 (`core_version_requirement: ^10`).
- The model is config-driven and exportable.
- No external services or HTTP calls are made.
