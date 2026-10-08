# Update Helper Checklist (update_helper_checklist) — agent index

Submodule of **update_helper**. Turns the configuration updates a module/distribution ships
into a **Checklist API** checklist with a "Pending updates" toolbar button. Depends on
`update_helper` and `checklistapi`. No admin form of its own (`configure` = null); the
checklist lives at **`/admin/config/development/update-helper`**.

- **The `updates_checklist.yml` format, the `update_helper_checklist.update_checklist` service,
  the tracking entity, the auto-marking event/hook integration, and the toolbar/permission** →
  [api/checklist.md](api/checklist.md)

Key facts:
- Registers checklist id `update_helper_checklist` via `hook_checklistapi_checklist_info()`
  (`#storage: state`, path `/admin/config/development/update-helper`).
- Items come from scanning every enabled module dir for a file named **`updates_checklist.yml`**
  (`UpdateChecklist::$updateChecklistFileName`).
- Per-hook status is stored in the content entity **`update_helper_checklist_update`**
  (one record per `<module>:<update_hook>`).
- Service **`update_helper_checklist.update_checklist`** (`Drupal\update_helper_checklist\UpdateChecklist`):
  `markAllUpdates()`, `markUpdatesSuccessful()`, `markUpdatesFailed()`, `getUpdateVersions($module)`.
- Auto-marks items via the `update_helper.configuration.update` event (`ConfigurationUpdateSubscriber`)
  and extends `drush generate configuration-update` via the `COMMAND_GCU_*` events
  (`CommandGcuSubscriber`) to also emit checklist entries.
- Toolbar "Pending updates" button shows while the checklist is < 100% complete; gated by the
  checklistapi permission `view update_helper_checklist checklistapi checklist`.
- `hook_modules_installed()` + install hook mark existing/new-module updates done so only real
  pending updates surface.
