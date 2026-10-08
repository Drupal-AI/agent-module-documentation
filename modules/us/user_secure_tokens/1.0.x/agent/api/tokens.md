<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Secure Tokens — token API

## Provided tokens (type `user`)
- `[user:one-time-login-url]` → `user_pass_reset_url($user, $options)`
- `[user:cancel-url]` → `user_cancel_url($user, $options)`

Both are core functions that produce HMAC-signed (`Crypt::hmacBase64`), timestamped, time-limited
URLs — the same mechanism as core password-reset / cancel links. This module adds NO custom token
generation, so there is no weak-RNG or replay concern introduced here.

## The enabler gate
`hook_token_info()` and `hook_tokens()` both early-return unless
`SecureTokens::getService()->hasEnabler()` is true. To make the tokens resolve:

```php
$secure = \Drupal\user_secure_tokens\SecureTokens::getService();
$enabler = $secure->acquireEnabler();   // hold this variable in scope
$html = \Drupal::token()->replace('[user:one-time-login-url]', ['user' => $account]);
// when $enabler goes out of scope the WeakReference clears and tokens go inert again
```

This deliberately prevents a login/cancel URL from leaking if `[user:one-time-login-url]`
appears in generic, user-influenced token replacement. Only resolve these tokens in code you
control, and only when emitting the link to the intended recipient.
