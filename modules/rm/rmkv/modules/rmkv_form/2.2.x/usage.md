rmkv_form is a submodule of the rmkv project that adds an admin form for removing orphaned `system.schema` key/value entries — the browser equivalent of rmkv's Drush commands, for the records left behind when a module, theme, or profile is deleted from disk without being uninstalled.

---

Enabling rmkv_form adds a "Remove system.schema key/value storage" page at `/admin/config/development/rmkv` (Configuration ▸ Development), gated by the dedicated, restricted permission `access to rmkv form`. The page is a single form (`Drupal\rmkv_form\Form\RemoveKeyValueForm`) with one `machine_name` field. On validate and submit it uses the core `keyvalue` factory's `system.schema` store plus `extension.list.profile`, `module_handler`, and `theme_handler` to confirm the entered name exists in `system.schema` and is not an installed profile/module/theme; when both hold, it calls `delete()` on that store to remove the orphaned schema record and reports success, otherwise it shows a validation or status error. The name is only reflected back through translated messages with an escaped `@machine_name` placeholder. The form is self-contained — it re-implements the same guarded logic as the parent module's `drush rmkv` command using only core services and declares no dependency on `rmkv`, so it can be enabled on its own. It persists no configuration despite extending `ConfigFormBase`. Back up the database before removing a record, and confirm the target is genuinely orphaned first.

---

- Clear the "has an entry in the system.schema key/value storage, but is missing from your site" warning from the browser instead of the CLI.
- Give site builders without shell access a way to purge orphaned schema records.
- Remove the leftover schema entry of a module deleted from disk without being uninstalled.
- Remove the orphaned schema record of a removed theme via the admin UI.
- Remove the orphaned schema record of a removed install profile via the admin UI.
- Fix a noisy status report before running core or contrib updates, using a form.
- Let an administrator perform the rare cleanup without writing a drush command.
- Restrict schema-record deletion to a specific trusted role via `access to rmkv form`.
- Provide a UI equivalent of `drush rmkv` on hosting where drush is unavailable.
- Delete a single orphaned key with built-in validation preventing removal of live extensions.
- Confirm (via the machine_name validator) that a name is actually an orphan before deleting it.
- Clean up experimental modules removed during development from a browser session.
- Tidy `system.schema` after importing a database that referenced modules you never installed.
- Resolve phantom update/dependency noise caused by a stale schema key, through the UI.
- Enable only when needed for a recovery task, then leave the permission ungranted.
- Offer editors/QA a documented click-path for a rare but time-consuming recovery step.
- Perform the cleanup on environments where enabling extra Drush commands is discouraged.
- Guard against accidental removal of an installed extension's schema via the form validator.
- Use the Configuration ▸ Development menu link to locate the removal tool quickly.
- Complement the parent rmkv Drush commands with a UI for non-CLI users.
