# Using the `recaptcha_element` form element & Webform handler

## In a custom form (code)

Add an element of `#type => 'recaptcha_element'`. It extends core `Hidden`; the JS fills
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

- `#recaptcha` (array) merges over `element_defaults` from config. Recognised keys:
  `action`, `threshold`, `verify_hostname`, `error_message`.
- When config `enabled` is `FALSE`, `processRecaptcha()` sets `#access = FALSE` and
  validation is skipped — no code changes needed to disable per environment.
- `processRecaptcha()` attaches library `recaptcha_element/recaptcha_element` and adds
  `data-recaptcha-element*` attributes (action + site key) the JS reads.
- `validateRecaptcha()` runs `google/recaptcha`'s `ReCaptcha($secret_key)` with
  `setExpectedAction()` + `setScoreThreshold()` (and `setExpectedHostname($request->getHost())`
  if `verify_hostname`), verifying `$element['#value']` against `$request->getClientIp()`.
  On failure it calls `$form_state->setError()` with the `Xss::filterAdmin`'d error message,
  and always logs via `recaptcha_element.logger`.

There is no `buildConfigurationForm()`-style helper needed for plain forms; the static
`RecaptchaElement::buildConfigurationForm()` exists to render the shared action/threshold/
verify_hostname/error_message sub-form (reused by the settings form and webform handler).

## Webform handler

Handler plugin id `recaptcha_element` (`RecaptchaElementWebformHandler`,
`CARDINALITY_SINGLE`, results ignored). Add it to a webform under **Settings → Emails /
Handlers → Add handler → reCAPTCHA Element**. Options:

- **Use reCAPTCHA Element defaults** (checkbox) — when checked, uses the global
  `element_defaults`; when unchecked, exposes the shared action/threshold/verify_hostname/
  error_message sub-form for a per-webform override.
- **Override the element name** (checkbox) + **Element name** — custom machine name for the
  hidden token input (`[a-z0-9_]`); otherwise the handler id is used.

`alterForm()` injects a `#type => 'recaptcha_element'` element (with the resolved
`#recaptcha` config) into the webform, so protection applies to every submission.
