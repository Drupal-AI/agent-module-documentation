<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Seeds Security & Performance is a dependency-only starter module that pulls in and enables a curated set of contrib security modules (and ships some starter configuration) so a Drupal site gets a baseline of protections in one install.

---

Seeds Security & Performance (`seeds_security`, package "Seeds") is an aggregator/metapackage: it has no controllers, forms, services, permissions, entities, or Drush commands of its own. Its `.info.yml` declares hard dependencies on a set of well-known security contrib modules — `username_enumeration_prevention`, `captcha`, `recaptcha`, `activities`, `password_policy`, `remove_http_headers`, `seckit`, `session_limit`, `restrict_ip` and `email_tfa` — and its `composer.json` additionally requires `login_security` and `webform_spam_words`. Enabling the module therefore enables that whole stack. The only executable code it contributes is one hook, `seeds_security_page_attachments_alter()` in `seeds_security.module`, which strips the core `system_meta_generator` `<meta name="generator">` tag from the page `<head>`. It also ships several `config/optional/*.yml` files (starter settings for SecKit, Login Security, Session Limit, Remove HTTP Headers, and a "Default Password Policy" entity for Password Policy); because these live in `config/optional`, each one is only created if config of that name does not already exist. Note that most of the bundled security modules also ship their own `config/install` defaults under the same config names, which take precedence — so the SecKit/Login Security/Session Limit/Remove HTTP Headers settings actually in effect after install are generally each module's own defaults, not the Seeds copies; the new `password_policy.default_password_policy` entity (which no dependency provides) is the one that is created. Treat this module as a convenience bundle: it selects and installs the modules, but you should review and tune each control's configuration to match your site rather than assume the bundle has fully configured it.

---

- Enable a curated security-module stack in one `drush en seeds_security` step.
- Bootstrap a new Drupal 11 site with a baseline security posture.
- Install SecKit (security headers / CSP / clickjacking) via one dependency.
- Add username-enumeration prevention without picking modules individually.
- Pull in CAPTCHA and reCAPTCHA for form spam/bot protection.
- Add Password Policy plus a starter "Default Password Policy" entity.
- Enable Session Limit to cap concurrent sessions per user.
- Add Restrict IP for IP-based access restriction.
- Add Email TFA for email-based two-factor authentication.
- Remove fingerprinting HTTP headers via Remove HTTP Headers.
- Strip the Drupal generator `<meta>` tag from page output automatically.
- Standardise the security-module set across many Seeds-distribution sites.
- Provide activity logging via the `activities` dependency.
- Give a new team a documented, opinionated security starting point.
- Reduce version-disclosure surface (generator meta + header removal).
- Use as the security layer of a Seeds-based site build.
- Adopt a consistent security baseline across a multisite fleet.
- Review the bundled SecKit configuration and enable CSP/HSTS as needed.
- Tune Login Security thresholds after install to match your policy.
- Assign the Default Password Policy to the roles you want it enforced on.
- Add optional `login_security` / `webform_spam_words` (Composer-required) when needed.
- Serve as a checklist of recommended security modules to enable.
- Onboard a site to Seeds security conventions quickly.
- Keep the security-module list in one place for upgrades.
- Verify each control on your own site before relying on it in production.
