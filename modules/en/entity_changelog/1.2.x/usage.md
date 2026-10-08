<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Changelog records a changelog of entity create, update and delete (CUD) actions and provides a Views page to browse them.

---

Entity Changelog automatically logs create, update and delete operations on every content and config entity by implementing the core entity CUD hooks. Each logged operation is stored as an `entity_changelog_entry` content entity capturing the entity type, entity id, entity title, the operation, a timestamp, the acting user id and display name, and the request path. A bundled Views page at `/admin/entity_changelog` (Reports menu) lists the entries in a sortable, filterable table gated by a single restricted permission. There is no settings form — logging starts the moment the module is enabled. Entries older than three years are pruned automatically on cron. It depends only on core Views and belongs to the Custom package.

Use it as a lightweight audit trail: to see who changed what and when across your site's entities, to investigate unexpected content changes, and to demonstrate accountability. Because entries record entity titles and the users who acted, restrict the log to trusted administrators. Note there is no per-entity configuration — all entities with an id are logged (the changelog entity itself is excluded to avoid recursion).

---

- Keep an audit trail of who created, updated or deleted entities on the site.
- See when a given node, user, term or other entity was last changed and by whom.
- Investigate an unexpected content change by browsing recent changelog entries.
- Filter the changelog by operation type (insert, update or delete).
- Filter the changelog by entity type (node, user, taxonomy_term, etc.).
- Filter the changelog by the acting username via a grouped exposed filter.
- Filter the changelog by user id.
- Search the changelog by entity title (contains).
- Filter changelog entries by entity id.
- Filter entries by the request path from which the change was made.
- Filter entries by a timestamp range.
- Sort entries by timestamp, most recent first.
- Browse the audit log through a paged table (50 rows per page) at `/admin/entity_changelog`.
- Provide accountability/compliance evidence for content moderation workflows.
- Track editorial activity across multiple content types in one place.
- Identify which user account performed a bulk of deletions.
- Correlate a change to the URL/path where it was triggered.
- Monitor configuration entity changes as well as content entity changes.
- Retain roughly three years of change history without manual cleanup.
- Rely on automatic cron pruning to keep the changelog table bounded.
- Grant a dedicated role read-only access to the audit log via one permission.
- Add the changelog as a report under Administration → Reports.
- Log entity activity without writing any custom code.
