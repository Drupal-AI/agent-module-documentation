<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Adequate Passwords

**Form:** `Drupal\adequate_passwords\Form\AdequatePasswordsSettingsForm`
**Route:** `adequate_passwords.admin_settings` — `/admin/config/people/adequate_passwords`
**Permission:** `administer site configuration` (core).
**Config:** `adequate_passwords.settings`.

## Settings
- **Minimum password strength** — one of `Strong` (80), `Good` (70), `Fair` (60), or `Do not check strength` (0).
- **Apply to roles** — checkboxes of roles (anonymous excluded). If none are selected the policy applies to everyone.
- **Enable message when password is adequate** — shows a confirmation message on success.

## How enforcement works
`hook_element_info_alter()` adds an `#after_build` to core's `password_confirm` element; the after-build `array_unshift`es `adequate_passwords_validate` so it runs **before** other validators. The validator recomputes a 0–100 strength score with `adequate_passwords_evaluate_password_strength()` — functionally equivalent to core's `Drupal.evaluatePasswordStrength` in `user.js` (length < 12 penalty, missing lowercase/uppercase/number/punctuation penalties, and a hard drop to 5 if the password equals the username) — and calls `$form_state->setErrorByName('pass1', …)` when the score is below the configured minimum, listing the same recommendations the core strength meter shows.

## Notes
- Purely additive: it only ever *adds* a validation error; it never relaxes or bypasses core authentication or the core password constraints.
- The random password generated during CLI site install is deliberately skipped so installation does not break.
- If `strength` is `0` (Do not check) or the current user's roles do not intersect the configured roles, validation is a no-op.
