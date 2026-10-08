<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the redirect works (service, hooks, priority)

The module is a thin service plus two user hooks. There is no route interception and no
custom response — it works by setting Drupal's **`destination`** query parameter so core's
own login/logout redirect lands where you want.

## Hooks (in `login_redirect_per_role.module`)

- `hook_user_login($account)` → `login_redirect_per_role.service::setLoginDestination($account)`
- `hook_user_logout($account)` → `login_redirect_per_role.service::setLogoutDestination($account)`

`hook_install` sets the module weight to **1000** so these hooks run last (after other
modules that might set a destination).

## Service `login_redirect_per_role.service`

Class `Drupal\login_redirect_per_role\LoginRedirectPerRole` (interface
`LoginRedirectPerRoleInterface`). Constructor args: `current_route_match`, `request_stack`,
`config.factory`, `current_user`, `token`. Public API:

| Method | Purpose |
|---|---|
| `setLoginDestination(?$account)` | Compute the login URL and set it as the `destination` query param. |
| `setLogoutDestination(?$account)` | Same for logout. |
| `getLoginRedirectUrl(): ?Url` | The resolved login `Url`, or `NULL`. |
| `getLogoutRedirectUrl(): ?Url` | The resolved logout `Url`, or `NULL`. |
| `getLoginConfig(): array` / `getLogoutConfig(): array` | The weight-sorted role rows. |
| `isApplicableOnCurrentPage(): bool` | Whether a **login** redirect should apply here. |
| `stripSubdirectoryFromPath($uri): string` | Removes the base path so `Url::fromUserInput` accepts it. |

Constants: `CONFIG_KEY_LOGIN = 'login'`, `CONFIG_KEY_LOGOUT = 'logout'`.

## Selection algorithm (`getRedirectUrl`)

1. For **login** only, bail (return `NULL`) if `isApplicableOnCurrentPage()` is false.
2. Load the rows for the action and **sort ascending by `weight`** (`SortArray::sortByWeightElement`).
3. Walk the sorted rows; act on the **first** row where the user **has that role** *and*
   `redirect_url` is **non-empty**:
   - if `allow_destination` is true **and** the request already has a `destination`, stop and
     keep the existing destination (no override);
   - if `redirect_url === '<front>'`, use `Url::fromRoute('<front>')`;
   - otherwise run the value through the **Token** service, strip the subdirectory, and use
     `Url::fromUserInput()`.
4. `break` after the first match — lower weight = higher priority; empty URL = "fall through
   to the next role"; no match = `NULL` = default Drupal behavior.

So a user with several roles is redirected by the **highest-priority (lowest-weight) role
that has a non-empty Redirect URL**.

## Routes where a login redirect is suppressed (`isApplicableOnCurrentPage`)

Returns `FALSE` on: `user.reset`, `user.reset.form`, `user.reset.login`,
`commerce_checkout.form`, `change_pwd_page.reset`; and on `tfa.entry` **unless** there is no
`pass-reset-token` query arg. This keeps password-reset, Commerce checkout, and TFA flows
working. (Logout is not gated this way.)

## No hooks to implement

This module invites no `hook_*_alter` of its own (there is no `.api.php`). To customize
behavior, decorate `login_redirect_per_role.service` or read/write the
`login_redirect_per_role.settings` config directly.
