<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MTCaptcha integrates the MTCaptcha service into Drupal forms, adding a bot-protection challenge to forms such as login, registration and contact.

---

MTCaptcha integrates the MTCaptcha service — a GDPR/privacy-oriented CAPTCHA alternative to
reCAPTCHA — into Drupal. After you configure the MTCaptcha site key and private key, it adds the
MTCaptcha widget to selected forms (login, registration, password reset, contact, comment, and any
other form IDs you list), presenting a challenge that must be solved before the form submits, to keep
automated spam and bots out.

Configuration is at the module's settings form (`mtcaptcha.settings`, under Configuration →
Development): you enter the keys obtained from your MTCaptcha account and choose which forms get the
challenge and for which users (all, logged-in only, or logged-out only). The site key is public (it
is passed to the client so the widget can render) while the private key is used server-side to verify
each challenge response with MTCaptcha's `checktoken` API. An advanced option lets an administrator
paste a raw MTCaptcha JavaScript config snippet for full widget customization. The module targets
Drupal 10 or 11, requires PHP 8.1, works with the CAPTCHA module, and loads its widget via defined
JavaScript libraries served from MTCaptcha.

---

- Add MTCaptcha bot protection to Drupal forms.
- Protect login and registration from bots.
- Protect the contact form from spam.
- Configure the MTCaptcha site and private keys.
- Choose which forms show the CAPTCHA.
- Scope the challenge to all, logged-in, or logged-out users.
- Verify the challenge server-side via MTCaptcha's checktoken API.
- Use MTCaptcha as a privacy-focused reCAPTCHA alternative.
- Challenge the password-reset (lost password) form.
- Challenge comment submissions.
- Add the challenge to custom forms by listing their form IDs.
- Render the MTCaptcha widget via defined JS libraries.
- Pick one of the built-in widget themes/skins to match the site.
- Localize the widget into 60+ languages.
- Choose Standard or Modern Mini widget size.
- Paste a custom MTCaptcha config snippet for advanced setups.
- Show or hide a captcha label above the widget.
- Reduce automated spam submissions.
- Block bot account registration.
- Administer MTCaptcha settings via an admin permission.
- Keep the site key public and the private key server-side.
- Integrate MTCaptcha without Google reCAPTCHA.
- Run on Drupal 10 or 11 with PHP 8.1.
