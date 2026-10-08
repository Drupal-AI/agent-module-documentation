<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bot Blocker — configuration, filter mechanism & operation

Everything Bot Blocker does lives in one event subscriber and one config object. No install/update
hooks, no schema file, no dependencies.

## Install / enable

- `drush en bot_blocker -y` (or `ddev drush en bot_blocker -y`). Nothing else to install —
  `composer.json` `require` is empty and `core_version_requirement` is `^10 || ^11`.
- On install, `config/install/bot_blocker.settings.yml` seeds `bot_blocker.settings`.

## Config object: `bot_blocker.settings`

Edited by `BotBlockerSettingsForm` at `/admin/config/system/bot-blocker`
(route `bot_blocker.settings_form`, menu link `bot_blocker.settings` under
`system.admin_config_system`). Keys (shipped defaults in parentheses):

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `bot_blocker_return_gone` | bool | `false` | If true, blocked responses are **410 Gone**; else **403 Forbidden**. |
| `bot_blocker_html` | string (HTML) | `<h1>Access denied</h1><p>Excessive crawling detected.</p>` | Response body sent to blocked clients. Admin-authored, rendered verbatim. |
| `bot_blocker_banned_substrings` | array<string> | `[Scrapy, HTTrack, Go-http-client]` | Case-insensitive substrings; if the UA contains any, block. |
| `bot_blocker_min_versions` | map<family,int> | `{chrome:80, firefox:72, safari:13, edge:78, opera:66, ie:11}` | Per-family major-version floor; a UA at/below this is blocked. Omit a family to skip it. |

No `config/schema/*` file is shipped (so `data.json` `provides_config_schema` is false); config is
untyped. Values are set through the form or by importing the config object.

## Form behavior (`BotBlockerSettingsForm`)

- `getEditableConfigNames()` → `['bot_blocker.settings']`; extends `ConfigFormBase`.
- Three detail groups: *Response behavior* (`bot_blocker_return_gone`, `bot_blocker_html`),
  *Banned user-agent substrings* (`bot_blocker_banned_substrings`, one per line), *Minimum major
  browser versions* (six `number` fields, one per family; blank leaves that family unchecked).
- `validateForm()` rejects any version field that is non-numeric or negative (must be a
  non-negative integer or blank).
- `submitForm()` splits the substrings textarea on newlines with `array_map('trim', …)` +
  `array_filter`, collects only the non-blank version fields into `bot_blocker_min_versions`
  (`intval`), saves, and flashes a status message.
- `getBrowserVersionInfo()` / `createLinkFromUri()` render helper links to each vendor's release
  notes in field descriptions — cosmetic only.

## Request filter (`BotBlockerEventSubscriber::onKernelRequest`)

Service `bot_blocker.subscriber`, args `@module_handler`, `@cache.default`, `@config.factory`,
`@datetime.time`, `@current_user`. Subscribed to `KernelEvents::REQUEST` at **priority 101**.

1. Skip sub-requests (`isMainRequest()`) and users with `bypass bot blocker`.
2. Load `bot_blocker.settings`; fall back to in-code defaults if a key is unset (note: the code's
   fallback `min_versions` uses `ie => PHP_INT_MAX` and the fallback substrings differ slightly from
   the config/install defaults — but the shipped config always supplies these keys).
3. Read `User-Agent` header (empty string if absent).
4. **Substring gate:** block if the lowercased UA `str_contains` any lowercased banned substring.
5. **Version gate** (only if not already blocked and UA non-empty): match the six hardcoded regexes
   in order; the first family that matches ends the loop, and it blocks when
   `(int) captured_major <= min_versions[family]`.
6. If blocked: build `Response(FormattableMarkup($bot_blocker_html, []), 410|403)`,
   `setResponse()`, `stopPropagation()`.

An **absent or non-matching User-Agent is allowed** — matching is opt-in against known signatures.

## Counters (only under memcache/redis)

`$fast_cache = moduleExists('memcache') || moduleExists('redis')`. When true:

- Block path: `bumpCounter('blocked_requests')` and store `bot_blocker.last_blocked_request`
  (`ip` = `$request->getClientIp()`, `path` = `$request->getUri()`, `user_agent`).
- Allow path (non-empty UA): `bumpCounter('allowed_requests')`.
- `bumpCounter()` read-modify-writes an integer in `cache.default` and seeds
  `bot_blocker.metrics_start_time` (from `datetime.time`) once.

These are display/telemetry values with no UI route in 1.0.x (the reports menu link in
`bot_blocker.links.menu.yml` is commented out). Without a fast cache backend, no counters are kept.
The recorded IP is informational only and never feeds the block/allow decision.

## Permissions & routes

- Route `bot_blocker.settings_form` → `_permission: 'administer bot blocker'`
  (`bot_blocker.permissions.yml`, `restrict access: true`).
- `bypass bot blocker` — holders skip filtering entirely (checked first in `onKernelRequest`).

## Operating tips

- Blank a family's minimum to stop version-blocking it; set IE high to block all IE.
- Review traffic periodically and raise minimum versions as browsers age out (README guidance).
- Treat as a last line of defense; prefer CDN/WAF bot mitigation where available.
