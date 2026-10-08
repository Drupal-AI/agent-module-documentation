<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lightning Scheduler permissions

Defined in `lightning_scheduler.permissions.yml`.

## `administer lightning scheduler`

Gates the settings form (`/admin/config/system/lightning/scheduler`). `restrict access: TRUE`
(security-sensitive). Grant only to trusted admins.

## Dynamic `schedule <workflow> <transition>` permissions

Provided by the `permission_callbacks` entry
`\Drupal\lightning_scheduler\Permissions::transitionPermissions` (class `Permissions` extends
Content Moderation's own `Permissions`). For **every** Content Moderation workflow transition,
it derives a scheduling permission by taking core's `use <workflow> transition <transition>`
permission and renaming it to `schedule <workflow> transition <transition>` (title:
"%workflow workflow: Schedule %transition transition.").

So the exact machine names mirror the workflow's transitions, e.g. for the `editorial`
workflow you get permissions like:

- `schedule editorial transition publish`
- `schedule editorial transition archive`
- `schedule editorial transition create_new_draft`

(one per transition defined in each Content Moderation workflow). A role needs the relevant
`schedule …` permission to queue that transition on content.

## Inspect the live list

```bash
drush role:perm:list           # or:
drush php:eval '$p = \Drupal::service("user.permissions")->getPermissions();
  foreach ($p as $k => $v) { if (str_starts_with($k, "schedule ")) print "$k\n"; }'
```

The set is empty until at least one Content Moderation workflow with transitions exists.
