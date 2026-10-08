<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role request — agent index

**Request→approve role-granting workflow**. Version **1.0.0**. Core `^11`.

Approval (`administer role requests`) grants the requested roles via `addRole()`; keep privileged roles out of the requestable list and treat `administer role requests` as a full-admin-level permission. Perms: `request role`, `administer role requests`, `administer role_request settings`. Depends on core `user`.