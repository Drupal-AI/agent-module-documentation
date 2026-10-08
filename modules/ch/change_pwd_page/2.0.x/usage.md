<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Separate Form (change_pwd_page) moves password changing out of the crowded user account edit form onto a dedicated page at `/user/change-password`, and reworks the one-time-login/reset flow to land the user on that page.

---

The module removes the password fields from the standard user edit form (`user_form`) via `hook_form_alter()` — hiding the new-password (`pass`) widget and re-labelling the `current_pass` description — so editing profile fields no longer prompts for a password. It exposes a standalone form instead: `/user/change-password` (route `change_pwd_page.change_password`) redirects the logged-in user to `/user/{user}/change-password` (route `change_pwd_page.change_password_form`, gated by `user.update` entity access), which renders `ChangePasswordForm` (form id `change_pwd_form`) requiring the current password unless the user arrived via a one-time login token. A local task tab "Change Password" is added to user profile pages, plus an account-menu link. A `RouteSubscriber` shortens core's `user.reset` path, and a custom reset controller/`ChangePasswordResetForm` implement the one-time-login → set-password flow, storing a session token so the subsequent password change can skip the current-password check. It integrates with Password Policy: on install/module-install it sets `password_policy.settings:change_password_route` to `change_pwd_page.change_password_form` and injects the policy status table + validators into the separate form. It defines no permissions, no config of its own, no Drush, and no plugins.

---

- Give users a clean, dedicated `/user/change-password` page instead of the full account edit form.
- Stop prompting for the current password when a user only edits their profile fields (email, etc.).
- Add a "Change Password" tab to each user's profile page.
- Add a "Change password" link to the user account menu.
- Let administrators change another user's password at `/user/{uid}/change-password` (subject to `user.update`).
- Require the current password before a self-service password change, for security.
- Skip the current-password requirement right after a one-time login link, so users can set a new password.
- Rework the password-reset email flow to send users to the separate change-password page.
- Integrate with Password Policy so its enforced policies apply on the separate form.
- Point Password Policy's `change_password_route` at `change_pwd_page.change_password_form` automatically.
- Show the live password-policy constraints table on the separate change-password form.
- Reduce editor confusion on sites with many custom user fields by isolating the password action.
- Provide a focused password UX for member/community sites.
- Keep password changes off the profile form for accessibility/simplicity.
- Support a "set your password" first-login experience via the one-time login form.
- Redirect `/user/change-password` to the current user's own form without them needing their uid.
- Avoid loading all account fields when a user only wants to change their password.
- Offer a consistent password-change entry point to link from emails or help text.
- Let a site enforce password policies specifically at the moment of password change.
- Replace core's combined account+password form UX without custom code.
