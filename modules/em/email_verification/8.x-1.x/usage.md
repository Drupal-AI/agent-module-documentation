<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Verification

Gates the standard `user_register_form` behind an email-ownership check: a visitor first enters an email, receives a link, and only then may complete registration with that address pre-filled and read-only.

- Intercepts the register form for anonymous users only.
- Sends a verification link built from a hash of the email address.
- Pre-fills and locks the mail field once the link is followed.
- Aims to stop registration with an address the visitor does not control.

---

# Installing & configuring

- Enable the module and grant `administer users` to reach settings.
- Configure at `/admin/config/people/userverify` (`UserVerificationAdminForm`).
- Set `user_email_verification_salt` (a random alphanumeric string) and the email template.
- The verification-request form lives at `/user/emailverify` (anonymous only).
- The email template supports `[user:emailtoverify]` and `[user:emailverificationlink]` tokens.
- On install only the message template config is written by default.

---

# Usage & behaviour

- An anonymous visitor requests verification at `/user/emailverify`.
- `hook_mail()` sends a link: `/user/register?email=<email>&verify=<hash>`.
- The verify hash is `md5($salt . $email)`.
- `hook_form_alter()` on the register form redirects to `/user/emailverify` when no valid `verify` param is present.
- When `md5($salt.$email) == $verify` the mail field is pre-filled and set read-only.
- The real mail field is hidden; a mirrored read-only field is shown.
- Logged-in users are unaffected (guard returns early).
- The register form is marked `max-age: 0` (uncacheable) while active.
- No verification log/entity is stored; state is entirely in the URL hash.
- Tokens do not expire and are reusable.
- Intended to be paired with a mail-delivery setup that actually sends the link.
- Provides no new permissions of its own (reuses core `administer users`).
- Removing the module restores the stock registration flow.
- Test coverage exists under `tests/`.
