<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals — redirect chain, signed login URL, hooks and event

The module has no public service API to call; it is wired through core login/logout hooks and an
event, and exposes three `hook_*_alter()` extension points plus one event. This file documents the
mechanism so you can debug, integrate with, or extend it.

## The flow (real routes + methods)

```
normal Drupal login  ->  hook_user_login()  ->  dispatch UserLoginEvent
   ->  UserLoginSubscriber::onUserLogin (priority -100)
        sets request ?destination = /user/login/domain   (skipped on user.reset / multi_domain_login.login)
   ->  Drupal post-login redirect lands on  /user/login/domain
   ->  multi_domain_login.domain  =>  MultiDomainLoginController::domain()
        303 TrustedRedirectResponse to NEXT domain's login URL (referrer = crc32(origin domain))
   ->  http://next/user/login/domain/{referrer}/{uid}/{timestamp}/{hash}/{langcode}
        multi_domain_login.login  =>  MultiDomainLoginController::login()
          doLogin(uid,timestamp,hash)  ->  303 redirect to the hop after that
   ->  ... repeats across the domain list ...
   ->  when next domain == referrer (chain wrapped):  303 to redirect_success (or <front>) on origin
```

Note: the class docblock describes an iframe + key_value-storage design ("store hash, look up, remove
after use"). The **shipped implementation does neither** — it is a sequential chain of full-page
`TrustedRedirectResponse` (303) hops, and the hash is validated **statelessly** by recomputing the
HMAC, not by a stored one-time token. All responses set page-cache kill switch + `max-age 0`.

## Routes (`multi_domain_login.routing.yml`)

| Route | Path | Access | Controller |
|---|---|---|---|
| `multi_domain_login.domain` | `/user/login/domain` | `_user_is_logged_in: TRUE` | `MultiDomainLoginController::domain()` |
| `multi_domain_login.login` | `/user/login/domain/{referrer}/{uid}/{timestamp}/{hash}/{langcode}` | `_permission: access content` | `MultiDomainLoginController::login()` |
| `multi_domain_login.admin_settings` | `/admin/config/multi_domain_login` | `_permission: administer site configuration` | `MultiDomainLoginForm` |

Both login routes set `options._maintenance_access: TRUE`.

## `MultiDomainLoginController` (constructor DI)

Args (`create()`): `logger.factory` channel `multi_domain_login`, `page_cache_kill_switch`,
`datetime.time`, `current_user`, `module_handler`, `request_stack`.

- **`domain(Request)`** — triggers cache kill switch; `referrer = getRequestDomain()`; gets URL-language;
  `loginUrl($request, $referrer, $langcode, TRUE)`; returns 303 `TrustedRedirectResponse`.
- **`login($referrer,$uid,$timestamp,$hash,$langcode,Request)`** — cache kill switch; `doLogin(...)`;
  then `loginUrl($request,$referrer,$langcode,FALSE)`; 303 `TrustedRedirectResponse`.
- **`loginUrl($request,$referrer,$langcode,$skip_referrer_check)`** — finds the current domain in the
  configured `domains` array and takes `next()` (wrapping to `reset()`). If
  `!skip_referrer_check && crc32($nextDomain) == $referrer` the chain has come full circle → build the
  success URL (`redirect_success` via `Url::fromUserInput()`, else `<front>`), absolute + language-set.
  Otherwise build a fresh `multi_domain_login.login` URL for the next domain with a new `hash()`.
  In both branches the generated host is rewritten to the target domain with
  `str_replace($domains, $domain, $url)`, then `hook_multi_domain_login_url_alter($url, $domain)` fires.
- **`getRequestDomain(Request)`** — picks the configured domain whose string is a prefix of the request
  URI (`str_starts_with`), else falls back to `$request->getSchemeAndHttpHost()`; fires
  `hook_multi_domain_login_domain_alter(&$domain, $domains)`; returns `crc32($domain)`.
- **`getDomains()`** — reads `domains` config and fires `hook_multi_domain_login_domains_alter(&$domains)`.
- **`doLogin($uid,$timestamp,$hash)`** — returns an HTTP-style status int:
  - `timeout($timestamp)` true → `403`, logs `critical` "Login attempt expired".
  - user missing or `!isActive()` → `403`, logs `warning`.
  - already authenticated & `!force_logout` → `200`, logs `info` "already logged in" (no switch).
  - already authenticated & `force_logout` → `user_logout()` (then falls through to anonymous branch).
  - anonymous → if `hash_equals($hash, hash($user,$timestamp))` then `user_login_finalize($user)`, `200`;
    else `403`, logs `critical` "Invalid hash used".
- **`hash(UserInterface $account, $timestamp)`** —
  `Crypt::hmacBase64($timestamp . $account->id() . $account->getEmail(), Settings::getHashSalt() . $account->getPassword())`.
  Message = timestamp+uid+email; HMAC key = site hash salt + the user's stored password hash. Same
  construction family as core's one-time login link, so the URL is invalidated by a password change and
  cannot be produced without the server secret. Compared with `hash_equals()` (constant time).
- **`timeout($timestamp)`** — `request_time - $timestamp > config('timeout')`.

## Event

- **`UserLoginEvent`** (`src/Event/UserLoginEvent.php`), constant
  `UserLoginEvent::EVENT_NAME = 'multi_domain_login_event_user_login'`; public property `$account`
  (`UserInterface`). Dispatched from `multi_domain_login_user_login()`.
- **`UserLoginSubscriber`** (service `multi_domain_login.event_user_login_subscriber`, args
  `@language_manager`, `@current_route_match`, `@request_stack`) subscribes at priority **-100** and, on
  any route other than `user.reset` / `multi_domain_login.login`, sets the request `destination` query
  to the `multi_domain_login.domain` URL — this is what diverts the normal post-login redirect into the
  cross-domain chain. Subscribe at a lower priority to run after it, or override `destination` yourself.

## Extension points (`hook_*_alter`)

| Hook | Signature | Fired in |
|---|---|---|
| `hook_multi_domain_login_domains_alter` | `(&$domains)` | `getDomains()` — add/remove/reorder participating domains at runtime. |
| `hook_multi_domain_login_domain_alter` | `(&$domain, $domains)` | `getRequestDomain()` — override which configured domain the current request is treated as. |
| `hook_multi_domain_login_url_alter` | `(&$url, $domain)` | `loginUrl()` — rewrite each generated hop URL before the redirect. |

## Logout propagation

`multi_domain_login_user_logout($account)` — unless the current route is `multi_domain_login.login`,
calls `session_manager->delete($account->id())`, deleting that user's sessions so a sign-out on one
domain propagates.

## Debugging

- Turn on **Enable extra logging** (`enable_extra_logging`) for `debug` entries per logout / finalize.
- Watch the `multi_domain_login` channel: `ddev drush watchdog:show --type=multi_domain_login`.
- Common failure logs: `Login attempt expired` (raise `timeout`, or clock skew), `User @uid no longer
  active or found` (blocked/deleted account), `Invalid hash used in login attempt` (hash salt or
  password hash differs between domains → they must be the same Drupal site).
- Inspect the routes: `ddev drush route --name=multi_domain_login.domain` and
  `--name=multi_domain_login.login`.
