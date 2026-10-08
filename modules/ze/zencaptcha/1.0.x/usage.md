<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ZENCAPTCHA integrates the Zencaptcha hosted service with the CAPTCHA module.

---

**ZENCAPTCHA** adds a CAPTCHA type (via the `captcha` module) backed by the Zencaptcha service. On submit it posts the solution and secret key to `https://www.zencaptcha.com/captcha/siteverify` (Guzzle over HTTPS) and can optionally validate a submitted email address (blocking invalid/disposable addresses). Site key and secret key are configured at `zencaptcha.admin_settings_form` behind the module's own `administer zencaptcha` permission.

NOTE: the verification code **fails open** — if the verify response body is empty or the HTTP status is not 200 it returns TRUE (passes the CAPTCHA), so a downed/blocked verify endpoint silently disables protection.

---

- Add a Zencaptcha CAPTCHA type.
- Integrate with the core-contrib CAPTCHA module.
- Verify the solution against Zencaptcha.
- Post solution+secret over HTTPS to siteverify.
- Optionally validate submitted email addresses.
- Block invalid or disposable emails.
- Configure site and secret keys in admin.
- Gate config behind 'administer zencaptcha'.
- Protect forms from bots and spam.
- Show a human-verification challenge.
- Use the CAPTCHA module's placement UI.
- Log verification failures.
- Reject submissions missing a solution.
- Support GDPR-friendly captcha (no cookies).
- Read the solution from POST data.
- Apply to any CAPTCHA-enabled form.
- Score submissions via the Zencaptcha response.
- Reduce fake user registrations.