<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Challenge build & validation (controller, hooks, CAPTCHA-module mode)

Everything is driven by the service `captcha_keypad.controller`
(`Drupal\captcha_keypad\Controller\CaptchaKeypad`, args `@config.factory`, `@private_key`,
`@datetime.time`) and the hook class `Drupal\captcha_keypad\Hook\CaptchaKeypadHooks`. Despite the
`Controller` namespace, this class exposes **no routes** — it is a plain form-building/validation
service.

## Building the challenge — `CaptchaKeypad::getForm(array &$form, $code = NULL)`

Adds a fieldset `captcha_keypad` (title "Security", weight just before form actions) containing:

- `captcha_response` — required textfield, `#size`/`#maxlength` = code size, class `captcha-response`,
  placeholder of bullet chars. This is where clicked digits land.
- `captcha_keypad_hidden` — hidden field holding a **signed token** (see below), not the plain code.
- `captcha_keypad_keypad_used` — hidden field, class `captcha-keypad-keypad-used`; JS sets it to
  `'1'` when a keypad button is clicked.
- `keypad` — `#theme => 'captcha_keypad_buttons'`, `#keys => [1..9,0]`, `#ck_theme => <theme>`.
- `code` — visible markup "Click/tap this sequence: **:code**" (the code is shown to the user).

The wrapper fieldset gets classes `captcha-keypad-wrapper`, `captcha-keypad-<code>`,
`captcha-keypad-theme--<theme>`, and `captcha-keypad-shuffle-keypad` when shuffle is on.

## Code generation — `generateCode()` / `getCode($digits)`

`getCode()` returns `rand(pow(10,$d-1), pow(10,$d)-1)` as a string, capping `$d` at 16. A code size
of `99` returns the literal `'testing'` (a test-only escape hatch, see below).

## Signed token — `getToken($code, $expires)` / `isValidToken($response, $token)`

- `TOKEN_LIFETIME = 21600` seconds (6 hours). `getForm()` stores
  `getToken($code, requestTime + TOKEN_LIFETIME)` in the hidden field.
- `getToken()` = `"<expires>:" . Crypt::hmacBase64("<expires>:<code>", privateKey . hashSalt)`.
  The token is an HMAC over the code, keyed by the site private key + hash salt — it cannot be
  produced without those secrets.
- `isValidToken($response, $token)`: rejects tokens without exactly one `:`; parses `<expires>`,
  rejects non-digit or past `expires`; then `hash_equals(getToken($response, $expires), $token)`.
  So the submitted `captcha_response` must HMAC-match the code that was signed, and the token must
  not have expired.

## Standalone validation — `validateForm(FormStateInterface &$form_state)`

Wired by `formAlter()` as the `captcha_keypad_form_validate` handler (`.module`), prepended to
`$form['#validate']`. Reads `captcha_keypad_hidden`, `captcha_keypad_keypad_used`,
`captcha_response` from `$form_state->getUserInput()`. Passes when
`isValidToken($captcha_response, $captcha_keypad_hidden)` is TRUE **and**
`captcha_keypad_keypad_used === '1'`; otherwise sets error "Invalid security code." on
`captcha_response`. (An `isTestingMode()` short-circuit returns valid only under the test UA with
code size 99 — see below.)

## Hooks (`CaptchaKeypadHooks`, `#[Hook]` methods; `.module` has `#[LegacyHook]` shims)

- `formAlter()` — returns early if contrib `captcha` is installed. Otherwise, if `form_id` is in
  config `captcha_keypad_forms` and the user is not admin-exempt
  (`captcha_keypad_skip_for_current_user()`), calls `getForm($form)`, prepends the validator, and
  `$form_state->setRebuild()`.
- `pageAttachments()` — attaches library `captcha_keypad/captcha_keypad` on every page.
- `theme()` — declares `captcha_keypad_buttons` (+ `__horizontal`/`__vertical` base-hook variants).
- `themeSuggestionsCaptchaKeypadButtonsAlter()` — adds `captcha_keypad_buttons__<theme>` when theme
  is not `plain`.
- `help()` — help text on `help.page.captcha_keypad`.

## CAPTCHA-module mode — `captcha($op, $captcha_type)` + `captcha_keypad_captcha_validate()`

When contrib `captcha` is installed, `formAlter()` does nothing and placement is via CAPTCHA points.

- `captcha('list')` → `['Keypad']`.
- `captcha('generate','Keypad')` → returns early if admin-exempt; otherwise builds the keypad with a
  freshly generated `$code` and returns `['form' => $form['captcha_keypad'], 'solution' => $code,
  'captcha_validate' => 'captcha_keypad_captcha_validate']`. Here the **plain code** is handed to the
  CAPTCHA module, which stores the solution server-side itself (so the signed hidden token is not the
  trust anchor in this mode).
- `captcha_keypad_captcha_validate($solution, $captcha_response, $element, $form_state)` (`.module`):
  returns TRUE when `$solution === $captcha_response` **and** `captcha_keypad_keypad_used === '1'`
  (or when `isTestingMode()` matches).

## Client behavior — `js/captcha_keypad.js` (`Drupal.behaviors.captchaKeypad`)

Clears the response field, appends a "Clear" control and an inline `.message` span, optionally
shuffles the button order (`Math.random`), and — on keypad button click — appends the digit's text
to `captcha_response` and sets `captcha_keypad_keypad_used` to `'1'`. Typing in the field is
actively cleared (message "Use keypad"), enforcing click/tap entry client-side.

## Test-only escape hatch — `isTestingMode($response)`

Returns TRUE only when `$response === 'testing'`, config `captcha_keypad_code_size === 99`, **and**
`drupal_valid_test_ua()` — i.e. only under Drupal's functional-test runner. On a real site this
cannot be triggered because `drupal_valid_test_ua()` is false. Used by both validators to let tests
submit a known answer without driving the keypad.
