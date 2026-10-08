# Permissions

Defined in `scheduler.permissions.yml` plus a dynamic callback
`\Drupal\scheduler\SchedulerPermissions::permissions`.

## Static
- **`administer scheduler`** — access the settings form and lightweight cron config
  (`/admin/config/content/scheduler`). Gates routes `scheduler.admin_form`,
  `scheduler.cron_form`, `scheduler.no_bundle_settings_form`.

## Dynamic (one pair per supported entity type)
Generated for every entity type that has a Scheduler plugin:
- **`schedule publishing of {edit_key}`** — allows a user to set publish/unpublish dates on that
  entity type's add/edit form.
- **`view scheduled {view_key}`** — allows viewing the list of scheduled entities of that type.

For **nodes** the keys are the legacy `nodes` / `content` (i.e. `schedule publishing of nodes`,
`view scheduled content`); for all other entity types both keys are the entity type id
(e.g. `schedule publishing of media`, `view scheduled media`).

Resolve a name in code with `\Drupal::service('scheduler.manager')->permissionName($entityTypeId,
$permissionType)`.
