<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library Books — agent orientation

Config-driven content model for library catalogues plus an issue-count log.

- Version 1.0.x, core ^10, depends on node/taxonomy/views.
- Logic in `library_books.module`: `hook_entity_presave` inserts into `library_book_issue_log`; `hook_node_view` shows issue count via parameterized query builder (no SQLi).
- No routes, no custom permissions, no HTTP calls. Nothing security-relevant found.
