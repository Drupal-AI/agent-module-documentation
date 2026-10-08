<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission, defined in `entity_delete.permissions.yml`:

| Permission | Machine name | Restricted | Gates |
|---|---|---|---|
| Use entity delete module. | `use entity_delete` | `restrict access: TRUE` | Both routes: the select form (`entity_delete.entity_delete_bulk`) and the confirmation form (`entity_delete.entity_delete_confirmation`). |

- `restrict access: TRUE` flags this as a security-sensitive permission (Drupal shows the "grant with
  care" warning). Grant only to trusted administrators — it permits irreversible bulk deletion of any
  content entity type, including all users (except uids 0/1) and clearing the `watchdog` log table.
- There is no finer-grained per-entity-type permission; the single permission covers everything the
  form can delete.
- The confirmation route additionally requires a valid CSRF token (`_csrf_token: 'TRUE'`).
