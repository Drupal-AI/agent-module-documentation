<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Google reCaptcha adds Google reCAPTCHA (v2 checkbox or v3 invisible) to chosen Drupal forms by listing their form IDs, keeping login, registration, contact and other forms safe from spam bots without per-form code.

---

The module attaches reCAPTCHA to any form whose ID you list in its configuration (`simple_recaptcha.config`, key `form_ids`, a comma-separated list that supports `*` wildcards). A single settings form at `/admin/config/services/simple_recaptcha` stores the reCAPTCHA type (`v2` checkbox or `v3` invisible), the v2 site/secret keys, the v3 site/secret keys, the desired v3 score threshold (`v3_score`, default 80), a "use globally" switch, and a "hide badge" option for v3. At form build, `hook_form_alter()` checks the current form ID against the list (via `SimpleReCaptchaFormManager::formIdInList()`, wildcard-aware) and, unless the user has the `bypass simple_recaptcha` permission, calls the `simple_recaptcha.form_manager` service to inject either a v2 checkbox (`addReCaptchaCheckbox()`) or the v3 invisible token (`addReCaptchaInvisible()`); the same service validates the token server-side against Google on submit (`validateCaptchaToken()`). Two permissions gate it: `administer simple_recaptcha` (settings) and `bypass simple_recaptcha` (skip protection). A `hook_simple_recaptcha_bypass_alter()` hook lets code decide per-form whether to skip validation. The bundled **simple_recaptcha_webform** submodule adds a Webform handler so reCAPTCHA can be enabled per webform. You still need Google reCAPTCHA keys from Google's admin console for it to actually verify.

---

- Protect the user login form (`user_login_form`) from brute-force/bot attempts.
- Add reCAPTCHA to the user registration form to stop spam sign-ups.
- Secure the password-reset form (`user_pass`, protected by default).
- Add a v2 "I'm not a robot" checkbox to a contact form by listing its form ID.
- Switch to invisible reCAPTCHA v3 that scores requests without user interaction.
- Set a v3 score threshold so only sufficiently human requests pass.
- Protect many forms at once with a wildcard form ID like `contact_message_*`.
- Enable reCAPTCHA globally on every form with the "use globally" toggle.
- Hide the reCAPTCHA v3 badge (while keeping the required legal attribution elsewhere).
- Store separate v2 and v3 site/secret key pairs and switch between them.
- Let trusted roles skip reCAPTCHA via the `bypass simple_recaptcha` permission.
- Programmatically bypass protection for certain forms with `hook_simple_recaptcha_bypass_alter()`.
- Add reCAPTCHA to a specific webform using the simple_recaptcha_webform handler.
- Keep a comment form spam-free by adding its form ID.
- Protect a custom module's form without writing captcha code.
- Verify submissions server-side against Google's siteverify endpoint automatically.
- Centralize captcha configuration in one config object for deployment.
- Roll out reCAPTCHA across a multisite by exporting `simple_recaptcha.config`.
- Reduce spam on newsletter-signup forms.
- Guard a "report abuse" or "flag" form from automated abuse.
- Apply different reCAPTCHA versions to site-wide forms vs individual webforms.
- Attach reCAPTCHA to node forms (e.g. anonymous submissions) by form ID.
- Protect search or feedback forms exposed to anonymous users.
- Migrate from another captcha solution by simply listing the same form IDs.
