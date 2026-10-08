<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yandex SmartCaptcha adds server-verified Yandex SmartCaptcha challenges to forms.

---

**Yandex SmartCaptcha integration** protects forms with Yandex's SmartCaptcha. It renders the widget with a site key and, on submit, verifies the token server-side by calling the Yandex validation API over HTTPS (Guzzle `http_client`) with the secret key and client IP. Verification is **fail-closed**: a non-200 response or a `status != ok` payload returns FALSE (invalid). Keys can come from config or environment variables (`YA_CAPTCHA_SITE_KEY` / `YA_CAPTCHA_SECRET_KEY`). Provides its own `administer yandex_smartcaptcha configuration` permission; configured at `yandex_smartcaptcha.settings_form`.

Use it to block automated spam submissions on selected forms.

---

- Add Yandex SmartCaptcha to forms.
- Verify the captcha token server-side.
- Block bot/spam form submissions.
- Render the SmartCaptcha widget with a site key.
- Call the Yandex validation API over HTTPS.
- Fail closed on verification errors.
- Load keys from config or environment variables.
- Send the client IP with the verification.
- Attach captcha to selected forms.
- Provide a dedicated admin permission.
- Configure keys at the settings form.
- Log HTTP/verification errors.
- Support env-var key storage for secrets.
- Protect login/registration/contact forms.
- Reject empty captcha tokens.
- Use Guzzle default TLS verification.
- Return TRUE only on status 'ok'.
- Reduce spam without user friction.