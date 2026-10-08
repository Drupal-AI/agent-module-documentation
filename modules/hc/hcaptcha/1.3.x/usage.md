<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
hCaptcha registers a privacy-focused "hCaptcha" challenge type with the CAPTCHA module, so any Drupal form can be protected by the hCaptcha widget instead of a math question or reCAPTCHA.

---

hCaptcha is a thin integration layer on top of the contrib CAPTCHA module. It implements `hook_captcha()` to add a challenge type named `hCaptcha`; you then select that challenge for a form on the CAPTCHA administration (as a CAPTCHA point, e.g. `hcaptcha/hCaptcha`) or as the site's default challenge. All configuration lives in a single config object, `hcaptcha.settings`, exposed by an admin form at `/admin/config/people/captcha/hcaptcha` (route `hcaptcha.admin_settings_form`, gated by the `administer hcaptcha` permission): the **site key** and **secret key** issued by hCaptcha, the JavaScript API URL (`hcaptcha_src`, default `https://hcaptcha.com/1/api.js`), and widget options (theme light/dark, size normal/compact, tabindex, and a max_score for enterprise score-based verification). At form build the module renders a `<div class="h-captcha" data-sitekey="…">` and attaches the `hcaptcha/loader` JS library, which loads the remote API with `render=explicit` and renders the widget. On submit, the callback posts the `h-captcha-response` token plus the secret key and client IP to `https://hcaptcha.com/siteverify` (via the `Drupal8Post` request method) and passes only when the service returns success (or, for enterprise accounts, a risk score at or below `max_score`). If the site/secret keys are not configured, the module transparently falls back to CAPTCHA's built-in Math challenge, so enabling the module never leaves a form unprotected. Server verification errors are logged to the `hCaptcha` logger channel using hCaptcha's documented error-code list.

---

- Replace the default math CAPTCHA on the user registration form with the hCaptcha "I am human" checkbox widget.
- Protect the user login and password-reset forms from credential-stuffing bots.
- Add privacy-friendly bot protection to the site-wide contact form.
- Guard comment submission forms against automated spam.
- Protect a webform or custom form by assigning the hCaptcha challenge to its form ID as a CAPTCHA point.
- Set hCaptcha as the site's default CAPTCHA challenge for every protected form at once.
- Switch an existing site from Google reCAPTCHA to hCaptcha as a more privacy-respecting alternative.
- Present the hCaptcha widget in a dark theme to match a dark-styled site.
- Serve the compact widget size on narrow or mobile-first layouts.
- Set the widget tabindex so keyboard navigation flows correctly around other form fields.
- Configure score-based (invisible) verification with an enterprise hCaptcha account by tuning the maximum acceptable score.
- Localize the challenge automatically to the visitor's current interface language via the `hl` query parameter.
- Keep CAPTCHA-protected pages cacheable, because hCaptcha validation does not depend on a server-side session solution.
- Fail safe: keep forms protected with a math fallback while site/secret keys are still being provisioned.
- Log and diagnose verification failures (missing/invalid secret, sitekey-secret mismatch, connection failures) from the `hCaptcha` logger channel.
- Point the JavaScript API URL at an alternate or self-hosted endpoint by overriding `hcaptcha_src`.
- Roll out bot protection across a multilingual site without per-language configuration.
- Restrict who can change hCaptcha keys by granting the `administer hcaptcha` permission only to trusted admins.
- Deploy hCaptcha keys and widget options across environments as exported `hcaptcha.settings` config.
- Add a CAPTCHA point per form so only high-risk forms (registration, contact) show the widget.
- Use hCaptcha's earn-from-labeling model to monetize bot-blocking traffic while protecting forms.
- Provide accessible, human-friendly verification that avoids distorted-text puzzles.
- Combine with the CAPTCHA module's "administration mode" to quickly add hCaptcha to many forms.
- Test integration locally by leaving keys blank and observing the automatic math-challenge fallback.
