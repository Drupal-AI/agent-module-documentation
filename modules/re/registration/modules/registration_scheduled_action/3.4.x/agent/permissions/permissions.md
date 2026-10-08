<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `registration_scheduled_action.permissions.yml`:

| Permission | Allows | Restricted |
|---|---|---|
| `administer registration scheduled action` | maintain the schedule of automated registration actions (the collection at `/admin/structure/registration/schedule` and its add/edit/delete forms) | yes (`restrict access: true`) |

There are no other permissions; the scheduled actions themselves run via cron, not per-user.
