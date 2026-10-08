# autologout hooks

Declared in `autologout.api.php`. Implement in your `MODULE.module`.

- **`hook_autologout_prevent()`** — return `TRUE` to stop the current page from being included
  in autologout checks (like the "enforce on admin pages" exemption). Return `FALSE`/nothing to
  leave behavior unchanged. Use for pages that must never trigger a logout.

- **`hook_autologout_refresh_only()`** — return `TRUE` to include the keep-alive JS on the
  current page so the session is periodically refreshed but the user is never auto-logged-out
  (e.g. a long-running form or dashboard). Return `FALSE`/nothing for standard behavior.

- **`hook_autologout_user_logout()`** — fired right after a user is logged out *via autologout*
  (not manual logout), after the session is destroyed and the user is set to anonymous. Use for
  custom cleanup/auditing.

```php
function mymodule_autologout_prevent() {
  // Never log out while on the report builder.
  return \Drupal::routeMatch()->getRouteName() === 'mymodule.report_builder';
}
```
