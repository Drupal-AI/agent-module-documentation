<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MTCaptcha — agent index

Integrates the **MTCaptcha** service (privacy-focused, GDPR-friendly CAPTCHA) into Drupal forms for
spam/bot protection — login, registration, password reset, contact, comment, and any other form you
name. Version **11.1.0** (branch `11.1.x`). Core `^10 || ^11`. **Requires PHP 8.1.** The CAPTCHA
module is recommended but not a hard dependency (`.info.yml` declares no `dependencies`).

## How it works

- `hook_form_alter()` attaches the widget to each form listed in config (`form_enable` checkboxes +
  comma-separated `other_form_id`), respecting the `enablecaptcha` scope (all / logged-in /
  logged-out) and always covering `user_login_form` / `user_pass` for anonymous users. A multistep
  webform guard skips pages after the first.
- The widget is a `<div class="mtcaptcha-container" id="mtcaptcha-<rand>">`; MTCaptcha's client JS
  (loaded from `service.mtcaptcha.com`) renders into it. Client config (site key, theme, language,
  widget size, scope) is passed via `drupalSettings` as a JSON string.
- On submit, `mtcaptcha_captcha_validation()` (added to `#validate`) reads the posted
  `mtcaptcha-verifiedtoken` and verifies it **server-side** by GET to
  `https://service.mtcaptcha.com/mtcv1/api/checktoken` with the **private key**, checking the
  `success` flag. Missing token or missing private key set a form error.
- `hook_captcha()` also registers `mtcaptcha` as a CAPTCHA challenge type (list only).

## Configuration & keys

Settings form `mtcaptcha.settings` at `/admin/config/development/mtcaptcha`, gated by an
administration permission (the route requires `administer recaptcha`; the module also declares its
own `administer mtcaptcha` permission). Keys: **site key** is public (rendered to the client);
**private key** is a server secret used only for verification and is stored in plain
`mtcaptcha.settings` config — it is not printed into `drupalSettings`/JS. An "Advanced" option lets an
admin paste a raw MTCaptcha JS config snippet that is emitted verbatim into the page `<head>`.

## Key files

- `mtcaptcha.module` — form alter, widget attach, server-side verification, page attachments.
- `src/Admin/MTCaptchaSettings.php` — `ConfigFormBase` settings form.
- `src/StackMiddleware/Mtcaptcha.php` — HTTP middleware stub (pass-through; no behaviour).
- `mtcaptcha.routing.yml`, `mtcaptcha.permissions.yml`, `mtcaptcha.services.yml`,
  `mtcaptcha.libraries.yml`, `config/{install,schema}/mtcaptcha.settings.yml`, `js/*.js`.

## Diff 11.0.x → 11.1.x

- **Semantic versioning on the 11.x branch.** "11" is now documented as the module's own major
  version, not the Drupal core version; supported core is declared only via
  `core_version_requirement`.
- **Packaging fix (#3601306).** Removed the hard-coded `version` from `composer.json`; the
  Drupal.org packaging script assigns the release version (fixes `composer require
  drupal/mtcaptcha:^11.0` pulling the old `2.4.0`).
- **Dropped Drupal 9.** `core_version_requirement` is now `^10 || ^11` (was `^9 || ^10 || ^11`).
- **PHP minimum is 8.1** (`.info.yml` `php: 8.1`), stated to match Drupal 10.
- Behaviour of the verification path, widget attach, and settings form is otherwise unchanged.
