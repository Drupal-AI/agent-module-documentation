reCAPTCHA adds a Google reCAPTCHA (v2) challenge as a CAPTCHA type for the Drupal CAPTCHA module, protecting forms from spam and bots while letting real users pass with a checkbox or invisibly.

---

This module integrates Google's reCAPTCHA service into Drupal via the core CAPTCHA framework: it implements `hook_captcha()` to register a `reCAPTCHA` challenge that you can then attach to any form on the CAPTCHA administration page. Site keys and secret keys from the Google reCAPTCHA admin console are entered on its own settings form at **Admin → Configuration → People → CAPTCHA → reCAPTCHA**, along with widget options — theme (light/dark), type (image/audio), size (normal/compact/invisible) and an optional `<noscript>` fallback for browsers without JavaScript. On the server the token returned by the widget is verified against Google's API using the bundled `google/recaptcha` PHP library through a Drupal-aware HTTP request method (`Drupal8Post`, using core's `http_client`). Options include verifying the response hostname locally and using the global `recaptcha.net` endpoint (useful where `google.com` is blocked). Because validation does not depend on a session solution, reCAPTCHA challenges are marked cacheable and work on cached pages. Configuration is exportable, and a config event subscriber invalidates the relevant cache tags when settings change. It requires the CAPTCHA module and is a drop-in way to cut form spam site-wide.

---

- Add a reCAPTCHA checkbox to the user registration form.
- Protect the user login form from brute-force/bot attempts.
- Stop spam on the site-wide contact form.
- Add a challenge to comment submission forms.
- Use invisible reCAPTCHA (size = invisible) to avoid a visible checkbox.
- Switch the widget to a dark theme to match the site.
- Use the compact widget size on narrow layouts.
- Provide a `<noscript>` fallback for users without JavaScript.
- Enter site/secret keys from the Google reCAPTCHA console.
- Verify the response hostname locally for stricter validation.
- Route verification through `recaptcha.net` where `google.com` is blocked.
- Protect a custom module's form by assigning the reCAPTCHA challenge in CAPTCHA settings.
- Protect webform submissions from automated spam.
- Serve reCAPTCHA on cached (anonymous) pages without breaking caching.
- Gate password-reset request forms against abuse.
- Reduce spam account signups on membership sites.
- Localize the widget to the current interface language.
- Apply reCAPTCHA globally by default to newly added forms.
- Restrict who can change reCAPTCHA settings via the `administer recaptcha` permission.
- Export reCAPTCHA configuration and deploy it across environments.
- Combine with the CAPTCHA module's per-form-id placement rules.
- Swap between image and audio challenge types.
- Migrate legacy reCAPTCHA settings during a site upgrade (migrate support).
- Protect newsletter/subscription signup forms.
