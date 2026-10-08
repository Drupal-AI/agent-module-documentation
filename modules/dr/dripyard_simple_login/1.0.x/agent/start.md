<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dripyard Simple Login (dripyard_simple_login) — agent index

Replaces Drupal's password login with **magic-link (passwordless) authentication** by repurposing
core's **password-reset** flow — it does not implement its own token system. Package `Dripyard`.
Depends only on core **`user`**. Core requirement `^11`. License GPL-2.0-or-later.
Version **1.0.x** (installed 1.0.0).

- **The magic-link flow end to end** (request form, mail trigger, link validation, session
  finalize, flood, required email-template step) → [api/magic-link-flow.md](api/magic-link-flow.md)
- **Route/UX alterations** (RouteSubscriber, `/login-password`, PassRedirectSubscriber, the hook
  class) → [routing/routes.md](routing/routes.md)

## What it actually is (from source)

- **No config, no schema, no permissions, no Drush, no plugins, no entities.** Ships one custom
  route, two event subscribers, one form, one controller, and one hook class.
- Custom route (`dripyard_simple_login.routing.yml`): **`dripyard_simple_login.login_password`** at
  `/login-password`, `_form` = core `\Drupal\user\Form\UserLoginForm`, requirement
  `_user_is_logged_in: 'FALSE'`, options `_maintenance_access: TRUE`, `no_cache: TRUE`. This is the
  password-login fallback. (The routing.yml header comment claims it also "blocks" `user.pass` with
  a FALSE requirement — that is stale; the block is actually a redirect, see below.)
- Services (`dripyard_simple_login.services.yml`): two `event_subscriber` tagged services —
  `RouteSubscriber` (route alteration) and `PassRedirectSubscriber` (kernel request redirect).

## Mechanism summary

- `Routing\RouteSubscriber::alterRoutes()` rewrites **`user.login`** → path `/login`, `_form` =
  `MagicLinkLoginForm`; and **`user.reset.login`** → `_controller` =
  `UserResetController::resetPassLogin`, title "Logging you in...". It does **not** touch `user.pass`.
- `Form\MagicLinkLoginForm` (form id `dripyard_simple_login_magic_link_form`): email field →
  loads account by mail then by name → registers/checks core `user.password_reset_ip` flood →
  if account exists and `isActive()`, sends core `_user_mail_notify('password_reset', $account)` →
  random `usleep` delay → shows the **same** message for any input → redirects to `<front>`.
  "Use password" submit routes to `dripyard_simple_login.login_password`.
- `Controller\UserResetController extends \Drupal\user\Controller\UserController`: `resetPassLogin()`
  calls `parent::resetPassLogin()` (core validation + `user_login_finalize`), then `deleteAll()`
  messages and adds "You're logged in!". **All token validation is core's.**
- `EventSubscriber\PassRedirectSubscriber::onKernelRequest()` (priority 31): if route is
  `user.pass`, 301-redirects to `user.login` with a warning message.
- `Hook\DripyardSimpleLoginHook` (attribute hooks): `local_tasks_alter` unsets `user.pass` tab;
  `gin_login_route_definitions_alter` + `theme_suggestions_page_alter` + `form_alter` add Gin Login
  theming/button styling to `/login-password`.

## Required manual setup

The magic link is delivered via core's **Password recovery** email, so the site's password-recovery
template at `/admin/config/people/accounts` must be reworded as a login link (see the flow doc).
Rate limiting is core's Flood control on the same page. There is no module settings form.
