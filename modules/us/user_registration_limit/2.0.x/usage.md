<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Registration Limit lets an administrator set a maximum number of user accounts. Once the site reaches that number, the standard user registration form denies access to new sign-ups.

---

The limit is a soft, form-level guard. It is enforced only via `hook_form_user_register_form_alter()`, which throws `AccessDeniedHttpException` when `canUserRegister()` returns FALSE. The count is a live `entityQuery` over all users (including blocked). Users with the `administer users` permission are always exempt. Because enforcement lives on the interactive registration form, alternative registration paths (JSON:API/REST user creation, Drush, programmatic `User::create()`, other custom forms) are not covered by this module — treat it as a UX/anti-flood convenience, not a hard security control.

---

- Cap total registrations at a fixed number (e.g. 50) for a small/private site.
- Stop open registration once a launch quota is filled.
- Show a warning on the account-settings page when the limit is reached.
- Display a custom message to visitors on the blocked registration page.
- Limit sign-ups for an event or beta programme.
- Prevent casual registration flooding through the standard form.
- Keep a members-only site at a bounded membership size.
- Let admins raise or lower the cap over time.
- Exempt staff (`administer users`) from the cap so they can still create accounts.
- Combine with CAPTCHA/anti-spam modules for stronger flood protection.
- Pair with a moderation workflow that blocks then activates users.
- Configure the warning text under the module's settings route.
- Set the numeric cap on the standard Account Settings form.
- Validate that the cap is never set below the current user count.
- Audit the current user count before lowering the cap.
- Review whether REST/JSON:API user creation is exposed, since it bypasses the cap.
- Use during a controlled rollout where seats are limited.
