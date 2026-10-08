<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `dbee.permissions.yml`:

| Machine name | Title | `restrict access` | Gates |
|---|---|---|---|
| `administer dbee` | Administer database email encryption | TRUE | Configuring the module's encryption options. dbee also uses this permission to guard access (`hook_ENTITY_TYPE_access`) to the `dbee` **key** and **encryption profile** entities, so only holders can view/edit the encryption key and profile. |

Marked `restrict access: true` — the holder can reach the encryption key/profile that protect
all user emails, so treat it as highly sensitive. The module has no other permissions; ordinary
login, registration and account editing are unchanged for all users.
