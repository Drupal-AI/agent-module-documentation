Automatically generates a user's username from a configurable token pattern (e.g. `[user:mail]`) or an API hook, hiding the username field on the registration/edit forms so the name is derived rather than typed.

---

Auto Username hides the core username field on both the user register form and the user profile form (`hook_form_FORM_ID_alter` sets `account.name` to `#type => hidden`; on registration it is pre-filled with a throwaway UUID so core's `UserNameConstraintValidator` passes). On `hook_user_insert` (and, if `aun_update_on_edit` is on, `hook_user_update`) it generates the real name via the `auto_username.utilities` service: it lets any module return a name from `hook_auto_username_name($account)`, otherwise runs the configured token pattern (`aun_pattern`, default `[user:mail]`) through the token service, cleaning each replacement with `autoUsernameCleanstring()`. Cleaning can strip HTML, transliterate to ASCII, apply per-character punctuation rules (remove / replace-with-separator / leave), remove "ignore words", collapse whitespace to a separator, lowercase, and truncate to a max length (bounded by the `users.name` schema length). The generated name is then made unique by appending `_1`, `_2`, … if it collides with another account, and written directly to `users_field_data`. A `hook_auto_username_alter($data)` lets modules post-process the final name. Users with the `bypass auto_username` permission are skipped. A `use PHP for username patterns` permission plus `aun_php` toggle allow evaluating the pattern as PHP through core's contrib `php` module (both are `restrict access: TRUE` / require the `php` module). A bulk user Action plugin `auto_username_rename_action` ("Generate username(s) using the Auto Username module") re-generates names for selected users from the People admin view. Config is at `/admin/config/people/accounts/patterns`.

---

- Force usernames to equal each user's email address (`[user:mail]`, the default pattern).
- Derive usernames from first/last name fields via user tokens.
- Build usernames from a custom user profile field using a token.
- Hide the username field on registration so visitors never pick their own name.
- Regenerate a user's name automatically whenever their profile is edited (`aun_update_on_edit`).
- Transliterate non-ASCII names (e.g. accented or non-Latin) into ASCII usernames.
- Strip or replace specific punctuation characters when building the name.
- Replace whitespace in the pattern output with a chosen separator (e.g. `-` or `.`).
- Remove filler/"ignore" words (e.g. "the", "and") from generated usernames.
- Lowercase all generated usernames for consistency.
- Cap username length overall and per component to fit the schema limit.
- Guarantee uniqueness by auto-appending `_1`, `_2`, … on collisions.
- Exempt admins or specific roles from renaming via the `bypass auto_username` permission.
- Bulk-regenerate usernames for existing users with the "Generate username(s)" bulk action.
- Programmatically override a generated name from custom code via `hook_auto_username_alter()`.
- Provide a fully custom generator by implementing `hook_auto_username_name()`.
- Add extra punctuation options to the cleaner via `hook_autoUsernamePunctuationChars_alter()`.
- Normalise imported/migrated user accounts to a house naming convention.
- Prevent duplicate or vanity usernames by deriving names from trusted fields.
- Keep usernames in sync with email addresses across the site.
- Use PHP-evaluated patterns for advanced logic (requires the `php` module and the restricted permission).
- Enforce a consistent username format for SSO/externally-provisioned accounts.
- Clean up messy display/login names on a legacy site in one bulk pass.
