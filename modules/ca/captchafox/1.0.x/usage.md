CaptchaFox adds the privacy-focused, hosted CaptchaFox challenge as a CAPTCHA type for Drupal's CAPTCHA module, verifying submissions server-side against the CaptchaFox API.

---

CaptchaFox is a thin integration between Drupal's CAPTCHA module and the hosted CaptchaFox anti-bot service (captchafox.com). Once enabled it registers a `CaptchaFox` challenge type via `hook_captcha()`; you assign it to any form on the CAPTCHA administration page (admin/config/people/captcha). The rendered form gets a `<div class="captchafox" data-sitekey="…">` widget and loads the CaptchaFox script from cdn.captchafox.com, which draws the challenge in the visitor's browser. On submit, the returned response token is validated server-side: Drupal POSTs the token plus the configured secret key to https://api.captchafox.com/siteverify over HTTPS and only allows the form to proceed when the API returns `success: true`. Configuration is minimal — a site key and a secret key entered at admin/config/people/captcha/captchafox — and the only permission provided is "administer captchafox". If either key is unset the module falls back to the CAPTCHA module's built-in Math challenge. It requires the CAPTCHA module (`captcha:captcha`, `^1.15 || ^2.0`) and core `^10 || ^11`.

---

- Add a privacy-friendly, GDPR-compliant CAPTCHA to Drupal forms without reCAPTCHA/Google.
- Protect the user login form from credential-stuffing and brute-force bots.
- Protect the user registration form from automated spam-account creation.
- Protect the password-reset (user password) form from abuse.
- Protect the contact form (site-wide and personal) from spam submissions.
- Protect comment forms from spam comments.
- Protect Webform submissions with a hosted CAPTCHA challenge (via CAPTCHA points).
- Gate anonymous node/entity creation forms behind a bot challenge.
- Gate newsletter/subscription signup forms against bot signups.
- Apply a CAPTCHA to search forms to deter scraping bots.
- Replace an existing reCAPTCHA/hCaptcha/Turnstile integration with a privacy-first alternative.
- Centrally choose which forms get the challenge from admin/config/people/captcha.
- Serve the challenge in the visitor's language automatically (the widget's `hl`/`data-lang` follows the current interface language).
- Verify challenges server-side so a forged or replayed client token cannot bypass validation.
- Fall back to the Math CAPTCHA automatically when the site/secret keys are not yet configured.
- Restrict who can configure the integration using the "administer captchafox" permission.
- Show the challenge on cached pages (the challenge type is marked cacheable).
- Log verification errors returned by the CaptchaFox API to the Drupal logger for troubleshooting.
- Comply with data-protection requirements by using a European, privacy-focused CAPTCHA vendor.
- Reduce spam on any custom or contrib form that integrates with the CAPTCHA module.
