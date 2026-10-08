<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotBuster (botbuster) — agent index

Path-scoped anti-bot / anti-DDoS gate. A **Symfony HTTP middleware** intercepts requests to
admin-configured URL patterns and requires a **signed browser-token cookie**; missing/invalid →
an HTTP **503 JavaScript browser-verification challenge** (no CAPTCHA, no third-party service).
Package `BotBuster`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha3.
**No** entities, plugins, Drush commands, or module permissions of its own.

- **Enable, config object + schema + form, the private-files requirement, routes** →
  [config/settings.md](config/settings.md)
- **The middleware, token signing/validation, path matching, challenge file generation** →
  [api/middleware.md](api/middleware.md)

## What it actually is (from source)

- One **middleware**: `Middleware\DdosProtectionMiddleware` (service `botbuster.ddos_protection_middleware`,
  `http_middleware` priority **300**, `responder: true`). Decorates the HTTP kernel, checks protected
  paths, validates the token cookie, and either passes through or returns the challenge.
- One **service**: `Service\ChallengeFileGenerator` (`botbuster.challenge_file_generator`) — renders
  `challenge.html` and writes runtime config `botbuster.json` under `private://botbuster/`.
- One **event subscriber**: `EventSubscriber\ConfigSubscriber` — on `ConfigEvents::SAVE` of
  `botbuster.settings`, regenerates both files.
- One **config form**: `Form\SecuritySettingsForm` (`botbuster_settings_form`) at route
  `botbuster.settings` → `/admin/config/system/botbuster`, permission **`administer site configuration`**.
- One static **helper**: `Helper\ProtectedPathHelper` — standalone path-pattern matcher (duplicates the
  middleware's matching logic; not wired into the request path in this release).
- Assets: `templates/challenge.html.twig`, `js/challenge.js`, `css/challenge.css`.

## Mechanism in one paragraph

Config lives in `botbuster.settings` but the middleware does **not** read config at runtime — it reads
`private://botbuster/botbuster.json` (regenerated on config save + cache flush) for `enabled`,
`patterns`, `token_lifetime`, `cookie_name`. On a protected-path request with no valid cookie it returns
the pre-rendered `private://botbuster/challenge.html` (placeholders `<%REDIRECT_URL%>` / `<%CHALLENGE_TOKEN%>`
filled via `json_encode` with hex flags), status **503**, and clears the cookie. Tokens are
`base64(expiry . '|' . hash_hmac('sha256', expiry, hashSalt))`; validation uses `ctype_digit`, an
expiry window (`>now`, `<= now + lifetime + 300s` skew) and **`hash_equals`**.

## Notes / caveats

- **Requires a private file system** — `hook_requirements` (`botbuster.install`) errors at install and
  runtime unless `$settings['file_private_path']` is set; the generator also checks the `private://`
  stream wrapper before writing (avoids creating a literal `private:/botbuster` dir in the webroot).
- The challenge is a **lightweight** control: it requires only that a client store and return a
  server-issued cookie value. It stops clients that ignore cookies; it is **not** a CAPTCHA and does
  not defeat determined/headless bots. Pair with rate limiting for stronger protection.
- The middleware reads **no client IP** and keeps **no IP allow/block list** — decisions are purely
  path-pattern + signed-cookie based, so there is no proxy-header / `X-Forwarded-For` trust surface.
- No external HTTP calls and no API keys. Redirect target is validated to same-site
  relative paths only; output is `json_encode`-escaped.
