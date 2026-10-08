# Remove Invalid Permissions (RIP) — agent index

One-shot maintenance tool that revokes permissions from user roles when no installed module still
defines them (orphaned after uninstall/rename). Two entry points: a Drush command and a batch form.
No permissions of its own, no config, no plugins. Config UI route `rip.remove_invalid_permissions`
at `/admin/people/rip`, gated by core `administer permissions`.

- **Run it: the `drush rip` command (interactive) and the `/admin/people/rip` batch form, plus the
  `rip.manager` service for programmatic use** → [drush/rip.md](drush/rip.md)

Key facts:
- Valid set = `PermissionHandler::getPermissions()` (service `user.permissions`); stale set per role
  = `array_diff($role->getPermissions(), $valid)`; each stale entry → `$role->revokePermission()` then
  `$role->save()`.
- Drush command `remove-invalid-permissions` (alias `rip`) confirms each removal per role.
- Form `\Drupal\rip\Form\RipForm` runs `RipBatch::start()` (service `rip.manager`) — Batch API over
  all roles; reports "N permissions from M roles removed".
- Route requirement: `_permission: 'administer permissions'`.
