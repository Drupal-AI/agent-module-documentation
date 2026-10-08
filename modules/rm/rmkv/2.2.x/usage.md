Remove system.schema key/value (rmkv) provides two Drush commands that delete orphaned entries from Drupal's `system.schema` key/value collection — the records left behind when a module, theme, or profile is removed from disk without first being uninstalled.

---

Drupal keeps every installed extension's last-run schema/update version in the `system.schema` key/value store. If a module (or theme/profile) is deleted from the codebase before being properly uninstalled, its `system.schema` entry is orphaned, and the status report warns "Module {name} has an entry in the system.schema key/value storage, but is missing from your site." rmkv fixes this from the command line. The service `rmkv.commands` (`Drupal\rmkv\Commands\RemoveKeyValueCommands`) loads the `system.schema` store via the `keyvalue` factory and injects `extension.list.profile`, `module_handler`, and `theme_handler` to confirm a name is genuinely absent from the site. `drush rmkv:check <machine_name>` is a read-only test that reports whether the entry can be safely removed; `drush rmkv <machine_name>` performs the deletion, but only when the entry exists and does not belong to an installed profile, module, or theme — so it cannot clobber a live extension's schema record. The module has no web routes, permissions, or configuration; the equivalent browser form is provided by the bundled `rmkv_form` submodule. Always back up the database before removing a record, and confirm the target is truly orphaned first.

---

- Clear the "has an entry in the system.schema key/value storage, but is missing from your site" status-report warning.
- Remove the leftover schema record of a module deleted from disk without being uninstalled.
- Clean up after a contrib module was `rm -rf`'d instead of `drush pm:uninstall`'d.
- Recover a site whose update/status page complains about a missing-but-recorded module.
- Verify with `drush rmkv:check` whether a machine name is safe to purge before deleting it.
- Purge orphaned schema entries left by a removed theme.
- Purge orphaned schema entries left by a removed install profile.
- Script the cleanup of several orphaned schema records across environments in a deploy hook.
- Confirm a suspected orphan is really orphaned without changing anything (`rmkv:check`).
- Avoid manual `key_value` table edits by using a guarded command instead.
- Tidy a database imported from a project that shipped extra modules you never installed.
- Resolve phantom dependency/updates noise caused by a stale `system.schema` key.
- Remove a schema record for a renamed module after moving to its new machine name.
- Clean up experimental modules removed during development without a full uninstall.
- Restore a clean status report before running Drupal core or contrib updates.
- Automate orphaned-schema cleanup in CI when rebuilding a site from a database dump.
- Fix update.php / `drush updb` noise about a module that no longer exists.
- Safely refuse (via the built-in guard) to delete the schema of a still-installed module.
- Diagnose which of several warnings correspond to truly removable entries.
- Provide developers a reproducible CLI step for a rare but time-consuming recovery task.
