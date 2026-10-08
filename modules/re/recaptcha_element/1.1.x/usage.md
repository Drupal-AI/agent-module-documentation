ReCaptcha Element provides a reusable Google reCAPTCHA **v3** form element (`recaptcha_element`) and a Webform handler, so you can add invisible, score-based bot protection to any Drupal form — in code or on a webform — without a visible challenge.

---

The module registers a `recaptcha_element` render/form element (extending core `Hidden`) plus a Webform handler plugin. reCAPTCHA v3 is score-based and invisible: the bundled `js/recaptcha_element.js` intercepts form submits (both regular and AJAX/`ajaxSubmit`), calls `grecaptcha.execute()` with the configured action and site key, and injects the token into the hidden element before letting the submit proceed. On the server, the element's `#element_validate` runs the `google/recaptcha` PHP library with the secret key, expected action, and score threshold (optionally verifying hostname), and sets a form error (message run through `Xss::filterAdmin`) if the response fails. A settings form at `/admin/config/services/recaptcha_element` (route `recaptcha_element.settings`, permission **administer recaptcha_element**) holds the site key, secret key, a global `enabled` switch (so you can turn reCAPTCHA off entirely on dev/test), per-element defaults (action, threshold 0.0–1.0, verify_hostname, error message), and a "log successful responses" toggle. All verifications are logged via a `RecaptchaLogger` service to the `recaptcha_element` log channel (failures at error/notice level depending on error code, successes at info only when enabled). The reCAPTCHA v3 API script is loaded from Google with the configured site key appended via `hook_library_info_alter()`. Requires the `google/recaptcha` Composer library; the Webform handler is only useful with the Webform module.

---

- Add invisible reCAPTCHA v3 protection to a custom form via a single `#type` element.
- Protect a Webform from spam by attaching the reCAPTCHA Element handler.
- Score-gate submissions, rejecting anything below a configurable threshold (e.g. 0.5).
- Set a per-form reCAPTCHA action name for finer Google analytics/adaptive risk.
- Disable reCAPTCHA entirely on dev/staging with the global `enabled` toggle.
- Provide a custom, sanitized error message shown when verification fails.
- Verify the request hostname server-side when domain verification is off in the key settings.
- Protect a contact form, registration form, or comment form from bots.
- Add bot protection to AJAX-submitted forms (the JS wraps `jQuery.ajaxSubmit`).
- Log all failed reCAPTCHA verifications to a dedicated log channel for monitoring.
- Optionally log successful verifications to tune the score threshold, then turn logging off.
- Use different reCAPTCHA settings per webform handler while sharing global defaults.
- Override just the element name of the hidden token input on a webform.
- Centralize site key/secret key management in one settings form.
- Add reCAPTCHA to a multistep or programmatically-built form in a custom module.
- Fall back gracefully: if `grecaptcha` fails to load within ~2s the submit proceeds.
- Distinguish hard errors (bad secret, connection failure) from soft failures in logs.
- Guard a newsletter signup or lead-capture form against automated abuse.
- Apply a strict threshold on high-value forms and a lax one on low-risk forms.
- Keep the challenge invisible to legitimate users (no checkbox/puzzle) for better UX.
