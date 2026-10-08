<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
When someone tries to register with an email that already has an account, this module replaces Drupal's "email already in use" error with a friendly message that guides them to log in or reset their password.

---

Created Account Register Message alters the core user registration form. When the submitted email matches an existing active account, it clears the normal duplicate-email error and, instead of creating a second account, shows a status message. If the matched account has never logged in (typical of an account an administrator created but the person never activated), it also sends the account's `register_admin_created` notification e-mail so the person gets a fresh password-reset link; if the account has logged in before, the message instead includes inline links to the login and password-reset pages. The whole behavior lives in a single `.module` file — there is no settings form, no permission, and no configuration to manage; enabling the module is all that is required. It supports Drupal 10.1+ and 11 and has no dependencies beyond core's user module.

---

- Replace Drupal's "This email is already in use" registration error with a helpful message.
- Welcome people whose account an administrator created but who never used the activation link.
- Automatically e-mail a password-reset link to a never-logged-in account that tries to re-register.
- Point a returning user to the login and password-reset pages from the registration form.
- Reduce confusion and support tickets from users who forgot they already have an account.
- Prevent accidental creation of a second account for the same email address.
- Smooth onboarding for sites where admins pre-create accounts for staff or members.
- Improve the registration experience without writing any custom form-alter code.
- Handle both self-registered-but-inactive and previously-active accounts with tailored messages.
- Deploy with zero configuration — just install and enable the module.
- Keep the registration flow friendly on membership or community sites.
- Guide users to activate an account they didn't realize was waiting for them.
- Turn a dead-end registration error into a self-service recovery path.
- Use on Drupal 10.1+ or 11 sites with the core user registration form enabled.
- Cut down on duplicate-account cleanup for site administrators.
- Provide a better first impression for people re-attempting registration.
- Avoid custom development for a common "you already have an account" UX need.
- Complement admin-created account workflows (e.g. bulk-imported or invited users).
- Give conscientious users who try to register a clear next step rather than an error.
- Show inline "log in here" and "reset your password here" links for existing active users.
