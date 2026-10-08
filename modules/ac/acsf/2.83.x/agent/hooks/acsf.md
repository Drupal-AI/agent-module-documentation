# Hooks (ACSF platform only)

Defined in `acsf.api.php` (+ `acsf_duplication.module`). These matter only on ACSF, mainly around
**site duplication/staging scrubs**, when a production site is copied and its data sanitized.

## `hook_acsf_registry()`

Register custom **event handlers** into the ACSF event framework (see
[api/acsf.md](../api/acsf.md)). Return an `events` array; each entry names an event `type`, a
handler `class` (subclass of `AcsfEventHandler`), an optional `weight`, and an optional `path`
(only if the class isn't autoloadable). Rebuilt on `hook_modules_installed` / `acsf-build-registry`.

```php
function mymodule_acsf_registry() {
  return ['events' => [[
    'weight' => -1,
    'type'   => 'acsf_install',                 // or site_duplication_scrub, acsf_stats, ...
    'class'  => '\Drupal\mymodule\MyHandler',
  ]]];
}
```

Core-registered types: `acsf` registers an `acsf_install` handler; `acsf_duplication` registers the
ordered `site_duplication_scrub` chain (Initialize → Configuration → Comment → Node → User →
TemporaryFiles → TruncateTables → Finalize).

## Scrub-preservation alter hooks (run by `acsf-site-scrub`)

Protect accounts from being anonymized (email/init hashed, passwords reset) when a site is staged.

```php
// Preserve users holding these role IDs.
function mymodule_acsf_staging_scrub_admin_roles_alter(array &$admin_roles) {
  if ($role = \Drupal::config('mymodule')->get('admin_role')) {
    $admin_roles[] = $role;
  }
}

// Preserve these specific user IDs.
function mymodule_acsf_staging_scrub_preserved_users_alter(array &$preserved_uids) {
  $preserved_uids = array_merge($preserved_uids, \Drupal::config('mymodule')->get('preserved_uids', []));
}
```

The anonymous user (uid 0) is always preserved.

## `hook_acsf_duplication_scrub_context_alter(&$data, $options)`

Add data to the `site_duplication_scrub` event context driven by
`drush acsf-duplication-scrub-batch` (options: `exact-copy`, `retain-users`, `retain-content`,
`batch`, `batch-comment`, `batch-node`, `batch-user`). The data lands in
`$this->event->context` for the scrub handlers.
