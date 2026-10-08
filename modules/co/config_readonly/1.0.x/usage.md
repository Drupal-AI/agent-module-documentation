<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Read-only makes a Drupal site's active configuration store write-protected, so configuration can only be changed by importing a validated config set — typically on production, where UI-driven config edits should be impossible.

---

The module has no admin UI, no permissions and no settings entity: it is switched on entirely from `settings.php` with `$settings['config_readonly'] = TRUE;`. A `ServiceModifierInterface` (`ConfigReadonlyServiceProvider`) swaps the core `config.storage` service class for `Drupal\config_readonly\Config\ConfigReadonlyStorage`, a `CachedStorage` subclass whose `write()`, `delete()`, `rename()` and `deleteAll()` first call `checkLock()` and throw a `ConfigReadonlyStorageException` when the lock is on. Two escape hatches are built in: the lock is skipped while a `ConfigImporter` run holds the `config_importer` lock (so `drush config:import` still works) and while the request is on the `system.db_update` route (so `update.php` works). On top of the storage guard, `hook_form_alter()` dispatches a `ReadOnlyFormEvent`; `ReadOnlyFormSubscriber` flags any `ConfigFormBase`, `ConfigEntityListBuilder`, `ConfigTranslationFormBase`, config-entity form, or one of four named forms (`config_single_import_form`, `system_modules`, `system_modules_uninstall`, `user_admin_permissions`) as read-only, disables its submit buttons, adds a warning message listing the config names involved, and attaches a validation handler that always fails. A whitelist lets specific config names through: put glob-style patterns in `$settings['config_readonly_whitelist_patterns']` or implement `hook_config_readonly_whitelist_patterns()`; `*` is the only wildcard and patterns are anchored to the whole config name. `hook_requirements()` reports on `/admin/reports/status` whether the module is "enabled and active" or merely "enabled but not active".

---

- Lock production configuration so nobody can change site settings through the admin UI.
- Enforce a config-in-code workflow where the only way to change config is `drush config:import`.
- Prevent accidental edits to `system.site`, `system.performance` or similar global settings on a live site.
- Stop editors and admins from enabling or uninstalling modules on production (`system_modules` / `system_modules_uninstall` are blocked).
- Block permission changes on production by locking `user_admin_permissions`.
- Block the single-config import form (`config_single_import_form`) so config cannot be pasted in through the UI.
- Keep views, content types, fields and other config entities immutable outside of deployment.
- Show a clear warning banner on every config form explaining why the Save button is disabled.
- Whitelist a single config object (e.g. `system.maintenance`) so maintenance mode can still be toggled on a locked site.
- Whitelist an entire config prefix with a wildcard, e.g. `webform.webform.*`, to let one subsystem stay editable.
- Provide a whitelist from a custom module with `hook_config_readonly_whitelist_patterns()` instead of hard-coding it in `settings.php`.
- Toggle the lock per environment with a conditional in `settings.php` (e.g. only when `$_ENV['AH_SITE_ENVIRONMENT'] === 'prod'`).
- Lock only the web UI while still allowing CLI changes, using `if (PHP_SAPI !== 'cli')`.
- Toggle the lock with a sentinel file outside the docroot for emergency break-glass access.
- Guarantee that `drush config:import` still works while everything else is frozen, because the importer's lock bypasses the check.
- Keep `update.php` / `system.db_update` working so database updates can still run against a locked site.
- Catch `ConfigReadonlyStorageException` in custom deploy code to detect writes that would violate the policy.
- Subscribe to `ReadOnlyFormEvent` in a custom module to mark an extra form read-only, or to re-open one with `markFormEditable()`.
- Audit whether the lock is actually active by reading the Status report item "Config Read-only mode".
- Verify the lock programmatically by checking that `config.storage` resolves to `ConfigReadonlyStorage` and `Settings::get('config_readonly')` is TRUE.
- Protect config translations too, since `ConfigTranslationFormBase` forms are covered by the same subscriber.
- Prevent config drift between the exported config directory and the running site.
- Give a CI pipeline confidence that the deployed config is exactly what is in version control.
- Harden a multi-site platform where site builders share admin access but should not change config.
- Combine with `config_split`/`config_ignore` workflows so only intentionally-ignored config remains mutable.
