# Hotjar — hooks (`hotjar.api.php`)

Four hooks let other modules control tracking without touching Hotjar's config.

## `hook_hotjar_access()`

Veto (or allow) tracking per request. Return an `AccessResultInterface` (or bool/NULL). A
`forbidden()` result suppresses the snippet; `neutral()`/`allowed()` leaves the decision to the
other checks. Collected by `hotjar.access` via `invokeAllWith('hotjar_access', …)`.

```php
function mymodule_hotjar_access() {
  // Never track the front page.
  if (\Drupal::service('path.matcher')->isFrontPage()) {
    return \Drupal\Core\Access\AccessResult::forbidden();
  }
  return \Drupal\Core\Access\AccessResult::neutral();
}
```

## `hook_hotjar_access_alter(&$results)`

Alter the collected per-module access results (keyed by module) after `hook_hotjar_access()`.
Force a decision regardless of what other modules returned.

```php
function mymodule_hotjar_access_alter(&$results) {
  $results['mymodule_check'] = \Drupal\Core\Access\AccessResult::forbidden();
}
```

## `hook_hotjar_settings_alter(array &$settings)`

Alter the effective settings array (run inside `HotjarSettings::getSettings()`). Typical use:
different Hotjar ID per host/environment.

```php
function mymodule_hotjar_settings_alter(array &$settings) {
  if (\Drupal::request()->getHost() === 'staging.example.com') {
    $settings['account'] = '7654321';
  }
}
```

## `hook_hotjar_snippet_alter(&$script)`

Modify or wrap the activation script string. **Only called in `build` attachment mode** (not
`drupal_settings`). Useful for a consent gate.

```php
function mymodule_hotjar_snippet_alter(&$script) {
  $script = 'window.enableHotjar = function() { ' . $script . ' };';
}
```

Remember to `drush cr` (or run `createAssets()`) after logic that changes the built snippet, so
the generated JS file at `snippet_path` is regenerated.
