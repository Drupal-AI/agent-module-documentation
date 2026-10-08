<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Enumeration Prevention normalizes the registration and password-reset form responses so an outsider cannot tell whether an email or username is already registered.

---

Email Enumeration Prevention (eep) closes account **enumeration** oracles on Drupal's **user registration** and **password-reset** forms. By default those flows return different messages depending on whether the submitted email/username already exists (for example "The email address is already taken" or "no account is registered with that address"), which lets an attacker probe for valid accounts. eep swaps in its own form handlers that suppress the "already exists" validation error on registration — silently mailing the existing account instead and showing the ordinary success message — and it presents a single configurable confirmation on password reset regardless of whether the account exists, so both flows look identical for known and unknown identities. It depends on core **User** and the **Token** module, is configured at `/admin/config/people/eep` (`eep.settings`), and provides its own `administer eep configuration` permission. Each protection (register form, password-reset form) can be toggled independently, and the confirmation message / registration notification email are fully customizable with tokens. It is a security-positive hardening module: enable it on both flows, and remember it hardens only those two forms — enumeration can still leak through other channels (login errors, JSON:API/REST user endpoints, or response timing), which are outside its scope.

---

- Prevent user/account enumeration on a public-registration Drupal site.
- Stop the registration form from revealing that an email address is already registered.
- Stop the registration form from revealing that a username is already taken.
- Present the same "welcome message sent" confirmation whether or not the registrant's email already exists.
- Silently notify the real account owner when someone tries to register with their existing email.
- Normalize the password-reset form so it shows one message for both known and unknown identities.
- Replace the default "Sorry, X is not recognized" password-reset error that leaks account existence.
- Harden signup and password-reset flows to reduce credential-stuffing target discovery.
- Customize the confirmation text shown after a password-reset request.
- Customize the subject and body of the email sent on a duplicate-email registration attempt.
- Use Token replacements (user/global tokens) inside the custom registration notification email.
- Toggle enumeration protection on the registration form independently of the reset form.
- Toggle enumeration protection on the password-reset form independently of registration.
- Meet a security-review or pen-test finding that Drupal's account forms permit enumeration.
- Support privacy/GDPR posture by not disclosing whether a person holds an account.
- Preserve core's IP-based and per-user flood limits on password-reset requests.
- Keep the standard admin-approval registration message consistent so enumeration is not reintroduced.
- Restrict who can change the anti-enumeration configuration via a dedicated permission.
- Layer alongside CAPTCHA, rate limiting, or 2FA modules as part of a login-hardening stack.
- Deploy on membership, community, or SaaS sites where account existence is sensitive.
- Roll out configuration via exported `eep.settings` config across environments.
