<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Self-service unblock

Lets a user who was auto-blocked for inactivity reactivate their own account through a signed,
time-limited link — no admin action. Two public routes plus the token/link generator. Enabled by
config `enable_unblock`.

## Route 1 — request form: `deactivate_users.unblock.generate`

Path `/user/unblock`, form `UnblockUserGenerateForm` (`src/Form/`). Requirements:
`_user_is_logged_in: 'FALSE'` (anonymous only) and `_custom_access:
UnblockUserGenerateForm::access`, which returns `AccessResult::allowedIf($config->get('enable_unblock'))`
— so the page 404/403s unless the feature is switched on.

`submitForm()` looks up `user_load_by_mail($email)`; **only if that user exists and is blocked** does
it send mail key `unblock_email` and log a notice. Regardless of outcome it shows the same message
("If that email address exists in the system, an email will be sent…") — deliberately enumeration-safe.

## Route 2 — apply link: `deactivate_users.unblock`

Path `/user/unblock/{uid}/{timestamp}/{hash}`, controller
`UnblockUserController::content()` (`src/Controller/`). Requirement is `_access: 'TRUE'` — the route
is open, and the controller does the real verification:

```php
if ($user && $hash === user_pass_rehash($user, $timestamp)
    && time() - $unblock_timeout <= $timestamp) { ... }
```

- `user_pass_rehash($user, $timestamp)` is core's HMAC over the user's password hash, last-login time,
  uid and the timestamp — the same primitive as core's one-time login / cancel links. The link cannot
  be forged without the account's stored hash, and it self-invalidates once the user logs in or
  changes their password. Comparison is strict `===`.
- `time() - timeout.unblock_email <= timestamp` enforces the link lifetime (`timeout.unblock_email`
  seconds, default 86400).

On a valid link for a still-blocked user: `$user->activate()->save()`, a confirmation message, and a
redirect to `user.login`. Already-unblocked → an informational message. Invalid/expired → an error
message with a "return to the unblock page" button (a `Link` render array; no user input is echoed).

## Link generation — `deactivate_users_generate_unblock_link($user)`

Builds an absolute URL to route `deactivate_users.unblock` with `uid`, current `timestamp`, and
`hash = user_pass_rehash($user, $timestamp)`. Surfaced as the `[user:unblock-link]` token, so it can
be embedded in the unblock email (and, if desired, the warning/deactivation templates). This is the
only supported way to mint a valid link.

## Operating notes

- The unblock link is a state-changing GET, but authorization rides on the cryptographic
  `user_pass_rehash` hash (functions as the one-time token), so no separate CSRF token is used —
  matching core's password-reset design.
- Turn the feature on with config `enable_unblock`; tune link lifetime with `timeout.unblock_email`.
  A very long lifetime lengthens the window a leaked link stays usable — keep it short (default 1 day).
- `hook_user_presave` records the resulting reactivation as an `account_status_record` row with
  `method = by system` (the unblock happens in an anonymous request context).
