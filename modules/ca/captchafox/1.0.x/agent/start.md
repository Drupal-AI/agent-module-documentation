<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchaFox (captchafox) — agent index

Integrates the hosted **CaptchaFox** anti-bot service as a challenge type for the **CAPTCHA
module**. Package `Spam control`. Depends on `captcha:captcha` (`^1.15 || ^2.0`). Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2. No entities, no plugin types, no Drush.

- **Install, keys, config object, route/permission, the captcha flow and verification** →
  [config/settings.md](config/settings.md)

## What it actually is

- Not a plugin. It hooks into the CAPTCHA module via **`hook_captcha()`**
  (`captchafox_captcha()` in `captchafox.module`), advertising one challenge type named
  **`CaptchaFox`** (`op = 'list'`). You attach it to forms on the CAPTCHA admin UI, not here.
- On `op = 'generate'` it emits a `<div class="captchafox" data-sitekey="…" data-lang="…">`
  widget (built with `Drupal\Core\Template\Attribute`) and attaches the `captchafox/captchafox`
  behavior plus a per-language external-script library. **Only the site key** goes into markup.
  If `site_key`/`secret_key` are unset it falls back to `captcha_captcha('generate', 'Math')`.
- Verification is the custom validate callback **`captchafox_captcha_validation()`**: reads the
  `cf-captcha-response` request param, and calls `CaptchaFox::validate()` which POSTs
  `{secret, response}` to `https://api.captchafox.com/siteverify`. Returns TRUE only on
  `success === TRUE`; otherwise logs API error codes and returns FALSE.

## Provided objects (from source)

- **Config form / route**: `CaptchaFoxAdminSettingsForm` (`src/Form/`, extends `ConfigFormBase`)
  at route `captchafox.admin_settings_form` → `/admin/config/people/captcha/captchafox`,
  requirement `_permission: 'administer captchafox'`. Menu + local-task links place it under the
  CAPTCHA settings.
- **Permission**: `administer captchafox` (`captchafox.permissions.yml`).
- **Config object**: `captchafox.settings` with `site_key`, `secret_key` (schema in
  `config/schema/captchafox.schema.yml`, defaults empty in `config/install/`).
- **Service**: `captchafox.drupal8post` → `Drupal\captchafox\CaptchaFox\Drupal8Post`
  (arg `@http_client`) — Guzzle POST wrapper implementing `RequestMethodInterface`.
- **Verification class**: `Drupal\captchafox\CaptchaFox\CaptchaFox` (`src/CaptchaFox/`).
- **JS**: `js/captchafox.js` (`Drupal.behaviors.captchafox` + `window.drupalCaptchafoxOnload`)
  renders/resets the widget via the CDN `captchafox.render()` API. Libraries defined statically
  (`captchafox.libraries.yml`) and per-language via `hook_library_info_build()`.
