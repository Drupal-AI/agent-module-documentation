<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
First Time Login prompts users to update their password on first login.

---

First Time Login **prompts a user to update their password the first time they log in** — after an
admin-created account or an import, forcing/nudging the user to set their own password before continuing, for
better password hygiene. It is in the User interface package.

Use it to make new users set a fresh password. It is a security-adjacent onboarding feature: it acts via
`hook_user_login()` (after the user has already authenticated), so it doesn't change authentication itself — it
guides the already-logged-in user to a password-change step. For it to be effective, ensure the flow actually
requires the change before granting full use (an admin-set initial password should be treated as temporary). It
has no access-control role. Configure the first-login prompt behaviour.

---

- Prompt a password change on first login.
- Nudge new/imported users to set a password.
- Improve password hygiene.
- Act via hook_user_login() (post-auth).
- Serve onboarding.
- Treat admin-set passwords as temporary.
- Not change authentication itself.
- Guide the logged-in user to change the password.
- Ensure the change is required before full use.
- Have no access-control role.
- Configure the prompt behaviour.
- Handle first-login prompts.
- Prompt password change.
- Configure the flow.
- Force password reset.
- Handle onboarding.
- Guide users.
- Set passwords.
- Require the change.
- Provide first-login password prompts.
