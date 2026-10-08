Web Security is a security meta-package that installs and pre-configures a curated bundle of Drupal security modules through a default recipe.

---

Web Security (part of the Webship `web*` suite) is a convenience meta-module for Drupal 11.4+/12. Requiring it with Composer pulls in a curated set of security and anti-spam contrib modules (reCAPTCHA v3, Flood control, Seckit, Security Review, Honeypot, Antibot, Klaro, CAPTCHA, Friendly Captcha, ECA, BPMN.iO, Login with email or username, Token). On install it applies its bundled `recipes/default` recipe, which enables those modules, imports their config, and applies opinionated hardening defaults: it turns on CAPTCHA (Friendly Captcha) on the user registration form, configures Honeypot and Flood control thresholds, sets Seckit clickjacking/XSS options, points the 403 page at `/user/login`, grants trusted authenticated users bypass permissions, and installs two ECA workflow models. It ships a single PHP class that generates and stores random local Friendly Captcha keys after the recipe runs. It has no admin UI, routes, permissions, or services of its own beyond that subscriber, and it complements — never replaces — ongoing security maintenance (core/module updates, permission review, monitoring).

---

- Bootstrap a new site with a curated security-module bundle in one Composer require.
- Apply an opinionated security-hardening baseline via the bundled default recipe.
- Enable and pre-configure Honeypot spam protection on user register/login/password forms.
- Enable Antibot JavaScript-based bot protection on forms.
- Enable CAPTCHA with Friendly Captcha as the default challenge on the user registration form.
- Enable reCAPTCHA v3 for score-based bot detection (keys supplied by the site owner).
- Set Seckit clickjacking protection (X-Frame-Options SAMEORIGIN) and X-XSS-Protection.
- Configure Flood control login thresholds (IP: 10/1800s, user: 8/1800s).
- Install Security Review with a preset list of 14 checks for periodic hardening audits.
- Mark the anonymous role as untrusted for Security Review's untrusted-role checks.
- Redirect the 403 "access denied" page to the login form.
- Redirect users back to the login form after logout (ECA `auth_redirects` model).
- Streamline the user registration form field order and hide password/status when notifying by email (ECA `user_register` model).
- Auto-generate a random password for admin-created accounts that email their credentials.
- Enable Klaro cookie-consent management for GDPR-style consent banners.
- Allow login by either email address or username via Login with email or username.
- Generate per-site random Friendly Captcha site/API keys for the local (self-hosted) endpoint.
- Grant the authenticated role bypass permissions (honeypot, antibot, CAPTCHA) for logged-in users.
- Provide the ECA / BPMN.iO stack so site builders can extend the shipped security workflows.
- Serve as a shared security starting point across sites in the Webship suite.
- Layer additional Drupal hardening onto a recipe-driven install workflow.
- Give agents/site builders a single dependency that encodes a vetted security default set.
