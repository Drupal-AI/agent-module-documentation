<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `recaptcha_element` form element & Webform handler

## In a custom form (code)

Add an element of `#type => 'recaptcha_element'`
(`Drupal\recaptcha_element\Element\RecaptchaElement`, extends core `Hidden`). The JS fills
the token on submit and the element's own `#element_validate` verifies it server-side.

```php
$form['antibot'] = [
  '#type' => 'recaptcha_element',
  // Optional per-element overrides; anything omitted falls back to
  // config recaptcha_element.settings:element_defaults.
  '#recaptcha' => [
    'action' => 'contact_form',
    'threshold' => 0.7,
    'verify_hostname' => FALSE,
    'error_message' => 'Please try again.',
  ],
];
```

- `#recaptcha` (array) merges over `element_defaults` from config (see
  `RecaptchaElement::processRecaptcha()`). Recognised keys: `action`, `threshold`,
  `verify_hostname`, `error_message`.
- When config `enabled` is `FALSE`, `processRecaptcha()` sets `#access = FALSE` and
  validation is skipped — no code changes needed to disable per environment.
- `processRecaptcha()` attaches library `recaptcha_element/recaptcha_element` and adds
  `data-recaptcha-element`, `data-recaptcha-element-action` and
  `data-recaptcha-element-site-key` attributes (only the public site key is emitted to the
  client) that the JS reads.
- `validateRecaptcha()` runs `google/recaptcha`'s `ReCaptcha($secret_key)` with
  `setExpectedAction()` + `setScoreThreshold()` (and `setExpectedHostname($request->getHost())`
  when `verify_hostname`), verifying `$element['#value']` against `$request->getClientIp()`.
  On failure it calls `$form_state->setError()` with the `Xss::filterAdmin`'d error message,
  and always logs via `recaptcha_element.logger`.

The static `RecaptchaElement::buildConfigurationForm()` renders the shared
action/threshold/verify_hostname/error_message sub-form; it is reused by the settings form
and the webform handler, not needed for plain forms.

## Client-side token provisioning

`js/recaptcha_element.js` listens for form `submit` (capture phase) and wraps
`jQuery.ajaxSubmit`, so both normal and AJAX submits are delayed until tokens are provisioned.
For each `[data-recaptcha-element]` it waits up to ~2s for `grecaptcha`, then calls
`grecaptcha.execute(siteKey, {action})` and writes the returned token into the hidden input
before re-submitting. If `grecaptcha` never loads the submit proceeds (fail-open on the
client; the server still validates whatever value arrives). The Google v3 API script is
loaded by `RecaptchaElementHooks::libraryInfoAlter()`, which appends `?render=<site_key>` to
the `google.recaptcha` library URL.

## Webform handler

Handler plugin id `recaptcha_element` (`RecaptchaElementWebformHandler`,
`CARDINALITY_SINGLE`, `RESULTS_IGNORED`). Add it to a webform under **Settings → Emails /
Handlers → Add handler → reCAPTCHA Element**. Options:

- **Use reCAPTCHA Element defaults** (checkbox) — when checked, uses the global
  `element_defaults`; when unchecked, exposes the shared action/threshold/verify_hostname/
  error_message sub-form for a per-webform override.
- **Override the element name** (checkbox) + **Element name** — custom machine name
  (`[a-z0-9_]`) for the hidden token input; otherwise the handler id is used.

`alterForm()` injects a `#type => 'recaptcha_element'` element (with the resolved
`#recaptcha` config) into the webform, so protection applies to every submission.
`submitConfigurationForm()` stores `element_name` (or NULL) and `recaptcha` (empty array =
use defaults) into handler configuration.
