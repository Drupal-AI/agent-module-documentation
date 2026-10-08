<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bot Blocker (bot_blocker) — agent index

Blocks incoming HTTP requests by **User-Agent** — a banned-substring match or an out-of-date
major browser version — returning a configurable **403** (or **410**) before Drupal does page
work. Package `Performance and scalability`. Core `^10 || ^11`. License GPL-2.0-or-later.
No dependencies, no Composer requirements. Version 1.0.1.

- **All configuration, the request-filter mechanism, permissions, and counters** →
  [config/settings.md](config/settings.md)

## What it actually is

- One kernel event subscriber, `BotBlockerEventSubscriber` (service `bot_blocker.subscriber`,
  `src/EventSubscriber/BotBlockerEventSubscriber.php`), on `KernelEvents::REQUEST` **priority 101**,
  main-request only.
- One config form, `BotBlockerSettingsForm` (`src/Form/BotBlockerSettingsForm.php`), route
  `bot_blocker.settings_form` at `/admin/config/system/bot-blocker`, menu link
  `bot_blocker.settings`.
- Two permissions (`bot_blocker.permissions.yml`): `administer bot blocker` (restrict access) and
  `bypass bot blocker`.
- One config object, `bot_blocker.settings` (`config/install/bot_blocker.settings.yml`).
  **No config schema shipped, no submodules, no plugins, no Drush, no hook_install/update, no
  entities, no libraries, no outbound HTTP.**

## Mechanism (from source)

- `onKernelRequest()`: returns early if not the main request, or if the current user has
  `bypass bot blocker`. Reads `bot_blocker.settings` via `config.factory`.
- **Block decision (UA only):** lowercases `User-Agent`; blocks if it `str_contains` any configured
  banned substring (default `Scrapy`, `HTTrack`, `Go-http-client`). Otherwise runs six hardcoded
  regexes (`/Chrome\/(\d+)/`, `/Firefox\/(\d+)/`, `/Version\/(\d+).+Safari\//`, `/Edg\/(\d+)/`,
  `/OPR\/(\d+)/`, `/MSIE\s(\d+)/`); the first family that matches blocks when its captured major
  is `<=` the configured `bot_blocker_min_versions[family]`.
- **Response:** on block, builds `new Response(new FormattableMarkup($blocked_message, []), $status)`
  where `$status` is 410 when `bot_blocker_return_gone` is set else 403, calls `setResponse()` +
  `stopPropagation()`. `$blocked_message` is the admin-config HTML.
- **Counters (opt-in):** only when `memcache` or `redis` module is enabled, `bumpCounter()`
  increments `bot_blocker.blocked_requests` / `bot_blocker.allowed_requests` in `cache.default`,
  seeds `bot_blocker.metrics_start_time`, and on a block stores `bot_blocker.last_blocked_request`
  (`ip` from `$request->getClientIp()`, `path` = URI, `user_agent`). These are metrics/telemetry
  only — the IP is **not** used in any block/allow decision.
- Config form persists `bot_blocker_return_gone`, `bot_blocker_html`,
  `bot_blocker_banned_substrings` (textarea → trimmed array), `bot_blocker_min_versions`
  (per-family number fields, blank = family skipped). `validateForm()` requires each version to be
  a non-negative integer or blank.

## Notes for agents

- Detection is entirely from **static admin config**; there is no allowlist/denylist by IP, no
  remote lookup, and no outbound request. The `bot_blocker_html` body is trusted admin config.
- The `2.0.x` branch is a separate rewrite ("threat detection"); this doc covers `1.0.x` only.
