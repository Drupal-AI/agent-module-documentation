<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backfill formatter is an entity-reference field formatter that fills empty (or partially populated) reference fields with related content that shares the most taxonomy terms.

---

The formatter `backfill_formatter_terms` (`BackFillByTermsFormatter`, extending core's `EntityReferenceEntityFormatter`) lets editors curate references manually but falls back to automatically selecting similar content when the field is short of its maximum. Selection is done by the `backfill_formatter.backfill_terms` service (`BackFillTerms`), which queries the `taxonomy_entity_index` table for entities sharing the source entity's terms, ranks them by number of matching terms (most matches first), and lets you weight certain vocabularies for precedence. It depends on the `taxonomy_entity_index` module for that index.

The module is extensible via a `BackFillQuery` plugin type (manager `plugin.manager.backfill_formatter_query`) with per-entity-type handlers (node, media, comment, term, user, default) and a `PermissionStatusHandler`, plus a `hook`-style query alter path. Queries are built with Drupal's parametrized database API (`->select()->condition(..., 'IN')`) and taxonomy entity-query with `accessCheck(TRUE)` — no raw SQL concatenation — and access is enforced per referenced entity when rendered. Configure it on any entity-reference field's Manage display page: choose the view-mode, item count and vocabulary precedence.

---
- Add a "related content" entity-reference field to a content type
- Set the field formatter to "Back-fill by terms" on Manage display
- Let editors curate related items manually
- Auto-fill remaining slots with term-matching content
- Rank fallback items by number of shared taxonomy terms
- Choose the view-mode used to render back-filled items
- Limit the number of items displayed (up to the field maximum)
- Give precedence to specific vocabularies when matching
- Build "related articles" blocks with a curated + automatic mix
- Match by any term or require matching within weighted vocabularies
- Extend selection with a custom `BackFillQuery` plugin
- Use per-entity-type handlers (node, media, term, user, comment)
- Rely on `taxonomy_entity_index` for term indexing
- Respect entity access on rendered back-filled items
- Alter the matching query via the query-alter path
