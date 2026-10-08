CaptchEtat adds the French government CaptchEtat (PISTE / api.gouv.fr) image-and-audio CAPTCHA to Drupal as a challenge type for the contrib Captcha module.

---

CaptchEtat is a spam/bot-protection integration for French public-sector Drupal sites. It registers a "CaptchEtat" challenge type with the Captcha module (via `hook_captcha()`), so you attach it to any form from the Captcha module's *Captcha points* page. On render, front-end JavaScript fetches a distorted-text challenge image (with a spoken-audio alternative and a reload button) from a Drupal proxy route; that route authenticates to the CaptchEtat API over OAuth2 client-credentials using a Client ID / Client Secret you obtain from PISTE. When the form is submitted, the user's typed code and the challenge UUID are validated against the API, and the submission is rejected if validation fails. The module ships a settings form for credentials, sandbox/production mode, the CAPTCHA character style, and a focus option; a sandbox environment is the default so you can test before going live. This branch (2.0.x) targets the Captcha module; the earlier 1.0.x branch targeted Webform.

---

- Add a bot-resistant CAPTCHA to the user registration form on a French government site.
- Protect the site-wide contact form from automated spam submissions.
- Add CAPTCHA to per-node comment forms without writing code, via Captcha points.
- Meet DSFR / French public-sector expectations by using the official CaptchEtat service instead of third-party CAPTCHAs.
- Offer an accessible CAPTCHA with a built-in audio ("speak the code") button for visually impaired users.
- Localise the challenge automatically to French or English based on the current interface language.
- Choose the challenge difficulty/style: 6–9 alphanumeric, 6–7 numeric, 6–7 alphabetic, 12-character variants, or lighter 4–6 / 6–9 alphanumeric styles.
- Test integration safely against the CaptchEtat sandbox before switching to production credentials.
- Replace reCAPTCHA/hCaptcha with a France-hosted, government-provided CAPTCHA for data-sovereignty reasons.
- Gate password-reset or login forms behind a human-verification challenge.
- Add CAPTCHA to newsletter-signup or subscription forms to reduce fake sign-ups.
- Let editors reload a fresh challenge in-place if the current image is unreadable.
- Centralise CAPTCHA behaviour through the Captcha module's default-challenge and per-form settings.
- Run a health check of the CaptchEtat service from Drupal's status report (Reports → Status report).
- Keep the OAuth access token cached and auto-refreshed so form rendering stays fast.
- Provide a keyboard-focus-friendly CAPTCHA widget (the "keep focus on captcha buttons" option).
- Add human verification to event-registration or booking forms.
- Protect webform-driven feedback forms (combined with the Captcha module).
- Standardise CAPTCHA across many forms by setting CaptchEtat as the Captcha module's default challenge.
- Render the module README as on-site help when the Markdown or Markdown Easy module is present.
