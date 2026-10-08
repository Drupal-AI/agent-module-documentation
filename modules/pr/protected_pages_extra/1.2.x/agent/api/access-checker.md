<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — access checker service & entity

## Service `protected_pages_extra.access_checker`

Class `Drupal\protected_pages_extra\ProtectedPagesExtraAccessChecker`. Single injectable service used by the middleware, login form, and cache subscriber. Public methods:

- `matchPath(string $path): ?ProtectedPageInterface` — the protecting entity for an **already-processed** internal path (language prefix stripped, alias resolved, decoded), or NULL. Matching order: exact internal path → exact alias → wildcard patterns (longest-first, checked against both internal path and alias). Callers must normalize the path first; the middleware runs the inbound `path_processor_manager` chain, the cache subscriber reads `path.current`.
- `checkPassword(string $candidate, ProtectedPageInterface $entity): bool` — honors `password.per_page_or_global` mode (`per_page_password` / `per_page_or_global` / `only_global`). Empty candidate always FALSE.
- `userCanBypass(?Request $request = NULL): bool` — TRUE if the current or session user has `bypass protected page access check`. Loads the user from the session `uid` when called pre-auth (from middleware).
- `isUnlocked(string $entity_id, ?Request $request = NULL): bool` — TRUE if the session holds an unexpired unlock for the entity (respects `password.session_expire_time`).
- `unlock(string $entity_id, ?Request $request = NULL): void` — mark the entity unlocked in the session (`[entity_id => timestamp]`).
- `isFlooded(string $client_ip, string $page_identifier): bool` — TRUE if the per-IP or per-page flood limit is exhausted; always FALSE for allowlisted IPs.
- `registerFlooding(string $client_ip, string $page_identifier): void` — record one failed attempt on both the IP and page counters; no-op for allowlisted IPs. Flood events: `protected_pages_extra.failed_login_ip` (id: IP) and `protected_pages_extra.failed_login_page` (id: `<entity_id>-<ip>`). Both entry points (login form + `?password=…` shortcut) share these events.
- `isIpAllowed(string $ip): bool` — TRUE if the IP matches any `flood.ip_allowlist` entry (`inet_pton` comparison; single IP or inclusive range).

Constant `ProtectedPagesExtraAccessChecker::BYPASS_PERMISSION = 'bypass protected page access check'`.

## Entity `protected_page`

Interface `Drupal\protected_pages_extra\ProtectedPageInterface extends ConfigEntityInterface`. Load via `\Drupal::entityTypeManager()->getStorage('protected_page')`. Methods: `getPaths(): string[]` / `setPaths(array): static`, `getPassword(): string` (hashed) / `setPassword(string): static`, `isAppendPasswordAllowed(): bool` / `setAppendPasswordAllowed(bool): static`.

## Enforcement architecture (read-only reference)

- `http_middleware.protected_pages_extra` (tag `http_middleware`, priority 30) — intercepts protected paths and returns a `RedirectResponse` to the login form with `?protected_page=<id>&destination=<path>`. Skips the login route and admin routes. The login form validates `destination` as internal (`UrlHelper::isExternal`) before redirecting.
- `protected_pages_extra.cache_subscriber` — `KernelEvents::RESPONSE` subscriber that sets `Cache-Control: private, no-store` and attaches the entity cache tag on protected responses.
- Optional `?password=…` shortcut only when the entity's `allow_append_password` is TRUE; shares the same flood counters.

## hook_mail

`hook_mail()` handles key `send_protected_page` (subject/body already token-substituted by `ProtectedPagesSendEmailForm`). No hooks are provided for third-party modules to implement.
