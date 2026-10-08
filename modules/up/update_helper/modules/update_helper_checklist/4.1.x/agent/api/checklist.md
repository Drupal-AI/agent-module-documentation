# API — the update checklist

## `updates_checklist.yml` (the data)

Place a file named exactly `updates_checklist.yml` in a module's root. It is grouped by
**version**, then by **update-hook name**, each with checklistapi item keys:

```yaml
v2.1.0:
  '#title': 'Update to version v2.1.0'
  '#description': '<h3>These are the new features for this release:</h3>'
  mymodule_update_9001:
    '#title': 'Configuration update.'
    '#description': '<p>Configuration is successfully updated.</p>'
    '#description_successful': '<p>Applied.</p>'
    '#description_failed': '<p><strong>Update of configuration has failed.</strong></p>'
```

At render time each hook key is namespaced to `<module>_<hook>` and matched against a stored
`update_helper_checklist_update` record: if it ran successfully `#description_successful` is
appended, otherwise `#description_failed`. Items are listed newest-version first.
`drush generate configuration-update` (with this module enabled) generates these entries for you
via the `configuration_update_checklist.yml.twig` template.

## The service — `update_helper_checklist.update_checklist`

`Drupal\update_helper_checklist\UpdateChecklist`
(ctor: `@checklistapi_storage.state`, `@module_handler`, `@current_user`):

- `markAllUpdates($status = TRUE)` — mark every update in every module's `updates_checklist.yml`
  as done (used by the install hook so pre-existing updates aren't flagged pending).
- `markUpdatesSuccessful(array $module_updates, $checkListPoints = TRUE)` — e.g.
  `['mymodule' => ['mymodule_update_9001']]`.
- `markUpdatesFailed(array $module_updates)`.
- `getUpdateVersions($module)` — the versions a module declares in its checklist file.

## Status storage — the tracking entity

Content entity type **`update_helper_checklist_update`**
(`Drupal\update_helper_checklist\Entity\Update`), one record per `<module>:<update_hook>`,
recording whether the hook completed. `Update::load($key)->wasSuccessfulByHook()` is how the
checklist decides an item's state. Progress for the checklist itself is kept in **state**
storage (`checklistapi_storage.state`), not config.

## Automatic marking

- **On update run:** `ConfigurationUpdateSubscriber` listens to
  `UpdateHelperEvents::CONFIGURATION_UPDATE` (`update_helper.configuration.update`) — fired at
  the end of `update_helper.updater->executeUpdate()` — and marks the matching item
  successful/failed based on the warning count.
- **On generate:** `CommandGcuSubscriber` listens to `COMMAND_GCU_INTERACT` / `COMMAND_GCU_EXECUTE`
  to add checklist prompts/entries to `drush generate configuration-update`.
- **On module install:** `hook_modules_installed()` marks a newly installed module's declared
  updates successful (so they don't appear as pending).

## UI & access

- Checklist page: `/admin/config/development/update-helper` (checklist id `update_helper_checklist`,
  registered in `hook_checklistapi_checklist_info()`).
- Toolbar: a **"Pending updates"** `toolbar_item` link appears while
  `checklistapi_checklist_load('update_helper_checklist')->getPercentComplete() < 100`.
- Permission (provided by checklistapi for this checklist):
  `view update_helper_checklist checklistapi checklist`.
