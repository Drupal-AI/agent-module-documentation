<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `cookie_content_blocker.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer cookie content blocker` | The global settings form (`cookie_content_blocker.settings`) and the Media submodule settings form. |
| `administer cookie content blocker categories` | Create/edit/delete `cookie_content_blocker_category` config entities (also the entity `admin_permission`). |

Neither is marked `restrict access: true`, but both grant configuration-only capability (they change
site config; they do not process untrusted input). The parent menu route
(`cookie_content_blocker.admin_config`) only requires `access administration pages`. There are no
per-content or runtime permissions — blocking itself needs no permission.
