<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchEtat (captchetat) — agent index

Integrates the **French government CaptchEtat** service (PISTE, `api.gouv.fr`) as a **CAPTCHA
challenge type** for the contrib **Captcha** module. Package *Spam control*. Depends on
`captcha` (^2). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.4.

- **Settings form, config object `captchetat.settings`, schema, credentials** →
  [config/settings.md](config/settings.md)
- **The proxy route, `CaptchetatService` (OAuth token, image/audio, validate, healthcheck), JS flow** →
  [api/service.md](api/service.md)
- **`hook_captcha()` challenge type + submit-time validation** →
  [plugins/captcha-type.md](plugins/captcha-type.md)

## What it actually is (from source)

- **No entities, no plugin types, no permissions, no Drush.** It hooks into the Captcha module
  and proxies the government API.
- **Service** `captchetat.captchetat` = `Drupal\captchetat\Service\CaptchetatService`
  (`src/Service/CaptchetatService.php`, interface `CaptchetatServiceInterface`), args
  `@config.factory`, `@http_client` (Guzzle), `@cache.discovery`. API base is hardcoded to PISTE
  constants (`api.piste.gouv.fr` / sandbox), path `/piste/captchetat/v2`.
- **Controller** `CaptchetatController::getCaptcha` (`src/Controller/`) backs route
  **`captchetat.getcaptcha`** at `/simple-captcha-endpoint` — a server-side proxy that fetches the
  challenge image/audio from the API using an OAuth Bearer token.
- **Settings form** `CaptchetatSettingsForm` (`src/Form/`) at route **`captchetat.settings`**
  (`/admin/config/captchetat/settings`, permission `administer CAPTCHA settings` — defined by the
  Captcha module, not this one), writing config object **`captchetat.settings`**.
- **`.module`**: `hook_captcha()` (lists/generates the *CaptchEtat* type, attaches library
  `captchetat/captchetat`, sets validate callback `_captchetat_captcha_validate`),
  `hook_preprocess_captcha()` (aria wiring), `hook_help()` (renders README via markdown filter).
- **`.install`**: `hook_requirements()` runtime health check against the API;
  `hook_uninstall()` clears the cached token.
- **Front end**: `js/captchetat.js` (trivial `once` behavior) + vendored
  `assets/vendor/captchetat/captchetat-js.js` (fetches image/audio JSON from the proxy, injects
  `#captchaImage`, reload/sound buttons, and a hidden `captchetat-uuid` input).

## Config keys (`captchetat.settings`)

`sandbox` (bool, default TRUE), `client_id` (text), `client_secret` (text), `captcha_style`
(text, default `captcha`), `keep_focus` (bool). Full list + the 8 style options in
[config/settings.md](config/settings.md).
