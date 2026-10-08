<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Change Mail Page gives users a dedicated, password-verified page for changing their email address, separate from the full account-edit form.

---

Change Mail Page adds a standalone "Change Email" form to Drupal user profiles instead of leaving the email field on the main account-edit form. It provides a "Change Email" local task (tab) on user pages, a form at `/user/{user}/change-mail` that asks for the new email plus the account's current password, and a convenience route `/user/change-mail` that redirects the logged-in user to their own form. For non-administrators the module removes the email field from the standard user edit form (via `hook_form_user_form_alter`), so all self-service email changes go through the dedicated page; administrators still edit email on the normal user form. Access to the change form uses core's `user.update` entity access, and the email/password rules are enforced by core's own user-entity validation. The module has no configuration, no dependencies beyond Drupal core, and supports Drupal 10 and 11.

---

- Give users a focused, single-purpose page to update their email address.
- Add a "Change Email" tab to every user profile page.
- Keep the email field off the cluttered full account-edit form for regular users.
- Let a logged-in user reach their own change form via the short `/user/change-mail` URL.
- Require the account's current password before an email change is saved.
- Reuse core `user.update` entity access so users edit only their own email.
- Let administrators change any user's email from the standard user edit form.
- Streamline account-management flows where email is the login identifier.
- Provide a clean redirect target after registration or profile prompts to confirm email.
- Link the change form from a custom dashboard or account menu.
- Reduce accidental edits to other account fields when a user only needs to update email.
- Build a self-service "update your contact address" step into an onboarding flow.
- Surface a dedicated email-change link in notification emails or help text.
- Support Drupal 10 and Drupal 11 sites with a dependency-free install.
- Pair with change_pwd_page (Password Separate Form) for a matching separate password page.
- Integrate optionally with check_dns to validate the MX/DNS of the new email domain.
- Theme or route the change page independently of the main user form.
- Give site builders a ready-made route to reference in menus or breadcrumbs.
- Enforce consistent email-change UX across roles without custom code.
- Keep email edits auditable to a single, well-known form and route.
