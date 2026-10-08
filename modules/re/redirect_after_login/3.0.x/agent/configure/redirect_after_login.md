# Configure Redirect After Login

## Where

- Route: `redirect_after_login.admin_settings` — path `/admin/config/people/redirect`
  (form `\Drupal\redirect_after_login\Form\LoginRedirectionForm`).
- Menu link "Set Login Destination" under People (`user.admin_index`).
- Legacy path `/admin/config/system/redirect` (route
  `redirect_after_login.admin_settings_redirect`) just redirects to the form above.
- Both routes require the `administer redirect_after_login settings` permission.

## Settings form fields

The form loads every role except `anonymous` and renders one **required** textfield per
role, plus one exclude textarea:

| Field | Type | Notes |
|---|---|---|
| one per role (keyed by role id) | textfield | Destination URL for users with that role. Required. Accepts `<front>` (saved as `/`). |
| `exclude_urls` | textarea | One path per line; login on a matching path skips redirection. Supports `*` wildcard. |

**URL validation** (on save): each role value must match `^[#?\/]+` (start with `#`, `?`,
or `/`) **or** equal `<front>`, and must be a valid existing path (checked with
`path.validator`). External URLs are rejected — redirects are internal only.

## Config object — `redirect_after_login.settings`

Schema `config/schema/redirect_after_login.schema.yml`. No `config/install` default file, so
values exist only after the form is saved.

| Key | Type | Meaning |
|---|---|---|
| `login_redirection` | sequence (role id → string) | Per-role destination path. `<front>` is stored as `/`. |
| `exclude_urls` | string | Newline-separated paths (with `*` wildcards) that skip redirection. |

Set via Drush, e.g. per-role map and exclude list:

```
drush cset redirect_after_login.settings login_redirection.editor /admin/content -y
drush cset redirect_after_login.settings login_redirection.administrator /admin -y
drush cset redirect_after_login.settings exclude_urls "/node/*" -y
```

Settings are a config object, so they export/deploy with `drush config:export`.

## How the redirect is applied (priority)

Implemented in `hook_user_login()` (`redirect_after_login.module`):

1. Skips non-`html` request formats.
2. If a `destination` query param other than `/user/login` is already present, it is left
   untouched (an explicit deep link wins).
3. In maintenance mode without the bypass permission, destination is forced to `/`.
4. If the current path matches any `exclude_urls` entry (via `path.matcher`), it returns
   without redirecting. Password-reset routes (`user.reset`, `user.reset.login`) are also
   skipped.
5. **Role priority:** the destination is `login_redirection[array_reverse($roles)[0]]`, i.e.
   the **last role** in the user's `getRoles()` list; falls back to `/` if unset.
6. A `RedirectAfterLoginEvent` is dispatched (see below); if a subscriber disallows the
   redirect it stops.
7. Otherwise it sets the request `destination` query param to the resolved URL and Drupal
   lands the user there.

## Altering / cancelling in code (event)

`\Drupal\redirect_after_login\Event\RedirectAfterLoginEvent` is dispatched with the resolved
URL before the redirect. A subscriber can call `$event->setUrl($newUrl)` to change the
target or `$event->setRedirectAllowed(FALSE)` to cancel; read with `getUrl()` /
`isRedirectAllowed()`. There is no named event-constant class — subscribe to the event class
name.

The module also implements `hook_passwordless_login_redirect_alter()` to apply the same
per-role destination when the Passwordless login module drives the redirect.

## vs. Login Destination

This module only maps a destination per role from one form (no rules, conditions, or
language/page context). Use Login Destination when you need conditional rules.
