<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchaFox — setup, config, and the verification flow

Everything grounded in `captchafox.module`, `src/`, and the yml/config files.

## Install & enable

1. `composer require drupal/captchafox` (pulls `drupal/captcha ^1.15 || ^2.0`).
2. Enable both modules: `drush en captcha captchafox -y`.
3. Get a **site key** and **secret key** from https://portal.captchafox.com.
4. Enter them at **admin/config/people/captcha/captchafox** (route
   `captchafox.admin_settings_form`, permission `administer captchafox`).
5. On **admin/config/people/captcha** add a CAPTCHA point for each form, choosing challenge type
   **`CaptchaFox`**.

Until both keys are set, `captchafox_captcha('generate', …)` falls back to the Math CAPTCHA — so a
misconfigured install degrades to a working challenge, it does not silently disable protection.

## Config object & schema

Config name **`captchafox.settings`** (`config/schema/captchafox.schema.yml`,
`config/install/captchafox.settings.yml`):

| key | type | default | notes |
|-----|------|---------|-------|
| `site_key` | string | `''` | public; rendered as `data-sitekey` in the widget markup |
| `secret_key` | string | `''` | server-side only; sent to the siteverify API, never to the browser |

`CaptchaFoxAdminSettingsForm` (`src/Form/CaptchaFoxAdminSettingsForm.php`, extends
`ConfigFormBase`, form id `captchafox_admin_settings`) exposes both as required 40-char
textfields (`captchafox_site_key`, `captchafox_secret_key`) and writes them via
`getEditableConfigNames() → ['captchafox.settings']`. Standard core config form: CSRF-protected,
gated by the route permission.

## Routes, permissions, links

- Route `captchafox.admin_settings_form`: `/admin/config/people/captcha/captchafox`,
  `_form: CaptchaFoxAdminSettingsForm`, `_permission: 'administer captchafox'`.
- Permission `administer captchafox` (`captchafox.permissions.yml`) — the only permission.
- `captchafox.links.menu.yml` places the settings under `captcha.settings`;
  `captchafox.links.task.yml` adds a `CaptchaFox` local task on `captcha_settings`.

## The CAPTCHA integration (`captchafox.module`)

- `hook_captcha()` / `captchafox_captcha($op, $captcha_type)`:
  - `op = 'list'` → returns `['CaptchaFox']` (the challenge type name).
  - `op = 'generate'` for `CaptchaFox` → sets `solution = TRUE`, `captcha_validate =
    'captchafox_captcha_validation'`, a hidden `captcha_response` field, `cacheable = TRUE`, and a
    widget `#markup` `<div class="captchafox" data-sitekey="{site_key}" data-lang="{langcode}">`.
    Attaches libraries `captchafox/captchafox` and `captchafox/captchafox_{langcode}`; adds the
    config as a cacheable dependency. **Only the site key is placed in markup.**
- `hook_library_info_build()` builds one external-JS library per language pointing at
  `https://cdn.captchafox.com/api.js?hl={lang}&render=explicit&onload=drupalCaptchafoxOnload`
  (`type: external`, `async`, `defer`).
- `js/captchafox.js`: `Drupal.behaviors.captchafox` calls `captchafox.render(el, data)` on each
  `.captchafox` (guarding on the CDN global existing), marks it `captchafox-processed`, and
  `captchafox.reset()`s an already-processed one; `window.drupalCaptchafoxOnload` renders on
  explicit CDN load.

## Server-side verification (the security-relevant path)

`captchafox_captcha_validation($solution, $captcha_response, $element, $form_state)`:

1. Reads `site_key`/`secret_key` from config and the response from
   `Drupal::request()->get('cf-captcha-response')`.
2. **Returns FALSE immediately** if the response param is missing/NULL or `secret_key` is empty —
   no token, no pass.
3. Constructs `new CaptchaFox($site_key, $secret_key, [], $captchafox.drupal8post)` and calls
   `->validate($response)`.
4. Returns TRUE only if `->isSuccess()`; otherwise logs each mapped error via
   `Drupal::logger('CaptchaFox')->error(...)` and returns FALSE.

`CaptchaFox::validate()` (`src/CaptchaFox/CaptchaFox.php`) POSTs
`array_filter(['secret'=>secret_key, 'response'=>token])` to the constant
`CAPTCHAFOX_API = https://api.captchafox.com/siteverify` via the injected
`RequestMethodInterface`, and sets success only when the decoded body's `success === TRUE`.

`Drupal8Post::submit()` (`src/CaptchaFox/Drupal8Post.php`) uses core `@http_client` (Guzzle):
`Content-type: application/x-www-form-urlencoded`, body `http_build_query($params)`,
`http_errors => FALSE`. On HTTP 200 it returns the decoded JSON body; on a negative status it
returns `{"success": false, "error-codes": ["connection-failed"]}`; on any other non-200
`{"success": false, "error-codes": ["bad-response"]}`. A non-200, malformed, or network-error
response therefore resolves to **not-success** (validation fails), and the standard TLS handling
of core's HTTP client applies to the outbound call.

`RequestMethodInterface::submit(string $url, array $params): object` is the seam that lets the
transport be swapped/mocked in tests.

## Operating notes

- To rotate keys, re-enter them on the settings form; the config is a cacheable dependency of the
  generated challenge, so the widget markup refreshes automatically.
- The challenge is `cacheable = TRUE` because validation depends only on the live request token,
  not on a per-session solution — safe to serve on cached pages.
- No Drush commands, no cron, no entities. Uninstalling removes `captchafox.settings`.
