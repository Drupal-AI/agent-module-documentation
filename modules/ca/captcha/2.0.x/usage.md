CAPTCHA adds a configurable challenge (a math question by default) to virtually any Drupal form to block automated spam submissions, while letting trusted users skip it.

---

The CAPTCHA module provides a base API and administrative UI for protecting forms against bots. Instead of hard-coding a challenge, it lets challenge types be supplied by any module through `hook_captcha()` — the base module ships a simple "Math" challenge, and the bundled Image CAPTCHA submodule adds a distorted-text image challenge. You attach challenges to forms by creating **CAPTCHA points**, which are config entities that map a form ID (e.g. `user_login_form`, `contact_message_feedback_form`) to a challenge type, or you can enable CAPTCHA globally on all forms. Behaviour is tuned from a central settings form: default challenge, persistence (how often a user must re-solve), validation case sensitivity, an IP whitelist, a custom error message, and optional logging/statistics. Users with the "Skip CAPTCHA" permission are never challenged, and an administration mode adds inline links on forms so admins can place challenges quickly. Old challenge sessions are cleaned by cron, and Drupal 7 CAPTCHA points and settings can be migrated in. Developers integrate custom challenges via a small hook API and can control exactly where the CAPTCHA element is injected in a form.

---

- Add a math challenge to the user login form to stop credential-stuffing bots.
- Protect the user registration form from automated fake-account creation.
- Add CAPTCHA to the password reset (`user_pass`) form.
- Protect site-wide and personal contact forms from spam messages.
- Add a challenge to comment submission forms.
- Add a challenge to a webform or custom form by its form ID.
- Enable CAPTCHA globally on every form on the site in one setting.
- Additionally protect admin-route forms when global protection is on.
- Exempt trusted roles from challenges via the "Skip CAPTCHA" permission.
- Whitelist specific IP addresses or CIDR ranges to bypass challenges.
- Swap the default challenge from Math to the image-based challenge.
- Show a distorted-text image challenge using the Image CAPTCHA submodule.
- Set persistence so a user only solves a CAPTCHA once per session.
- Customise the CAPTCHA title, description, and wrong-answer error message.
- Use case-insensitive validation so answer capitalisation doesn't matter.
- Log incorrect CAPTCHA responses to spot bot attack patterns.
- Collect statistics on how many challenges are generated and blocked.
- Use administration mode to add/change challenges directly from each form.
- Implement a custom challenge type (e.g. a question/answer) via `hook_captcha()`.
- Alter another module's challenge markup or description via `hook_captcha_alter()`.
- Precisely position the CAPTCHA element in a complex form via `hook_captcha_placement_map()`.
- Provide a custom validation callback for a bespoke challenge.
- Export CAPTCHA point configuration and deploy it across environments.
- Migrate CAPTCHA points and settings from a Drupal 7 site.
- Automatically purge stale CAPTCHA session records via cron.
- Reduce comment and contact-form spam without a third-party service or API key.
