<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CaptchEtat challenge type (Captcha integration)

CaptchEtat is not a Drupal plugin; it integrates through the contrib **Captcha** module's
`hook_captcha()` procedural API, all in `captchetat.module`.

## `captchetat_captcha($op, $captcha_type, $captcha_sid)`

- **`$op === 'list'`** → returns `['CaptchEtat']`, so the challenge appears as
  `captchetat/CaptchEtat` on the Captcha points page (`/admin/config/people/captcha`).
- **`$op === 'generate'` and `$captcha_type === 'CaptchEtat'`** → returns a captcha array:
  - `solution = 'TRUE'` — a placeholder; the real check is the custom validator below (Captcha's
    default string comparison is bypassed).
  - `form['captchetat']` — a `#type => container` with id `captchetat` and attributes
    `captchaStyleName` (config `captcha_style` + `FR`/`EN` language suffix) and `urlBackend`
    (`Url::fromRoute('captchetat.getcaptcha')`); attaches library `captchetat/captchetat`. A
    `<p class="captchetat-hint">` suffix instructs users about the reload/audio buttons.
  - `form['captchetat_input']` — the answer `textfield` (id `captchaFormulaireExtInput`, name
    `captchetat`, `autocomplete=off`, HTML `required`, maxlength 12).
  - `cacheable = TRUE`.
  - `captcha_validate = '_captchetat_captcha_validate'` — the custom validation callback.

## Validation `_captchetat_captcha_validate($solution, $response, $element, FormState $form_state)`

Reads `captchetat-uuid` (hidden input set by the JS) and `captchetat` (user code, upper-cased)
from `$form_state->getUserInput()`. Returns FALSE immediately if either is empty. Otherwise gets
an API token (`getApiToken()`) and returns `$service->validateCaptcha($uuid, $code, $token)` —
which is TRUE only if the upstream `/valider-captcha` responds exactly `'true'`. Any error, empty
token, or exception yields FALSE, so a failed or unreachable check **rejects** the submission
(fail-closed).

## `captchetat_preprocess_captcha(&$variables, $hook, $info)`

For challenge type `captchetat/CaptchEtat`, appends `captchetat-hint-{sid}` to the input's
`aria-describedby` so the instructional hint is announced to screen readers.

## `captchetat_help()`

On `help.page.captchetat`, reads `README.md` and renders it through the `markdown` filter (or
`markdown_easy` if present), falling back to a `<pre>` block. Content is the module's own bundled
README (not user input).

## Applying it

Use the Captcha module UI: add a Captcha point for the desired form id and select
`captchetat/CaptchEtat`, or set it as the site default challenge. No code changes are needed on
the target form.
