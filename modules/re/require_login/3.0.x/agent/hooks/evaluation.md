<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Override enforcement in code + how evaluation runs

## The alter hook

`require_login.api.php` invites one hook:

```php
/**
 * Alter login requirements evaluation result.
 */
function hook_require_login_evaluation_alter(bool &$eval): void {
  // e.g. only force login on one route:
  $eval = \Drupal::routeMatch()->getRouteName() === 'example.page';
}
```

`$eval` is the boolean "should this anonymous request be forced to log in?" computed from the
configured conditions. Your implementation can force it TRUE or FALSE for the current request
(you have full access to the route match, current user, request, etc.).

## Evaluation flow

`Drupal\require_login\EventSubscriber\LoginEventSubscriber`:

- `KernelEvents::REQUEST` (priority 31, main requests only) → `onRequestRedirect()`.
- `KernelEvents::EXCEPTION` → `onExceptionRedirect()` (handles 403/404 when `include_403`/
  `include_404` are on, and marks that an exception occurred so REQUEST doesn't double-run).

Both call `require_login.requirements_manager` (`LoginRequirementsManager`):

1. Return FALSE (no redirect) if the user is **authenticated** or the current route is in
   `PROTECTED_ROUTES`.
2. If handling a 403/404 exception and the matching `extra.include_40x` is off, return FALSE.
3. Build the configured `requirements` conditions into a `ConditionPluginCollection`, apply
   runtime contexts, and `resolveConditions(..., 'and')` — **all** must pass.
4. `\Drupal::moduleHandler()->alter('require_login_evaluation', $eval)` — your hook runs here.
5. If `$eval` is TRUE, `redirect()` returns a `Url` to `login_path` (or `/user/login`) with a
   `destination` query (`login_destination` if set, else the current request URI), and adds
   `login_message` as a warning; the subscriber wraps it in a `TrustedRedirectResponse`.

## Service

`require_login.requirements_manager` → `LoginRequirementsManager`
(implements `LoginRequirementsManagerInterface`): `evaluate(?HttpExceptionInterface $exception)`
returns a `Url` (redirect) or `FALSE`; `redirect()` builds the login `Url`. Inject it as
`@require_login.requirements_manager` if you need the same decision elsewhere.
