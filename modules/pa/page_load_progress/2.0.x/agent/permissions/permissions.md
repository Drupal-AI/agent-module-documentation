<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `page_load_progress.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer page load progress` | Access the settings form (`page_load_progress.admin_settings`). |
| `use page load progress` | Whether the throbber assets are attached for this user (checked in `hook_page_attachments`). Grant to any role (incl. anonymous) that should see the loading overlay. |

Neither is `restrict access: true`. `use page load progress` only controls whether a purely cosmetic
overlay loads — no data access.
