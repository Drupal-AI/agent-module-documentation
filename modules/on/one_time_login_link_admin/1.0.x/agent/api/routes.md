<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller & the email — one_time_login_link_admin

The entire module is `one_time_login_link_admin.routing.yml`,
`src/Controller/OneTimeLoginLinkController.php` and `one_time_login_link_admin.module`.

## Routes

Both routes take the target account as an `entity:user` parameter and carry the same requirements
(`_permission: 'administer users'`, `_csrf_token: 'TRUE'`, `_admin_route: true`).

| Route name | Path | Controller method |
|---|---|---|
| `one_time_login_link_admin.generate_login_link` | `/admin/people/generate-one-time-login-link-admin/{user}` | `OneTimeLoginLinkController::generateLoginLink` |
| `one_time_login_link_admin.email_login_link` | `/admin/people/email-one-time-login-link-admin/{user}` | `OneTimeLoginLinkController::emailLoginLink` |

Because `_csrf_token: 'TRUE'` is set, the paths are only reachable with a valid `?token=…` for the
current session — do not link to them with a bare URL. Build links with
`Url::fromRoute('one_time_login_link_admin.generate_login_link', ['user' => $uid])` (or the
`email_login_link` route) and let Drupal add the token, exactly as the module's own
`hook_entity_operation` does.

## Entry point — People list operations

`one_time_login_link_admin_entity_operation()` (in the `.module`) adds two operations to every
**active** user row on `/admin/people` when the current user has `administer users`:

- op key `one_time_login_link_admin_generate_login_link` → *Generate one-time login link* (weight 10)
- op key `one_time_login_link_admin_email_login_link` → *Email one-time login link* (weight 11)

Each operation URL includes `query: {destination: <current path>}` so the controller can redirect
back to the People list after acting.

## Controller behavior

Both methods (`OneTimeLoginLinkController.php`) build the link the same way:

```php
$url = user_pass_reset_url($user) . '/login';   // core one-time-login URL + /login step-skip
```

`user_pass_reset_url()` is core's function; the appended `/login` targets core's
`user.reset.login` route so the recipient is logged in directly instead of seeing the "Log in"
confirmation page. The module itself defines **no** consume/login route — consumption is 100% core
(`user/reset/{uid}/{timestamp}/{hash}[/login]`).

- `generateLoginLink()` — sets a status message containing the URL in a `<code>` block plus a
  validity notice (`date.formatter->formatInterval($timeout)`), then redirects to `?destination`
  if present. The link is shown only to the operator who triggered it.
- `emailLoginLink()` — sends the link by mail to `$user->getEmail()` in the user's
  `getPreferredLangcode()`, then shows the same status messages and redirects. On a mail failure it
  logs a generic error to the `one-time-login-link-admin` logger channel (the error text does **not**
  contain the URL).

## Mail

`emailLoginLink()` calls
`mailManager->mail('one_time_login_link_admin', 'one_time_login_link', $to, $langcode, $params)` with
`$params['title']` = `system.site:name` and `$params['body']` = the localized link text.
`one_time_login_link_admin_mail()` handles key `one_time_login_link`: sets `from` to
`system.site:mail`, subject to `Your one time login link for @title`, and body to `$params['body']`.

## Config read (not written)

- `user.settings:password_reset_timeout` — how long the generated link stays valid (shown to the
  operator/user; the actual expiry is enforced by core).
- `system.site:name`, `system.site:mail` — email title/subject and `from` address.
