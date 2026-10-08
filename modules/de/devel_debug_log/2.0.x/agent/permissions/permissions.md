<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Grounded in `devel_debug_log.permissions.yml` and `devel_debug_log.routing.yml`.

The module defines exactly one permission:

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Access debug messages | `access debug messages` | The `devel_debug_log.list` route → `admin/reports/debug` (Reports → Debug messages), i.e. viewing the debug log and using the **Clear log messages** button. | `restrict access: TRUE` — Drupal flags it on the permissions form as security-sensitive because stored messages can contain arbitrary dumped data (entities, config, service state). |

There is **no separate "administer" or "clear" permission** — anyone who can access the page can
also clear the whole log. Writing entries needs no permission at all: `ddl()` is a code-level call,
so any code that runs (regardless of the current user) can append rows.

Grant it to trusted developer roles only, and prefer not to enable this module in production.

```bash
# Grant to a role:
ddev drush role:perm:add developer 'access debug messages'
# Who has it:
ddev drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if ($r->hasPermission("access debug messages")) print $r->id()."\n"; }'
```
