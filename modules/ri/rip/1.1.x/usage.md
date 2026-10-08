Remove Invalid Permissions (RIP) scans every user role and strips out permissions that no installed module still defines, cleaning up the orphaned permission strings that block a clean config export or a Drupal major-version upgrade.

---

When a module is uninstalled or a permission is renamed/removed, the permission string can linger inside `user.role.*` config, causing schema/upgrade errors and dirty config diffs. RIP compares each role's stored permissions against the full set of currently valid permissions (from the core `user.permissions` handler, `PermissionHandler::getPermissions()`) and revokes any that no longer exist. It offers two entry points: a **Drush command** (`drush rip`, canonical name `remove-invalid-permissions`) that prompts interactively per invalid permission before revoking, and an **admin form** at `/admin/people/rip` (linked as a "RIP" tab on the People page) that runs the removal in a Batch API process across all roles at once. Both paths iterate roles via the entity type manager, compute `array_diff($role_permissions, $valid_permissions)`, call `$role->revokePermission()` for each stale entry, and save the role. The batch reports how many permissions were removed from how many roles; the Drush command logs success. The form route is gated by the core `administer permissions` permission. After cleanup, export config (`drush cex`) so other environments inherit the fix. The module defines no permissions of its own and no config; it is a one-shot maintenance tool you can uninstall afterwards.

---

- Remove permission strings left in roles after a module was uninstalled.
- Clean up orphaned permissions before a Drupal 9→10 or 10→11 major upgrade.
- Fix "invalid permission" config-schema errors reported by config validation.
- Get a clean `drush cex` diff by stripping stale permissions from `user.role.*` config.
- Batch-clean every role at once from the `/admin/people/rip` admin form.
- Interactively review and confirm each invalid permission removal via `drush rip`.
- Audit which roles still reference permissions no installed module defines.
- Run the cleanup non-interactively as part of a deployment/CI maintenance step (Drush).
- Remove permissions belonging to a contrib module you deliberately dropped.
- Resolve upgrade blockers caused by renamed core permissions.
- Tidy roles after consolidating or refactoring custom modules that defined permissions.
- Ensure exported configuration is portable and free of dangling permission references.
- Recover from a partially removed module that left permission fragments behind.
- Prepare a site's configuration for a fresh import into another environment.
- Verify a role's permission set only contains currently-valid entries.
- Use as a periodic hygiene task on long-lived sites with heavy module churn.
- Strip invalid permissions from the authenticated/anonymous roles as well as custom roles.
- Clear permissions orphaned by switching from one access module to another.
- Roll the cleanup into a release script, then uninstall RIP once the site is clean.
- Diagnose config sync failures that stem from unknown permission machine names.
