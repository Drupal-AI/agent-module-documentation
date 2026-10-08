Webform User Registration adds a single Webform handler ("User Registration") that creates a new Drupal user account — or updates the current user's account — from a webform submission, by mapping webform elements to user entity fields.

---

The module provides one plugin, `UserRegistrationWebformHandler` (`@WebformHandler id = "user_registration"`), added per-webform under *Settings › Emails/Handlers*. Its config has three groups: `create_user` (enabled, roles, admin_approval[+message], email_verification[+message], success_message, keep_email_as_username), `update_user` (enabled), and `user_field_mapping` (webform element key → user entity field). At submission time `validateForm()` builds the account: for an **anonymous** submitter it calls `createUserAccount()` when creation is enabled; for an **authenticated** user it loads and updates the current account when update is enabled. The new account gets a generated password (`password_generator`), a username derived from the mapped email (`@`→`.`, or the full email when `keep_email_as_username` is on), the configured roles, and is `block()`ed when admin approval is required or `activate()`d otherwise; `$account->validate()` runs and any entity-constraint violations are surfaced back onto the mapped webform elements. `postSave()` then saves the account and, depending on config, sends `register_pending_approval` (approval), `register_no_approval_required` (email verification), or logs the user straight in with `user_login_finalize()` — each path showing the matching configured message. A mail element mapping is **required** for creation (validated). The handler does not support AJAX submissions (a warning links to disable AJAX or set a confirmation redirect). Notable safe defaults: `create_user.enabled` and `update_user.enabled` are both `FALSE`, and `admin_approval` and `email_verification` both default to `TRUE`. The **Roles** checkboxes are only shown to users who hold `administer permissions` (`#access` guard), so a lower-privileged webform admin cannot assign roles through that UI.

---

- Build a custom, branded registration form with Webform and turn submissions into accounts.
- Collect extra profile data (fields) at signup and map each element to a user field.
- Require administrator approval before a submitted registration becomes active.
- Require email verification (system-generated password) before first login.
- Log users in immediately after registration when neither approval nor verification is needed.
- Assign one or more roles to newly created users (when the admin has `administer permissions`).
- Use the visitor's email address as their username instead of replacing `@` with `.`.
- Prevent duplicate accounts by rejecting an email already used as a name/mail (email-as-username mode).
- Let authenticated users update their own account fields via a webform.
- Map a "Full name" or phone element to a custom user field at registration.
- Show a custom success / pending-approval / verification message per webform.
- Create application/intake forms that provision accounts on approval.
- Provide a multi-step registration form (validation skips until user fields are reached).
- Localize the new account's langcode to the current interface language automatically.
- Surface Drupal user-validation errors (e.g. invalid email, taken name) inline on the webform.
- Stand up an event or membership signup that also creates a login.
- Keep account-creation behavior in exportable config on the webform handler.
- Send the standard Drupal registration emails (pending-approval / no-approval) from a webform.
- Set the webform submission's owner to the newly created (not-yet-logged-in) account.
- Add multiple User Registration handlers to one webform (cardinality unlimited).
- Restrict who can configure role assignment by leaning on the `administer permissions` gate.
- Replace bespoke `hook_webform_submission_*` account-creation code with a maintained handler.
