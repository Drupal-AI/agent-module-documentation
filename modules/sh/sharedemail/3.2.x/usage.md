<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shared Email lets the same email address be registered on more than one Drupal user account by replacing core's email-uniqueness validation, and warns users (with permission) when they save an already-used address.

---

Core normally enforces one account per email via the `UserMailUnique` constraint on the user `mail` base field. Shared Email uses `hook_entity_base_field_info_alter()` to remove that constraint and add its own `SharedEmailUnique` constraint (a subclass of core's `UserMailUnique`) whose validator extends `UniqueFieldValueValidator`. The validator skips the uniqueness check when the current user has the `create shared email account` permission **and** the email is either on a configured allowlist or the allowlist is empty; otherwise it falls back to the normal unique-email behaviour. It ships a settings form at `/admin/config/people/shared-email` (route `sharedemail.settings_form`, config object `sharedemail.settings`) with two keys: `sharedemail_msg` (the warning text) and `sharedemail_allowed` (a comma-separated allowlist of addresses that may be shared; blank = allow any). A `hook_form_user_form_alter()` submit handler shows the `sharedemail_msg` warning after saving a duplicate address, but only to users holding the `access shared email message` permission. It defines three permissions and no Drush commands or plugins beyond the validation constraint. Works for both registration and account edits.

---

- Allow two or more staff members to share a single departmental inbox address for their accounts.
- Let a family reuse one email address across several site memberships.
- Permit a shared "info@" address to back multiple role-based logins.
- Register a new account with an email that already belongs to another user (with the right permission).
- Update an existing user's email to one already in use, without the "email already taken" error.
- Restrict shareable addresses to a specific allowlist via `sharedemail_allowed` (e.g. only `team@example.com`).
- Allow any duplicate email by leaving the allowlist blank.
- Show a custom warning message to editors when they save a shared address (`sharedemail_msg`).
- Give trusted admins the `create shared email account` permission to bypass uniqueness while normal users keep it.
- Keep the uniqueness rule enforced for anonymous/self-registration while allowing admins to create shared accounts.
- Migrate legacy data where duplicate emails already exist without tripping core validation.
- Support B2B sites where one purchasing email maps to several buyer accounts.
- Let a single contractor email be attached to multiple client-scoped accounts.
- Warn a site owner (via the message permission) that password-reset mail will go to a shared inbox.
- Configure the shared-email warning wording per site through exported `sharedemail.settings` config.
- Turn shared-email behaviour on/off by enabling/disabling the module (it only alters the `mail` field constraint).
- Provide a per-address allowlist so most emails stay unique but a few can be shared.
- Enable multiple test/QA accounts to use one mailbox during development.
- Combine with the `access shared email message` permission to notify users they are on a shared address.
- Reuse one email for both a personal and an organizational account on the same site.
- Avoid a custom validation module just to relax the one-account-per-email rule.
