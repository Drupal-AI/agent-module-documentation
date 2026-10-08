<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Delete — agent index

Admin tool to bulk-delete all (or all of one bundle of) content entities of a chosen type, via
the Batch API. Two-step form at `/admin/config/entity-delete` (route
`entity_delete.entity_delete_bulk`). Gated by the `use entity_delete` permission
(`restrict access: TRUE`). No Drush, no config schema, no plugins.

- **The bulk-delete flow, entity-type special cases, batching, watchdog truncate** →
  [configure/bulk-delete.md](configure/bulk-delete.md)
- **The `use entity_delete` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes: `entity_delete.entity_delete_bulk` (select form), `entity_delete.entity_delete_confirmation`
  (confirm; requires `_csrf_token: 'TRUE'`). Both require `use entity_delete`.
- Only `ContentEntityType` definitions are selectable; entity type + bundle pass as query params.
- Special cases: `watchdog`+`all` → raw `TRUNCATE watchdog`; `user` excludes uids 0 & 1;
  `users`→`user`, `file_managed`→`file`; deletes in batches of 25.
