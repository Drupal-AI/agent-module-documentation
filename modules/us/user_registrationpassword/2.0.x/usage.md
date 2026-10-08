<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Registration Password lets visitors choose their own password on the registration form even when the site requires email verification, then sends a single activation email that both confirms the address and logs the user in with their chosen password.

---

The module has no dedicated settings page; it alters core's Account settings form (route `entity.user.admin_form`, `/admin/config/people/accounts`) to add a three-way "email verification" choice plus activation-link and email-template options, all stored in `user_registrationpassword.settings`. The `registration` key takes one of three constants (`\Drupal\user_registrationpassword\UserRegistrationPassword`): `none` (NO_VERIFICATION — no verification email, password set on the form), `default` (VERIFICATION_DEFAULT — verification email first, password set later), or `with-pass` (VERIFICATION_PASS — verification email required but the password is set on the registration form; the shipped default). When `with-pass` is active together with core's "Visitors can create accounts" mode, the module disables core's `verify_mail` and register notifications and takes over: it blocks the new account, sends its own `register_confirmation_with_pass` mail (config object `user_registrationpassword.mail`), and exposes a `[user:registrationpassword-url]` token that builds a one-time confirmation URL (route `user_registrationpassword.confirm` at `user/registrationpassword/{uid}/{timestamp}/{hash}`). Additional settings control activation-link expiry (`registration_ftll_expire` / `registration_ftll_timeout`, default 86400s) and a post-confirmation `registration_redirect` path. It also patches the password-reset form to resend the activation mail for never-logged-in accounts, and ships a REST resource at `/user/registerpass` for headless registration.

---

- Let new users pick their own password during sign-up while still verifying their email.
- Send one activation email that both confirms the address and logs the user in.
- Avoid the core flow where users must wait for a reset link before setting any password.
- Switch registration to "no verification, set password on form" (`none`) for low-friction sign-up.
- Keep the classic "verify first, set password later" flow (`default`) when preferred.
- Expire account activation links after a configurable timeout (e.g. 24 hours).
- Allow users to request a fresh activation email via the password-reset form after expiry.
- Redirect users to a specific path after they confirm their account (supports user tokens).
- Customise the welcome/activation email subject and body from the Account settings form.
- Use the `[user:registrationpassword-url]` token to place the one-time confirmation link in emails.
- Integrate the Registration Password Tokens (`rpt`) module to include `[user:password]` in mail.
- Register users headlessly through the `/user/registerpass` REST resource.
- Reduce support requests from users confused by separate verify-then-set-password steps.
- Provide password-on-registration for membership or community sites requiring email checks.
- Block accounts until email confirmation while still capturing the chosen password.
- Localize the activation email per user language via config translation of the mail object.
- Suppress core's duplicate "pending approval" status message during this flow.
- Resend activation emails for users who never logged in, from the standard reset form.
- Configure the whole flow through exported config for repeatable deployments.
- Combine email verification security with the convenience of immediate password selection.
- Tune the flow to work with "Visitors, but administrator approval required" registration mode.
