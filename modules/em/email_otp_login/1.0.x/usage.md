<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email OTP Login lets registered Drupal users sign in with a one-time code emailed to their account address instead of a password.

---

Email OTP Login provides a passwordless login flow for existing user accounts. A visitor enters their email address on the `/otp-email` form; if a non-blocked account has that address, the module generates a 6-digit one-time code, emails it through Drupal's mail system, and redirects to `/validate-otp/{email}`. Entering the matching code there finalizes a login session for that account and redirects to the user's profile page. The module depends only on core `user`, ships no configuration UI, no permissions of its own, and no submodules; the OTP email subject and body come from `hook_mail()` and can be customized with a mail-alteration module or theme. It is intended as an alternative sign-in method for sites that want an email-code login option layered alongside the standard username/password login.

---

- Offer registered users a passwordless, email-code login as an alternative to password sign-in.
- Let users who have forgotten their password sign in with a code sent to their known email address.
- Provide a simpler mobile login path where typing a short numeric code is easier than a password.
- Add an email-code login option for accounts created by an administrator without sharing a password.
- Give occasional/low-frequency users a way in without a password manager entry.
- Support a help-desk workflow where staff direct a user to `/otp-email` to regain access.
- Expose the `/otp-email` request form through a custom menu link in a site's navigation.
- Link to `/otp-email` from a login block or a "sign in with email" call to action.
- Serve the email-request form and the code-validation form as standard Drupal forms that can be themed.
- Customize the OTP email's subject and body by altering the `otp_email` mail key via a mail-alteration module.
- Route OTP emails through an SMTP/transactional mail provider by combining with a mail-delivery module.
- Send the OTP in the site's default language via the language manager.
- Redirect users to their profile page automatically after a successful code entry.
- Block code delivery for accounts that are administratively blocked, with a clear message to contact the admin.
- Provide a login method for kiosk or shared-device scenarios where a password is undesirable.
- Integrate the request form into a multi-step onboarding or account-recovery page.
- Offer an email-based sign-in for editors on intranet sites where all accounts are pre-provisioned.
- Use as a lightweight demonstration of a Drupal OTP/passwordless login flow for training or prototyping.
- Provide an alternate authentication entry point for sites that keep the default `/user/login` for administrators only.
- Let membership or community sites invite users to log in via an emailed code.
- Add an email-code sign-in to a decoupled front end by pointing it at the module's form routes.
