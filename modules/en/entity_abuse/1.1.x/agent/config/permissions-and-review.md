<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions, access control & review queue

## Permissions (`entity_abuse.permissions.yml`)

| Permission | Grants |
|---|---|
| `entity_abuse manage settings` | Settings form, enabled types, field/form/display config (`restrict access: true`). |
| `add entity_abuse_report` | Create a new report. |
| `view own entity_abuse_report` / `view any entity_abuse_report` | View own / any report. |
| `edit own entity_abuse_report` / `edit any entity_abuse_report` | Edit own / any report. |
| `delete own entity_abuse_report` / `delete any entity_abuse_report` | Delete ("cancel") own / any report. |

## Access control — `EntityAbuseReportAccessControlHandler`

`src/EntityAbuseReportAccessControlHandler.php` (extends `EntityAccessControlHandler`):
- Any operation is allowed for a holder of the entity type's admin permission (falls back to
  `entity_abuse manage settings` behaviour via the entity type's admin permission when set).
- `checkAccess()` — `view` needs `view any`, or `view own` + ownership; `update`/`delete` require an
  authenticated user with the `any` permission, or the `own` permission + ownership. Results carry
  `cachePerPermissions`/`cachePerUser` + the entity as a cache dependency. Otherwise neutral.
- `checkCreateAccess()` — allowed if the account has `add entity_abuse_report` (used by the add route's
  `_entity_create_access` requirement). The add form additionally validates that the reported target is an
  enabled type the reporter may `view` (see [../flows/submission.md](../flows/submission.md)).

## Review queue — View `entity_abuse_reports`

`config/install/views.view.entity_abuse_reports.yml`, base table `entity_abuse_report`. Displays:
- **default (master)** — table with `#`, Reported on, Changed on, Reported by (`uid`), Message
  (`text_default`), "Complain to" (the `entity_abuse_report_entity` field → link to the reported entity),
  and entity operations. Access: permission `view any entity_abuse_report`. Mini pager, 30/page.
- **page** ("All complains") — path `admin/entity-abuse-reports`, admin menu item "Abuse reports".
- **page_user** ("User complains") — path `user/%user/abuse-reports`, access `view own
  entity_abuse_report`, argument = current user's uid (`current_user` default), menu tab "My abuse reports".

## Menus / tasks

`entity_abuse.links.menu.yml` puts "Entity abuse" under Structure. `entity_abuse.links.task.yml` adds
Edit (settings) and View/Edit/Delete local tasks on the report canonical route.
