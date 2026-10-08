Simple Password Reset streamlines Drupal's password-reset flow: when a user clicks the one-time login link from the reset email, they land straight on a "choose a new password" form and are logged in on submit, instead of the extra intermediate one-time-login page.

---

Out of the box Drupal's `user.reset` route shows a one-time-login landing page with a "Log in" button that only then takes the user to their account edit form to set a password — two steps that confuse many users. This module rewrites that flow. A `RouteSubscriber` overrides the `user.reset` route so its controller becomes `Drupal\simple_pass_reset\Controller\User::resetPass` (title "Choose a new password") and its access is checked by a dedicated `_simple_pass_reset_access` access checker (`ResetPassAccessCheck`, mirroring core's timeout/hash validation). A `hook_form_user_form_alter()` then strips the profile edit form down to just the password field on the reset flow, makes the password required, relabels the submit button to "Save and log in", and on submit finalizes the login (`user_login_finalize`) and redirects. Where the user is sent afterwards is the module's one setting: `simple_pass_reset.settings:login_redirection` (default `/user`), editable at `/admin/config/people/accounts/simple_pass_reset` under the `administer simple pass reset` permission (the form accepts any internal path starting with `/`, or `<front>` which is stored as `/`). It also cooperates with the Guardian module (guarded accounts keep the standard reset form) and re-runs its alter last so it wins over other modules.

---

- Let users set a new password immediately after clicking the reset link, with no extra "Log in" step.
- Log the user in automatically when they submit their new password ("Save and log in").
- Reduce support tickets caused by the confusing default one-time-login page.
- Send users to a chosen page after resetting their password (e.g. a dashboard).
- Redirect post-reset to the front page by entering `<front>` in the settings form.
- Keep the reset page focused by hiding profile fields (picture, timezone, etc.) during reset.
- Make the new-password field required so users can't skip setting it.
- Restrict who can change the redirect setting via the `administer simple pass reset` permission.
- Preserve core's security checks (link expiry, hash, active-user, already-logged-in handling).
- Improve first-login UX for newly created accounts that use the reset link to set a password.
- Provide a cleaner onboarding flow for e-commerce or membership sites.
- Configure the post-login destination as code via `simple_pass_reset.settings`.
- Override the redirect per environment (e.g. staging vs production) through config.
- Play nicely with the Guardian module by leaving guarded accounts on the standard flow.
- Ensure the module's form changes take precedence by running its form alter last.
- Relabel the reset submit button to a clearer "Save and log in".
- Streamline password recovery for large editorial teams.
- Avoid custom code to shorten the password-reset journey.
- Standardize where all users end up after a password reset.
- Keep the account edit form's password behavior intact for normal profile edits (only the reset flow is altered).
