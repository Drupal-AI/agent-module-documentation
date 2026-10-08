<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# COOKiES Telegram Media (cookies_telegram_media) — agent index

A **COOKiES consent bridge** for the `telegram_media_type` module. It makes Telegram media
embeds load only after the visitor consents to the **`telegram`** service in the COOKiES banner.
Package **COOKiES**. Core `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.4.

- **How the consent gating works — hooks, the config service, and the JS behavior** →
  [config/consent-service.md](config/consent-service.md)

## What it actually is

- **No PHP classes, no `src/`.** The whole module is three hook implementations plus one JS
  behavior and one config entity. No routes, no permissions, no forms, no Drush, no plugin types,
  and **no config schema of its own** (schema for the consent service comes from the `cookies`
  module).
- **Dependencies:** `cookies` and `telegram_media_type` (both hard deps in
  `cookies_telegram_media.info.yml`). It is itself a submodule/companion of the COOKiES project.

## Provided pieces (from source)

- `cookies_telegram_media.module`
  - `hook_help` — help text on `help.page.cookies_telegram_media`.
  - `cookies_telegram_media_page_attachments()` — attaches library
    `cookies_telegram_media/default` **only when** `CookiesKnockOutService::getInstance()->doKnockOut()`
    is TRUE (i.e. COOKiES is actively blocking).
  - `cookies_telegram_media_preprocess_telegram_media_type()` — sets
    `script_attributes['data-sid'] = ['telegram']` and `script_attributes['type'] = ['text/plain']`
    on the rendered Telegram media, **neutralizing** the embed script until consent.
- `config/install/cookies.cookies_service.telegram.yml` — declares the COOKiES service `telegram`
  (label *"Telegram media"*, group `social`, `consent: true`, policy url
  `https://telegram.org/privacy#3-6-cookies`), with `cookies_telegram_media` as an **enforced**
  module dependency.
- `cookies_telegram_media.install` — `hook_install` sets module weight 11 (load after the media
  module); `update_8001` back-fills the enforced dependency on the service config.
- `js/cookies_telegram_media.js` — `Drupal.behaviors.cookiesTelegram`: on the
  `cookiesjsrUserConsent` event, if `telegram` is consented it **re-activates** the neutralized
  scripts; otherwise it renders a `.cookies-fallback--telegram` overlay.
- `cookies_telegram_media.libraries.yml` — library `default` (the JS + `css/*.min.css`, depends on
  `cookies/cookies.lib`).

## Operate it

- Enable the module (with `cookies` + `telegram_media_type`); the `telegram` consent service is
  installed automatically. There is **nothing to configure** in this module — manage the service
  from the COOKiES UI. Full mechanism in [config/consent-service.md](config/consent-service.md).
