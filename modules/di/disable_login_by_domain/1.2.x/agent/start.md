<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable login by domain (disable_login_by_domain) — agent index

Prevents user login when the site is being served on a hostname you have listed as disallowed.
The unit of matching is the **request `Host` header** (`Request::getHost()`), not the user's email
or account domain. Depends on core `user`. Version **1.2.0**, core `^9 || ^10 || ^11`.
Settings at `/admin/config/people/disable-login-by-domain` behind `administer site configuration`.
No permissions, Drush commands, or plugin types of its own.

## What it does

A single config list (`disable_login_by_domain.settings:domains`) holds the disallowed hostnames,
one per line; the literal `*` disallows every domain. The `disable_login_by_domain.host_status`
service (`HostStatus::isAllowedDomain()`) compares `getHost()` against that list by **exact string
match** (`in_array`) — `www.example.com` blocks only that exact host, not `example.com` or a
subdomain. When the host is disallowed, login is shut off at four points:

1. **Route access check** (`Access\PageAccessCheck`, service tag `disable_login_by_domain_page_access_check`),
   attached by `Routing\DisableLoginPageRouteSubscriber` to routes `user.login` **and**
   `user.login.http`. Returns `AccessResult::forbidden()` on a disallowed host — and also for any
   already-authenticated user. So the login page and core's REST/HTTP login route both 403.
2. **Block access** — `disable_login_by_domain_block_access()` forbids the `user_login_block`;
   `EventSubscriber\DisableUserLoginBlock` does the same for that block when placed via Layout Builder
   (only registers if `layout_builder` is present).
3. **Form alter** — `disable_login_by_domain_form_user_login_form_alter()` sets `#access = FALSE` on
   the `name`, `pass`, and `actions` elements and unsets the form's `#validate`/`#submit`, neutralizing
   any embedded copy of the login form.
4. **Login hijack** (optional, `hijack_login_action`, default **on**) —
   `disable_login_by_domain_user_login()` invalidates the session in `hook_user_login()` for anyone who
   reaches `user_login_finalize()` on a disallowed host, logging them back out. This is the catch-all
   for auth paths the route/form checks do not cover. The settings form warns to disable it if users
   log in outside Drupal's form (e.g. SSO), because it would log those users out too.

## Files

- `disable_login_by_domain.module` — `hook_block_access`, `hook_form_user_login_form_alter`, `hook_user_login`.
- `src/HostStatus.php` — the host-matching service (`isAllowedDomain()`).
- `src/Access/PageAccessCheck.php` — route access check for the login routes.
- `src/Routing/DisableLoginPageRouteSubscriber.php` — attaches the check to `user.login` + `user.login.http`.
- `src/EventSubscriber/DisableUserLoginBlock.php` — Layout Builder block disabling.
- `src/Form/SettingsForm.php` — the domains list + hijack toggle.
- `config/install/disable_login_by_domain.settings.yml` — defaults (`domains: []`, `hijack_login_action: true`).

## Configuration

See `agent/config/settings.md`. Two operational notes carried from the module itself: the matched
value comes from the `Host`/`X-Forwarded-Host` header, so configure Drupal **Trusted Host Settings**;
and the module documents itself as a convenience feature, not a hardened security control.
