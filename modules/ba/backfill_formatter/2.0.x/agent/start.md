<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backfill formatter (backfill_formatter) — agent index

**Entity-reference formatter that back-fills empty references with content sharing common taxonomy terms.**

- **Version:** 2.0.x (2.0.5), core `^9 || ^10 | ^11`, depends on `taxonomy_entity_index`
- **Formatter:** `backfill_formatter_terms` (`BackFillByTermsFormatter` extends `EntityReferenceEntityFormatter`)
- **Service:** `backfill_formatter.backfill_terms` (`BackFillTerms`, args entity_type.manager, database, current_user, query plugin manager)
- **Plugin type:** `BackFillQuery` (`plugin.manager.backfill_formatter_query`) — handlers for node/media/comment/term/user/default + `PermissionStatusHandler`
- **Security:** display-only formatter; queries use the parametrized DB API (`->condition(...,'IN')`) and entity query with `accessCheck(TRUE)` — no raw SQL; rendered items are access-checked. No routes/permissions/anonymous endpoints.

See [plugins/backfill-query.md](plugins/backfill-query.md)
