# Enforcement mechanism, service and hooks (API)

Two moving parts: the **checker** service decides *whether* a user has unfilled required fields, and
the **event subscriber** performs the redirect on each request. The session flag `enforce_user_fields`
(`EnforceUserFieldsHooks::SESSION_KEY`) links them so the (potentially expensive) field scan runs at
login / on profile save, not on every request.

## Checker service — `enforce_user_fields.checker`

`Drupal\enforce_user_fields\UserFieldsChecker` (args: `@entity_type.manager`, `@module_handler`;
also aliased from the FQCN as a private service).

```php
$checker = \Drupal::service('enforce_user_fields.checker');
$checker->bypass($account);                        // bool: has 'bypass enforce user fields'
$checker->hasUnfilledRequiredFields($account);     // bool: any required+empty user field?
```

- `bypass(AccountInterface $account): bool` — `TRUE` when the account holds
  `bypass enforce user fields`. Result cached per uid in `$bypassCache`.
- `hasUnfilledRequiredFields(AccountInterface $account): bool` (`UserFieldsChecker.php:44`) —
  returns `FALSE` for anonymous or bypassing accounts; otherwise loads the `user` entity and iterates
  `getFields()`. Only fields whose definition implements `ThirdPartySettingsInterface` (i.e.
  configurable/attached fields, not base fields) are considered. A field counts as unfilled when it is
  `isRequired()` **and** `isEmpty()`; the first such field short-circuits to `TRUE`.
- **`multiple_registration` integration** — only when that module is installed: a field is skipped for
  the user unless its `multiple_registration` / `user_additional_register_form` third-party setting is
  empty, contains `0` (all roles), or intersects the user's roles.

### Override the check — alter hook

`hasUnfilledRequiredFields()` ends with
`$this->moduleHandler->alter('enforce_user_fields_have_unfilled_required_fields', $result, $account)`,
so any module can flip the outcome. Documented in `enforce_user_fields.api.php`.

```php
// Procedural.
function MYMODULE_enforce_user_fields_have_unfilled_required_fields_alter(bool &$result, \Drupal\Core\Session\AccountInterface $account): void {
  if ((int) $account->id() === 1) {
    $result = FALSE; // Never force user 1.
  }
}

// Attribute form (Drupal 11.1+).
#[\Drupal\Core\Hook\Attribute\Hook('enforce_user_fields_have_unfilled_required_fields_alter')]
public function alterCheck(bool &$result, \Drupal\Core\Session\AccountInterface $account): void { /* … */ }
```

Note the flag is only recomputed at login and on user-form save, so an alter that depends on live state
takes effect on the next such recompute, not mid-session.

## Session flag lifecycle — `Hook\EnforceUserFieldsHooks`

Attribute hooks (`#[Hook]`):

- `#[Hook('user_login')] userLogin()` — on login, if the account bypasses it removes the session key;
  otherwise sets `session['enforce_user_fields'] = hasUnfilledRequiredFields()`. The redirect is
  deliberately deferred to the subscriber so the password-reset one-time-login token can be preserved.
- `#[Hook('form_user_form_alter')] formUserFormAlter()` — appends
  `EnforceUserFieldsHooks::onUserFormSubmit` to the account form's submit handlers. That static
  callback recomputes and re-stores the flag (via `\Drupal::service('enforce_user_fields.checker')`,
  since core invokes array/string submit callbacks without DI), so filling the fields clears the flag.
- `#[Hook('help')] help()` — help text on `help.page.enforce_user_fields`.

## Event subscriber — `enforce_user_fields.event_subscriber`

`Drupal\enforce_user_fields\EventSubscriber\EnforceUserFieldsSubscriber` subscribes to
`KernelEvents::REQUEST` at priority **30** (`checkForUserFields`). It returns early — i.e. does **not**
redirect — in any of these cases, in order:

1. current user is anonymous, or `checker->bypass()` is `TRUE`;
2. the current route is in `SKIP_ROUTES` (`entity.user.edit_form`, `user.logout`,
   `user.reset.login`, `image.style_public`, `image.style_private`, `system.css_asset`,
   `system.js_asset`) — this both breaks the redirect loop (edit form) and lets users log out / reset
   password / load assets;
3. the request is AJAX (`$request->isXmlHttpRequest()`);
4. the route path matches the admin `whitelist` (via `path.matcher`, lower-cased);
5. the session flag `enforce_user_fields` is falsy.

Otherwise it adds the configured `message` as an error and returns
`new RedirectResponse(Url::fromRoute('entity.user.edit_form', $routeParams)->toString())` where
`$routeParams` = `['user' => currentUser id, 'destination' => Url::fromRouteMatch(routeMatch)]`, plus
`pass-reset-token` copied from the session key `pass_reset_<uid>` when present (so the one-time-login
password-reset flow survives the redirect). The `destination` is the current **internal** route path
(built from the route match, not from request input), and the target is always the current user's own
edit form.

## Config translation

`enforce_user_fields.config_translation.yml` exposes `enforce_user_fields.settings` (the `message`) to
the Config Translation UI.
