Email Registration Username makes a user's **full email address** their username (not just the part before the `@`) and keeps the two fields in sync, with an option to override the publicly displayed name to avoid leaking email addresses.

---

This submodule of Email Registration changes the username-generation strategy: instead of stripping the email down to its local part, it implements `hook_email_registration_name_alter()` to set the username to the **entire email address** on new accounts, and — for existing accounts — re-syncs the username whenever the email changes, but only if the two were already in sync (so users who deliberately picked a different username keep it). Because storing the email as the username can disclose addresses, it adds a "Override user display name" setting (`username_display_override_mode`) on the core Account settings form with three modes: `disabled` (show the username/email as-is), `email_registration` (show only the part before the `@`), and `custom` (replace it with static text or `token`-based text via `username_display_custom`). The override is applied through `hook_user_format_name_alter()` and is **skipped for viewers holding the "view user email addresses" permission**. It also swaps the parent module's bulk action, via `hook_action_info_alter()`, so "Update username (from email_registration)" writes the full email (`UpdateUsernameWithMailAction`) instead of a stripped name. On install it forces `email_registration.settings.login_with_username` to false and disables that checkbox, since logging in with a separate username is meaningless here. It requires `email_registration` and `token`.

---

- Store each user's full email address as their Drupal username.
- Keep username and email in sync when an admin or user updates the email address.
- Preserve a manually chosen custom username instead of overwriting it on email change.
- Hide the email-in-username from other users by overriding the displayed name.
- Show only the local part (before `@`) as the public display name (`email_registration` mode).
- Replace the display name with static text like `****` to obfuscate it (`custom` mode).
- Use `token` values (e.g. `[user:field_full_name]`) to build a custom display name.
- Always show the real username/email to staff who have "view user email addresses".
- Bulk-rewrite existing users' usernames to their full email via the People view action.
- Turn a site into a strict email-is-identity setup where username == email everywhere.
- Reduce confusion by removing the separate "username" concept entirely for end users.
- Automatically re-sync a changed email into the username during profile edits.
- Comply with a policy that user login identifier must equal the email of record.
- Mitigate the email-disclosure risk of email-as-username with the display override.
- Disable the parent module's "log in with username" option (done automatically on install).
- Present pseudonymous display names publicly while keeping email as the login/username.
- Migrate an existing user base to email-as-username with one bulk action run.
- Customize how much of the email is exposed per site policy without custom code.
- Keep display-name overriding dynamic (applied at render time via a name-format hook).
- Combine with the parent module so both registration and login are fully email-driven.
