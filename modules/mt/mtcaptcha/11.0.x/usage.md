<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MTCaptcha integrates the MTCaptcha service into Drupal forms, adding a bot-protection challenge to forms such as login, registration and contact.

---

MTCaptcha integrates the MTCaptcha service — a GDPR/privacy-oriented CAPTCHA alternative to
reCAPTCHA — into Drupal. After configuring the MTCaptcha site key and private key, it adds the
MTCaptcha widget to selected forms (login, registration, password reset, contact, comment, and
others), presenting a challenge that must be solved before the form submits, to keep automated spam
and bots out.

Configuration is at the module's settings form: you enter the keys obtained from your MTCaptcha
account and choose which forms get the challenge. The site key is public (rendered in the page) while
the private key is used server-side to verify the challenge response with MTCaptcha's API, so store
the private key as a secret. The module requires PHP 8.3 and loads its widget via defined JavaScript
libraries. Provides permissions to administer its settings and typically an "bypass"/exempt-style
permission so trusted roles are not challenged.

---

- Add MTCaptcha bot protection to Drupal forms.
- Protect login and registration from bots.
- Protect the contact form from spam.
- Configure the MTCaptcha site and private keys.
- Choose which forms show the CAPTCHA.
- Verify the challenge server-side via MTCaptcha API.
- Store the MTCaptcha private key as a secret.
- Use MTCaptcha as a privacy-focused reCAPTCHA alternative.
- Challenge the password-reset form.
- Challenge comment submissions.
- Exempt trusted roles from the challenge.
- Render the MTCaptcha widget via JS libraries.
- Require PHP 8.3 to run.
- Reduce automated spam submissions.
- Administer MTCaptcha settings via permission.
- Add a challenge to custom forms.
- Keep the site key public and private key server-side.
- Integrate MTCaptcha without Google reCAPTCHA.
- Block bot account registration.
- Set the CAPTCHA theme/appearance.
