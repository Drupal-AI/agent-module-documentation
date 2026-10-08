<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Autoban defines one permission (`autoban.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer autoban` | Create and edit autoban rules. |

It guards every admin route (`autoban.routing.yml`): the rules list
(`entity.autoban.list`), add/edit/delete rule forms, the settings form (`autoban.settings`),
and the Analyze, Test, Ban, direct-ban and Delete-all screens. It is also the config entity's
`admin_permission`, so it governs `_entity_create_access`/`_entity_access` on `autoban`
entities. There are no finer-grained permissions — a role either administers all of Autoban or
none of it. Grant only to trusted administrators.
