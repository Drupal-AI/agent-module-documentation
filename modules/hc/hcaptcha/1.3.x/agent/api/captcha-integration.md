<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How hCaptcha integrates and validates

hCaptcha has no plugins and no services of its own — it is a `hook_captcha()` implementation
plus a small PHP client. Everything is driven through the CAPTCHA module.

## Registration & rendering (`hcaptcha.module`)

- **`hook_captcha($op = 'list')`** returns `['hCaptcha']` — this is why the challenge
  identifier is `hcaptcha/hCaptcha`.
- **`hook_captcha($op = 'generate', 'hCaptcha')`**:
  - Reads `site_key` / `secret_key` from `hcaptcha.settings`.
  - If **both** are set, builds a widget via `HCaptcha::getWidget('hcaptcha_captcha_validation')`:
    a hidden `captcha_response` element plus markup
    `<div class="h-captcha" data-sitekey="…" data-theme="…" data-size="…" data-tabindex="…"></div>`,
    and attaches the `hcaptcha/loader` library. `cacheable => TRUE` (validation is
    session-independent, so protected pages stay cacheable).
  - The attached `drupalSettings.hcaptcha.src` is `hcaptcha_src` with query
    `hl=<current-langcode>&render=explicit&onload=drupalHcaptchaOnload` (auto-localized).
  - If a key is missing, it returns `captcha_captcha('generate', 'Math')` — the **Math
    fallback**, so the form is never left unprotected.

## Client JS (`js/hcaptcha-loader.js`, library `hcaptcha/loader`)

Injects the remote `<script id="hcaptcha-src">`, and once hCaptcha calls
`drupalHcaptchaOnload`, `Drupal.behaviors.hcaptcha` renders each `.h-captcha` element with
`hcaptcha.render(el, config)` (config derived from the element's `data-*` attributes).

## Server verification (`hcaptcha_captcha_validation`)

Callback registered as the widget's `captcha_validate`:
1. Returns `false` immediately if `$_POST['h-captcha-response']` or `secret_key` is empty.
2. Builds `new HCaptcha($site_key, $secret_key, [], new Drupal8Post())` and calls
   `validate($token, clientIp, max_score)`.
3. `HCaptcha::validate()` POSTs `secret`, `response`, `remoteip` to
   `https://hcaptcha.com/siteverify` (constant `HCaptcha::SITE_VERIFY_URL`).
   - If the response has a `score` (enterprise): success when `score <= max_score`.
   - Otherwise success when `success === true`.
4. On failure each error is logged to the **`hCaptcha`** logger channel. Error codes are mapped
   by `HCaptcha::getErrorCodes()` (`missing-input-secret`, `invalid-input-secret`,
   `sitekey-secret-mismatch`, `missing-input-response`, `invalid-input-response`,
   `bad-request`, `bad-response`, `connection-failed`, `unknown-error`).

## Request abstraction

`RequestMethod` (interface) → `Drupal8Post` (only implementation) wraps
`\Drupal::httpClient()->post()` with `http_errors => false`; non-200 responses become
`{"success": false, "error-codes": ["bad-response"|"connection-failed"]}`. To unit-test or
swap the transport, pass a different `RequestMethod` to the `HCaptcha` constructor.

## Classes

- `Drupal\hcaptcha\HCaptcha\HCaptcha` — widget builder + verifier (`getWidget`, `validate`,
  `isSuccess`, `getErrors`, `getResponseErrors`, `getErrorCodes`, `getAttributesString`).
- `Drupal\hcaptcha\HCaptcha\RequestMethod` — transport interface (`submit($url, $params)`).
- `Drupal\hcaptcha\HCaptcha\Drupal8Post` — Guzzle-based POST implementation.
