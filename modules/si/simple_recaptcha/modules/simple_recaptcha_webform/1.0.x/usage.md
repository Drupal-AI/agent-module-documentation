<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Google reCaptcha - Webform integration adds a Webform handler (`simple_recaptcha`) so you can enable Google reCAPTCHA on an individual webform, choosing v2 or v3 per form, using the site keys configured in the parent module.

---

This submodule bridges [Simple Google reCaptcha](https://www.drupal.org/project/simple_recaptcha) and the [Webform](https://www.drupal.org/project/webform) module. It provides a single `@WebformHandler` plugin with id `simple_recaptcha` (label "reCAPTCHA", category "simple_recaptcha", `CARDINALITY_SINGLE`, `RESULTS_IGNORED`) that you add to any webform from *Settings → Emails / Handlers → Add handler*. On the handler you pick the reCAPTCHA type (`recaptcha_type`: v2 or v3), and for v3 a score threshold (`v3_score`, default 90), a custom error message (`v3_error_message`), and whether to hide the v3 badge (`hide_badge_v3`). The actual site/secret keys still come from the parent module's global `simple_recaptcha.config`; this handler just decides per-webform which version to apply and how to score/message it. It depends on `simple_recaptcha` and `webform`, adds no permissions or Drush commands of its own, and its configuration is stored inside the host webform's `handlers` config (schema `webform.handler.simple_recaptcha`).

---

- Add reCAPTCHA to a single contact webform without protecting other forms globally.
- Choose reCAPTCHA v2 (checkbox) for one webform and v3 (invisible) for another.
- Set a per-webform v3 score threshold stricter or looser than the site default.
- Show a custom, friendly error message when a v3 submission is rejected.
- Hide the reCAPTCHA v3 badge on a specific webform.
- Protect a high-value webform (job application, quote request) from spam bots.
- Enable captcha only on public-facing webforms while leaving internal ones untouched.
- Combine reCAPTCHA with other webform handlers (email, remote post) on the same form.
- Reuse the site-wide reCAPTCHA keys for individual webforms via the parent config.
- Turn captcha on/off per webform by adding or removing the handler.
- Apply invisible v3 protection to a newsletter-signup webform.
- Guard a feedback webform exposed to anonymous users.
- Add captcha to a webform that isn't easily targeted by global form-ID matching.
- Provide different captcha behavior per webform in a multi-form site.
- Test v2 vs v3 on separate webforms before rolling out site-wide.
- Keep captcha config with the webform export (handler stored in webform config).
- Protect an event-registration webform from automated sign-ups.
- Layer reCAPTCHA onto a survey webform to reduce junk responses.
