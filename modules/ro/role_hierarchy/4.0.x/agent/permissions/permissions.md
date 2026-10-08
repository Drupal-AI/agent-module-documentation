<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `role_hierarchy.permissions.yml`:

| Machine name | Title | Effect |
|---|---|---|
| `edit user roles` | Edit user roles | Forces the roles element to be shown on the user add/edit form (`#access` is OR-ed with this permission). The roles offered are still filtered by the hierarchy. |
| `bypass role hierarchy` | Bypass role hierarchy | Exempts the account from **all** hierarchy checks — `hasRoleEditAccess()` / `hasEditAccess()` return TRUE immediately, role checkboxes are not stripped, and the bulk role actions are allowed. Give this to genuine site administrators whose edit rights should be governed by other modules/core permissions instead. |

Notes: neither permission is flagged `restrict access`, but `bypass role hierarchy` effectively
disables this module for its holders, so treat it as sensitive. Independent of these, user 1 is
always allowed to edit anyone and is never editable by anyone else.
