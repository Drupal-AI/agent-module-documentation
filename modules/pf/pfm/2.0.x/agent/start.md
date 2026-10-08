<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions filtered by modules (pfm) — agent index

Adds a filtered permissions admin page at `/admin/people/pfm-permissions` (route
`pfm.admin_permissions`, permission `administer permissions`) with AJAX module/role filters, so
the permissions grid stays small on large sites. It does **not** replace core's
`/admin/people/permissions`. No config, schema, Drush, or permissions of its own.

- **The filtered permissions form: filters, what renders, save behaviour, dragcheck integration** →
  [configure/permissions-ui.md](configure/permissions-ui.md)

Key facts:
- Form `\Drupal\pfm\Form\PfmUserPermissionsForm` extends core `UserPermissionsForm` (form id
  `pfm_user_admin_permissions`); saving uses core's `user_role_change_permissions`.
- Empty table until at least one **module** is selected; only selected **role** columns render.
- Admin roles show all boxes checked+disabled; `restrict access` permissions keep core's warning.
- Attaches `permissions_dragcheck` libraries only if that module is enabled.
- Menu: People → *PFM Permissions* (`entity.user.collection`).
