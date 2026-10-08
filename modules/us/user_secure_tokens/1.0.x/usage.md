<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Secure Tokens exposes a user's one-time-login URL and account-cancel URL as replacement tokens, so trusted code can embed them (e.g. in a mail) without building the URLs by hand.

---

The module implements `hook_token_info()`/`hook_tokens()` to add `[user:one-time-login-url]` and `[user:cancel-url]`. Crucially, it does not mint its own secrets: the replacements call Drupal core's `user_pass_reset_url()` and `user_cancel_url()`, which build hashed, time-limited URLs using core's HMAC-based token scheme (`Crypt::hmacBase64` over uid, timestamp and the user's last-login/password data). So the tokens are as strong, unguessable and single-use-ish as core's password-reset and cancel links.

Because these tokens produce login/cancel links that bypass normal authentication, the module gates them behind an "enabler": the tokens only resolve while code has acquired a `SecureTokensEnabler` via `SecureTokens::acquireEnabler()` (tracked with a `WeakReference`). Outside that window `hasEnabler()` is false and the tokens return nothing — preventing accidental exposure through generic token replacement (for example in user-submitted content). Setup is developer-facing: require the module, then acquire the enabler in the narrow scope where you render the secure link.

---
- Add `[user:one-time-login-url]` to a custom mail built in code.
- Add `[user:cancel-url]` to an account-deletion notification.
- Generate a passwordless login link that reuses core's secure hash.
- Generate an account-cancel link without hand-coding the URL.
- Acquire the enabler before rendering, so tokens resolve only in scope.
- Keep secure tokens inert during generic/user-facing token replacement.
- Avoid reimplementing core's one-time-login URL logic.
- Reuse core's time-limited, HMAC-signed reset tokens.
- Send a custom welcome mail containing a one-time login link.
- Provide a "delete my account" link in a lifecycle email.
- Integrate secure user links into a custom notification module.
- Rely on core's single-use semantics for the login link.
- Gate token resolution via `SecureTokens::hasEnabler()`.
- Limit the enabler's lifetime with a WeakReference.
- Build admin tooling that emails secure account links.
