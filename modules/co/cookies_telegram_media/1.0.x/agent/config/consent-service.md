<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent gating: the `telegram` COOKiES service

This module has no `src/`. Everything is in `cookies_telegram_media.module`,
`config/install/cookies.cookies_service.telegram.yml`, `cookies_telegram_media.install`, and
`js/cookies_telegram_media.js`. This page is the full picture.

## Install / enable

- Requires `cookies` and `telegram_media_type` (declared in `.info.yml`; both must be present).
- `hook_install()` calls `module_set_weight('cookies_telegram_media', 11)` so this module's hooks
  run **after** the media module.
- Enabling imports `config/install/cookies.cookies_service.telegram.yml`, which registers the
  consent service. There is **no settings route and no admin form in this module** — nothing to
  configure here. The `data-sid` used everywhere is the literal string `telegram`.

## The consent service (config entity)

`cookies.cookies_service.telegram` (a `cookies_service` entity owned by the `cookies` module):

- `id: telegram`, `label: 'Telegram media'`, `group: social`, `consent: true`.
- `url: 'https://telegram.org/privacy#3-6-cookies'` (shown as the policy link).
- `info.format: full_html`, `info.value: ''` (empty description by default).
- `dependencies.enforced.module: [cookies_telegram_media]` — ties the service to this module so it
  is removed on uninstall. `hook_update_8001()` back-fills this enforced dependency on sites that
  installed before it was added.
- Schema for this entity type is provided by the `cookies` module, not here (`provides_config_schema`
  is false for this module).

## Blocking (server side)

Two hooks in `cookies_telegram_media.module`:

- `cookies_telegram_media_page_attachments(&$page)` — attaches the `cookies_telegram_media/default`
  library **only when** `CookiesKnockOutService::getInstance()->doKnockOut()` returns TRUE, i.e.
  when COOKiES is in knock-out (blocking) mode for the current visitor. When consent is already
  fully granted, the extra JS is not loaded.
- `cookies_telegram_media_preprocess_telegram_media_type(&$variables)` — runs for the
  `telegram_media_type` media theme hook and rewrites the embed script attributes:
  - `script_attributes['data-sid'] = ['telegram']`
  - `script_attributes['type'] = ['text/plain']`
  This is the neutralization: a `<script type="text/plain">` is **not executed** by the browser,
  so the Telegram embed and its cookies do not load until consent. The `data-sid` marks the script
  for later re-activation.

## Re-activation (client side)

`js/cookies_telegram_media.js` — `Drupal.behaviors.cookiesTelegram`:

- `attach()` — if `Drupal.behaviors.telegramMediaEntity` exists, it moves that behavior's `attach`
  aside (`initTelegram.attach`) and nulls the original, so the media module's own init does not run
  before consent. It then listens for the `cookiesjsrUserConsent` event.
- On `cookiesjsrUserConsent`: if `event.detail.services.telegram` is truthy → `activate()`,
  otherwise → `fallback()`.
- `activate(context)` — for each `script[data-sid="telegram"]`: clone it, remove the `type` and
  `data-sid` attributes, and `replaceWith` the clone's `outerHTML`. Removing `type="text/plain"`
  restores an executable script, so the previously-neutralized Telegram embed now runs.
- `fallback(context)` — calls `.cookiesOverlay('telegram')` on `.telegram-embedded-content`,
  showing the COOKiES placeholder overlay (styled by `css/cookies_telegram_media.min.css`, which
  sets a base64 Telegram-logo background on `.cookies-fallback--telegram`).

## Notes

- The embed markup itself (the Telegram widget `<script>` and its `src`) is produced by the
  `telegram_media_type` module and its media entities — this module only re-tags and re-enables it;
  it does not build the embed URL or fetch anything server-side.
- Nothing here is per-user configurable in this module. To change label/description/policy URL,
  edit the COOKiES service via the `cookies` admin UI or override the `cookies.cookies_service.telegram`
  config.
