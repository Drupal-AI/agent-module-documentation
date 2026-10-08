Update Helper Checklist adds a Checklist API–backed checklist of a site's configuration updates: for every module (or distribution) that ships an `updates_checklist.yml`, it lists each update hook, tracks whether it ran successfully, and shows a "Pending updates" toolbar button until everything is done.

---

This submodule of Update Helper integrates with `checklistapi`. It implements `hook_checklistapi_checklist_info()` to register a checklist `update_helper_checklist` at `/admin/config/development/update-helper` (state storage), whose items are gathered by scanning every enabled module's directory for an `updates_checklist.yml` file and parsing its per-version, per-update-hook entries. Each update hook's completion status is stored in a content entity `update_helper_checklist_update` (one record per `<module>:<update_hook>`), and the `update_helper_checklist.update_checklist` service (`UpdateChecklist`) exposes `markAllUpdates()`, `markUpdatesSuccessful()` and `markUpdatesFailed()` to flip those statuses. It listens to Update Helper's `UpdateHelperEvents::CONFIGURATION_UPDATE` event (via `ConfigurationUpdateSubscriber`) to automatically mark a checklist item successful/failed whenever `update_helper.updater->executeUpdate()` runs, and it hooks the `drush generate configuration-update` command (via `CommandGcuSubscriber` on the `COMMAND_GCU_*` events) so the generator additionally emits `updates_checklist.yml` entries. On install it marks all existing updates as done (`markAllUpdates()`), and `hook_modules_installed()` marks a freshly installed module's updates complete so only genuinely pending updates surface. A toolbar item ("Pending updates") appears while the checklist is under 100% complete, gated by the checklistapi permission `view update_helper_checklist checklistapi checklist`.

---

- Show a distribution's site owners a checklist of configuration updates they still need to run.
- Surface a "Pending updates" toolbar button whenever any tracked update hook has not completed.
- Track, per update hook, whether the configuration update succeeded or failed.
- Automatically tick off checklist items as `update_helper.updater->executeUpdate()` runs each CUD.
- Ship an `updates_checklist.yml` with a module/distribution to document its release-by-release updates.
- Auto-generate `updates_checklist.yml` entries when running `drush generate configuration-update`.
- Give each release a titled section ("Update to version v2.1.0") grouping its update hooks.
- Add per-item success and failure descriptions that change based on whether the update ran.
- Mark all updates complete automatically when a module is freshly installed (no false "pending" items).
- Provide distributions a single place to communicate "what changed and what you must do".
- Let editors/admins visit `/admin/config/development/update-helper` to see update progress.
- Persist checklist progress in state storage (survives config export/import).
- Programmatically mark a set of updates successful via `markUpdatesSuccessful(['mymodule' => ['mymodule_update_9001']])`.
- Programmatically mark updates failed with `markUpdatesFailed()` for rollback scenarios.
- Query which update versions a module declares with `UpdateChecklist::getUpdateVersions($module)`.
- Restrict who can see the update checklist using the checklistapi permission.
- Link checklist items to external release notes or docs via `#url` entries.
- Coordinate multi-module update ordering (update 8001 migrates old checklist data first via update dependencies).
- Keep a persistent audit of which configuration updates have been applied on a site.
- Integrate update tracking into the admin toolbar for at-a-glance status.
