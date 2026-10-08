# Running RIP (Drush command, batch form, service)

RIP has no configuration — you just trigger the cleanup. Three ways:

## 1. Drush command (interactive)

```bash
ddev drush remove-invalid-permissions   # canonical
ddev drush rip                          # alias
```

- Defined in `src/Commands/RipCommands.php` (`drush.services.yml` → `rip.commands`).
- Loads all `user_role` entities, computes `array_diff($role->getPermissions(), $valid)` where
  `$valid = array_keys(\Drupal::service('user.permissions')->getPermissions())`.
- **Prompts per invalid permission**: `Remove <permission> for <role>? (y/n)`. Only confirmed ones
  are revoked; the role is saved after its loop. Logs "Invalid permissions removed." on success.
- Interactive by design — there is no `--yes`/no-prompt option in this version, so it is only
  partly suitable for unattended CI.

## 2. Admin batch form

- Route `rip.remove_invalid_permissions` → path `/admin/people/rip` (a "RIP" local task on the
  People collection). Requirement: core permission `administer permissions`.
- `\Drupal\rip\Form\RipForm` has a single **Submit** button; on submit it calls
  `rip.manager` → `RipBatch::start()`.
- `RipBatch` (Batch API) adds an operation per role that has invalid permissions, revokes them in
  `processFindingPermissions()`, and the finish callback reports
  `"{N} Invalid permissions from {M} Roles successfully removed."`. Runs across **all** roles at
  once with no per-permission prompt.

## 3. Programmatic (service)

```php
// The batch service can be invoked from your own code / a deploy hook.
\Drupal::service('rip.manager')->start(); // queues the Batch API run (needs a batch context to process)
```

- Service `rip.manager` = `Drupal\rip\Batch\RipBatch`, constructor args
  `[@messenger, @entity_type.manager, @user.permissions]`.
- Public counters `->roles` and `->permissions` track processed roles and removed permissions.

## After cleanup

Export config so the fix propagates: `ddev drush cex`. RIP is a one-shot tool — you can uninstall
it (`ddev drush pmu rip -y`) once roles are clean.
