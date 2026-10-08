<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Current User Term filter

## Prerequisites
- A taxonomy **term-reference** (`entity_reference` → `taxonomy_term`) field on the **user** entity.
- A taxonomy term-reference field on the **content** entity the View lists.
- The `user_ref_field_cache_context` module enabled (dependency; provides correct per-user caching).

## Add the filter
In a View, add filter **"Current User Term"** (`current_user_tid`). It is a query-time filter and **cannot be exposed** to visitors.

Options (`buildOptionsForm`):
- **User field** — the user profile term-reference field to read the term from.
- **Content field** — the content term-reference field to match against.
- **Show all results if no user value** — if checked, an empty user term shows everything; if unchecked, no results.

## Query behaviour
`query()` loads the current user, reads `<user_field>->target_id`, and adds `WHERE <entity_type>__<content_field>.<content_field>_target_id = <term_id>` (table ensured via `ensureTable`). Anonymous users are skipped. Field names are filtered with `Xss::filterAdmin()`; the term id is a bound query argument.

## Caching
Adds cache context `user.ref_field:<user_field>` so results vary per user's term value.
