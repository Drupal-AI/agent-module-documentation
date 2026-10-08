# session_management — services & runtime

Defined in `session_management.services.yml`.

## `mo_session_monitor` — `SessionMonitor` (implements `SessionMonitorInterface`)
Reads/updates the core `sessions` table. Args: `@database`, `@session_manager`, `@logger.factory`.
- `getSessions(AccountInterface $account): array` — all rows for a uid (uid, sid, hostname, timestamp,
  session), ordered by timestamp.
- `getSession($sid): array` — one row by sid.
- `isCurrentActiveSession(string $session_id): bool` — `Crypt::hashBase64(sessionManager->getId()) === $sid`.
- `deleteSession($sid): void` — deletes a `sessions` row (wrapped in a transaction).
- `clear()` — clears the current session via the session manager.
- `getStoredSessionData(string $session): array` — parses the serialized session blob into
  `_sf2_attributes` / `_sf2_meta` using `@unserialize(..., ['allowed_classes' => FALSE])` (object
  instantiation disabled — safe against object-injection).

## `mo_login_restriction` — `LoginRestriction`
Arg: `@config.factory`. `isIpAllowedForLogin(string $user_ip, ?array $ranges = NULL): bool` — matches an IP
against `ip_range_list` (or a passed list). Supports CIDR (`Symfony IpUtils::checkIp`), `start-end` ranges,
and single IPs, for both IPv4 and IPv6 (via `inet_pton` byte comparison). Called from the login-form
validator.

## `mo_session_limit` — `SessionLimitSubscriber` (event_subscriber)
- `KernelEvents::REQUEST` → `onKernelEvent`: on `user.login` triggers the page-cache kill switch and can
  redirect with an IP-restriction message; flushes any queued `$_SESSION['mo_message']`; if authenticated and
  `isSessionLimitExceed()` (enabled + `count(getSessions) > session_limit_count`), rewrites the **oldest**
  `sessions` row to `uid 0` with a serialized `mo_message` warning (the displaced user is effectively logged
  out and sees the warning on their next request).
- `KernelEvents::RESPONSE` priority **-100** → `onKernelResponse`: on `user.logout` for the autologout flow
  (detected via the `mo_autologout` cookie), rewrites the redirect target to the login page — but leaves it
  alone if an OAuth SLO module already redirected to an external IdP.

## Logout controller — `UserSessionMonitor`
- `logout()` (route `session_management.logout`, POST + `_user_is_logged_in` + `_csrf_request_header_token`):
  logs the autologout and returns JSON `{logout_url}` = core `user.logout` with a CSRF `token` query, for the
  JS to navigate to. It logs out **only the current user**.
- `access(UserInterface $user, AccountInterface $account)`: custom access for the Sessions tab —
  `AccessResult::allowed()` only when `enable_session_monitor` is on **and** `$user->id() === $account->id()`
  (owner-only), else forbidden.
