<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ALTCHA is a privacy-friendly, GPU-free CAPTCHA alternative that protects Drupal forms with a proof-of-work challenge: the visitor's browser solves a small computation instead of clicking images, and no third-party tracking is required.

---

ALTCHA plugs into the contrib **CAPTCHA** module by implementing `hook_captcha()` to register a challenge type called **"ALTCHA"**, which you then attach to any form via a CAPTCHA point (e.g. the user login/registration/contact forms) at *Administration → Configuration → People → CAPTCHA*. The widget renders a proof-of-work checkbox; on submit, `altcha_captcha_validation()` decodes the base64 `altcha` payload and verifies it. It supports three integration types (config `altcha.settings:integration_type`): **self_hosted** (default — Drupal generates challenges at `/altcha/v1/challenge` and signs/verifies them with an HMAC secret key stored in State under `altcha-hmac-key`, created on install by `SecretManager`), **sentinel_api**, and **saas_api** (both call an external ALTCHA service with an API key, with an optional self-hosted fallback). The settings form lives at `/admin/config/people/captcha/altcha` (route `altcha.settings`, permission `administer altcha`) and exposes complexity (`max_number`, 1000–1000000), challenge `expire`/`delay`, auto-verification mode, a **floating/invisible** mode (`floating_enabled`, `floating_mode`, anchor/offset), logo/footer hiding, JS library overrides, and full i18n label overrides. The bundled `altcha-org/altcha` PHP library (and `ext-openssl`) does the signing/verification; the front-end uses the bundled ALTCHA web component. A submodule, **altcha_obfuscate**, adds field formatters that hide emails/phones/strings behind the same proof-of-work until a visitor reveals them. On uninstall the secret key and `altcha.settings` are removed.

---

- Protect the user registration form from bot signups without Google reCAPTCHA.
- Add a privacy-friendly, GDPR-safe CAPTCHA to a contact or webform.
- Replace image/puzzle CAPTCHAs with a one-click proof-of-work checkbox.
- Run entirely self-hosted so no user data is sent to a third party.
- Sign and verify challenges locally with an HMAC secret stored in Drupal State.
- Tune bot-deterrence strength by raising the proof-of-work complexity (`max_number`).
- Use an invisible/floating widget that verifies automatically on submit.
- Auto-verify on focus, on load, or on submit via the `auto_verification` setting.
- Attach ALTCHA to the login form to slow down credential-stuffing bots.
- Protect comment forms from spam submissions.
- Hide the ALTCHA logo/footer for a cleaner branded form.
- Localize all widget labels (verify, verifying, error, footer, etc.) per language.
- Switch to the hosted ALTCHA Sentinel or SaaS API with an API key when preferred.
- Fall back to self-hosted verification if the Sentinel API is unreachable.
- Set a challenge expiry/delay to balance UX and bot resistance.
- Override the bundled ALTCHA JS library with a custom or CDN build.
- Regenerate the self-hosted secret key from the settings page when rotating secrets.
- Serve challenges from `/altcha/v1/challenge` for cached pages (validation is stateless).
- Add accessible, keyboard- and screen-reader-friendly bot protection.
- Combine with the CAPTCHA module's per-form placement and default-challenge settings.
- Obfuscate email/phone fields against scrapers with the altcha_obfuscate submodule.
- Deploy CAPTCHA protection whose challenge/verification cost falls on the client, not the server GPU.
- Cache pages that contain the widget because the ALTCHA validation does not depend on a session.
