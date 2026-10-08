<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — permissions

Defined in `private_message.permissions.yml`. Grant with
`drush role:perm:add <role> 'use private messaging system'`.

| Permission | Gates | Restricted |
|---|---|---|
| `use private messaging system` | The base ability to send/receive messages and reach `/private-messages`, the composer, thread view, and ban pages. Most PM routes also require core `access user profiles`. | no |
| `delete own private message` | Delete messages the user authored. | no |
| `delete private message thread for all` | Fully delete a thread for **all** its members (not just clear personal history). | no |
| `delete any private message` | Admin: delete any user's private messages. | yes |
| `delete private message ban entities` | Delete `private_message_ban` (block) entities. | no |
| `edit private message ban entities` | Edit block entities. | no |
| `view private message ban entities` | View block entities. | no |
| `add private message ban entities` | Create block entities (block another user). | no |
| `administer private message ban entities` | Access the ban admin configuration form. | yes |
| `administer private messages` | Entity `admin_permission` for `private_message` and `private_message_thread` — administer message/thread content and their field UI. | yes |
| `administer private message module` | Access all module admin/config routes (`/admin/config/private-message/*`, `/admin/structure/private-message/*`). | yes |

Typical setups:
- Ordinary members: `use private messaging system` (+ core `access user profiles`), optionally
  `delete own private message` and `add private message ban entities`.
- Moderators/admins: add `administer private messages`, `delete any private message`,
  `administer private message module`.
