<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Missing Message Fixer finds "ghost" modules — schema records left behind for modules whose code was deleted without being properly uninstalled — and lets you delete those stale entries from the UI or via Drush, clearing the recurring "missing or invalid" warnings.

---

When a module's files are removed from disk without running an uninstall, Drupal keeps its schema version in the `key_value` table under the `system.schema` collection, which produces repeating "The following module is missing…"/invalid warnings. This module's service (`module_missing_message_fixer.fixer`, class `ModuleMissingMessageFixer`) builds a list of such ghosts by reading every `system.schema` key and flagging any whose name no longer resolves to an installed extension (`extension.list.module` `getPathname()` throws `UnknownExtensionException`). The admin form at `/admin/config/system/module-missing-message-fixer` (route `module_missing_message_fixer.form`, permission `administer module missing message fixer`) shows them in a tableselect; clicking **"Remove These Errors!"** deletes the selected names from `key_value` (collection `system.schema`) and also deletes any config objects named `<module>.*`. The same operations are available through two Drush commands — `module-missing-message-fixer:list` (alias `mmmfl`) and `module-missing-message-fixer:fix` (alias `mmmff`, taking a module name or `--all`). The module has no config of its own, no config schema, and no plugins; its only moving parts are the detection service, the form, and the Drush commands. Always run on a dev/staging copy and export config afterwards, as it mutates key-value state and can delete leftover config.

---

- Clear the recurring "module is missing" admin warning after a contrib module was deleted from disk without uninstalling.
- List all ghost modules on a site with `drush mmmfl` before cleaning them up.
- Remove a single stale schema entry with `drush mmmff <machine_name>`.
- Remove every ghost entry at once with `drush mmmff --all` on a throwaway environment.
- Clean up after a botched module removal where files were `rm`'d instead of uninstalled.
- Fix a site inherited from another team that shows leftover schema records.
- Delete orphaned `<module>.*` config left behind by a removed module (via the UI "Remove These Errors!" action).
- Audit which modules Drupal still thinks are installed but have no code present.
- Recover from a failed migration/upgrade that left dangling `system.schema` rows.
- Avoid hand-writing SQL `DELETE` against the key_value table to remove ghost records.
- Tidy a composer-managed site after removing packages without `drush pm:uninstall`.
- Resolve status-report / log noise caused by missing module schema entries.
- Batch-clean many ghost modules from the tableselect UI in one submit.
- Script cleanup of stale entries in CI with `drush mmmff --all` on a rebuilt DB.
- Verify a specific module is truly gone (no schema record) after uninstalling it.
- Clean a database dump imported from an environment that had extra modules.
- Prepare a config export that no longer references removed modules.
- Remove ghost entries for submodules that were dropped when a project was slimmed down.
- Diagnose "invalid or missing" errors by seeing the exact ghost names the fixer lists.
- Give non-technical admins a UI to fix schema ghosts without database access.
- Keep the update/status report clean before a Drupal core upgrade.
- Remove leftover schema rows after switching a module from contrib to custom (or vice versa).
