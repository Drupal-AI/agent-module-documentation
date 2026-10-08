<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Maillog permissions

Defined in `maillog.permissions.yml`. All three are marked `restrict access: true` (security-
sensitive — logged mail can contain private data).

| Permission | Machine name | Gates |
|---|---|---|
| View Maillog | `view maillog` | The log list/details at `/admin/reports/maillog` (routes `maillog.details`), and whether the current user sees the on-screen **verbose** mail dump. |
| Delete entries from the log | `delete maillog` | Deleting individual logged mails (route `maillog.delete`). |
| Administer Maillog | `administer maillog` | The settings form `/admin/config/development/maillog` (route `maillog.settings`) and the clear-all-log confirm form (`maillog.clear_log`). Admins also see the "delivery disabled" warning when `send` is off. |

Notes:

- `verbose` output is only rendered to a user who holds **`view maillog`** — so even with verbose
  on, anonymous visitors without the permission do not see mail contents.
- Grant example: `drush role:perm:add anonymous 'view maillog'` (only on a safe dev environment).
- These are ordinary Drupal permissions; assign them at `/admin/people/permissions` or via config.
