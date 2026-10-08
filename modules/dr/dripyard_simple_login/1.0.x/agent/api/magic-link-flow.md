<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magic-link authentication flow

End-to-end passwordless login, built entirely on Drupal core's password-reset / one-time-login
mechanism. Two module classes participate; everything security-relevant is delegated to core.

## 1. Requesting a link — `src/Form/MagicLinkLoginForm.php`

`MagicLinkLoginForm extends FormBase`; form id `dripyard_simple_login_magic_link_form`. Rendered at
`/login` because `RouteSubscriber` points core's `user.login` route at this form (see
[../routing/routes.md](../routing/routes.md)). DI (`create()`): user storage (`entity_type.manager`
→ `user`), `language_manager`, `flood`.

- `buildForm()`: one required `#type => email` field named `name` (maxlength 254, `autocomplete
  email`), a primary submit **"Send login link"**, and a second submit **"Use password"** whose
  `#submit` is `::passwordLoginRedirect` with `#limit_validation_errors => []`. Cache tag
  `rendered`.
- `validateForm()`: flood gate only — `flood->isAllowed('user.password_reset_ip', ip_limit,
  ip_window, clientIp)` using the `user.flood` config; on failure sets a generic
  "too many login attempts" error. (This is IP-scoped only; it does not add a per-account flood.)
- `submitForm()`:
  1. `loadByProperties(['mail' => $name])`, falling back to `loadByProperties(['name' => $name])`
     — so either an email address or a username is accepted.
  2. `flood->register('user.password_reset_ip', ip_window, clientIp)` — always registered.
  3. Only if `$account && $account->id() && $account->isActive()`: send the link with core
     `_user_mail_notify('password_reset', $account)` and log to the `user` channel.
  4. `usleep(random_int(10000, 50000))` — random delay to flatten timing differences.
  5. `messenger()->addMessage('Check %email on this device for your login link.')` — the **same**
     message regardless of whether an account matched — then `setRedirect('<front>')`.
- `passwordLoginRedirect()`: `setRedirect('dripyard_simple_login.login_password')` → the `/login-password`
  fallback rendering core `UserLoginForm`.

The email itself is core's **Password recovery** notification. Its body must be reworded to read as a
login link — this is a required manual step at `/admin/config/people/accounts`; a suggested body is in
`README.md` / `data.json` (`[user:one-time-login-url]/login?destination=/user`). The module ships no
mail template of its own.

## 2. Consuming the link — `src/Controller/UserResetController.php`

`UserResetController extends \Drupal\user\Controller\UserController`. `RouteSubscriber` points core's
`user.reset.login` route (path `/user/reset/{uid}/{timestamp}/{hash}/login`) at
`UserResetController::resetPassLogin`. The override is intentionally thin:

```
$response = parent::resetPassLogin($uid, $timestamp, $hash, $request);
$this->messenger()->deleteAll();
$this->messenger()->addStatus("You're logged in!");
return $response;
```

**All validation and session establishment are core's.** `parent::resetPassLogin()` calls
`determineErrorRedirect($user, $timestamp, $hash)`, which (core `UserController`):
- loads the user by `$uid` and throws `AccessDeniedHttpException` if the user is missing or **not
  active** (`!$user->isActive()`);
- enforces the `user.settings:password_reset_timeout` window against `$timestamp`;
- verifies the **one-time-login HMAC token** in constant time (core `verifyHmac`, i.e. the
  `user_pass_rehash` token over uid + timestamp + last-login + password hash), which makes the link
  single-use (the last-login change invalidates it);
- clears failed-login/http-login flood, calls `user_login_finalize($user)` to start the session, and
  redirects to the user edit form with a one-time `pass-reset-token` so a password can optionally be
  set.

The module changes none of this — it only replaces the status messages. There is no module route or
code path that establishes a session without going through this core validation.

## 3. Rate limiting

No custom limits: the request form reuses core's `user.password_reset_ip` flood namespace and the
`user.flood` config (`ip_limit` / `ip_window`), configurable under **Flood control** on the Account
settings page. The consume step benefits from core's own reset flood clearing.
