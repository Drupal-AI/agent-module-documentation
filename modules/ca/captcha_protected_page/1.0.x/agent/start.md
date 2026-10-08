<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# captcha_protected_page — agent orientation

- Redirect-based CAPTCHA gate for configured paths; kernel REQUEST subscriber `src/EventSubscriber/CaptchaRedirectSubscriber.php` + verify form `src/Form/CaptchaForm.php`.
- Admin `/admin/config/system/captcha-protected-page` (`administer captcha protected pages`); config `captcha_protected_page.settings`.
- SECURITY (report — gate IS bypassable): (1) verification cookie name = `Crypt::hashBase64($path)` (unkeyed hash of a known path) with constant value `verified` → forgeable; (2) `shouldSkipVerification()` returns TRUE for any POST request → POST bypasses. Fix: signed/session-bound token, don't skip POST.
- It is a redirect layer only — not access control; underlying content perms unchanged.
