<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multi domain login (multi_domain_login) — agent index

**One login signs a user in on every configured domain of the same Drupal site. After a normal login the module walks the browser through the domain list in a chain of 303 redirects; each hop is a signed, short-lived login URL (uid + timestamp + HMAC) that finalizes a session on that domain, then hands off to the next, finally returning to the origin domain. Not iframes, not a shared cookie — sequential full-page redirects across real domains that all serve the same site.**

- **Version:** 1.0.x (release 1.0.11) · **Core:** `^10 || ^11` · **Package:** Other
- **Depends on:** `drupal:system`, `drupal:user` (core only). No composer requirements, no libraries.
- **Config:** `multi_domain_login.settings` (schema provided). Settings form route `multi_domain_login.admin_settings` → `/admin/config/multi_domain_login` (`administer site configuration`).
- **No permissions**, **no drush**, **no plugin types**, **no submodules**.
- Menu link `multi_domain_login.admin_settings` under *system.admin_config_system*.

## What you'd do → where

- **Set the domain list, timeout, force-logout, landing redirects, extra logging** → [configure/settings.md](configure/settings.md)
- **Understand the redirect chain, the HMAC login URL, the hooks/event, and how to extend or debug it** → [api/internals.md](api/internals.md)

## Mechanism at a glance (real names)

- `hook_user_login()` dispatches `UserLoginEvent` (`multi_domain_login_event_user_login`). Subscriber `multi_domain_login.event_user_login_subscriber` (`UserLoginSubscriber::onUserLogin`, priority **-100**; args `@language_manager`, `@current_route_match`, `@request_stack`) sets the request `destination` query to the `multi_domain_login.domain` route — **unless** the current route is `user.reset` or `multi_domain_login.login`. So Drupal's post-login redirect lands on `/user/login/domain`.
- Route `multi_domain_login.domain` → `/user/login/domain` (`_user_is_logged_in: TRUE`) → `MultiDomainLoginController::domain()`: kills page cache, computes the current domain, builds the **next** domain's login URL, returns a `TrustedRedirectResponse` (303, max-age 0).
- Route `multi_domain_login.login` → `/user/login/domain/{referrer}/{uid}/{timestamp}/{hash}/{langcode}` (`_permission: access content`) → `MultiDomainLoginController::login()`: `doLogin()` on this domain, then 303-redirect to the next hop; when the chain wraps back to the `referrer` domain it redirects to `redirect_success` (or `<front>`) on the origin domain, ending the chain.
- **Hash** (`MultiDomainLoginController::hash()`): `Crypt::hmacBase64($timestamp . $uid . $email, Settings::getHashSalt() . $account->getPassword())` — same construction as core one-time login links; compared with `hash_equals()`; rejected once `request_time - timestamp > timeout`.
- `hook_user_logout()`: unless the current route is `multi_domain_login.login`, calls `session_manager->delete($account->id())`, so logout propagates.
- **Config keys** (`multi_domain_login.settings`): `timeout` (int, default 30s), `domains` (sequence, default empty), `redirect_success` (string), `redirect_error` (string — stored but **not consumed** by the controller), `force_logout` (bool, default 1). `enable_extra_logging` (bool) is read by the controller but is **absent from the config schema**.
- **Alter hooks:** `hook_multi_domain_login_domains_alter(&$domains)`, `hook_multi_domain_login_domain_alter(&$domain, $domains)`, `hook_multi_domain_login_url_alter(&$url, $domain)`.
- Logger channel `logger.channel.multi_domain_login` (watchdog channel `multi_domain_login`).
- Requirement: every listed domain must serve the **same** Drupal site (shared hash salt + user table). Domains are matched/keyed by `crc32()` of the scheme+host string.
