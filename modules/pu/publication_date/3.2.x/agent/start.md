<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Publication Date (publication_date) 3.2.x

Adds a `published_at` timestamp base field to **nodes** recording when a node was *first*
published. Value is `NULL` while unpublished, stamped with request time on first publish, and
then left unchanged. Field type is `published_at` (`no_ui`, extends core `TimestampItem`).
No admin settings form and no Drush commands — it is code + a field + permissions.

Runs on Drupal `^10.3 || ^11 || ^12`. Hooks are implemented as OOP `#[Hook]` classes under
`src/Hook/` (with `#[LegacyHook]` shims in `publication_date.module`); the stored value column
is indexed for efficient sorting/filtering.

- **Read / set the field, computed property, tokens, integrations** → [api/field.md](api/field.md)
- **Show/hide the field, form widget, view formatters, Views date arguments** → [configure/display.md](configure/display.md)
- **Permissions (global + per-content-type)** → [permissions/permissions.md](permissions/permissions.md)
