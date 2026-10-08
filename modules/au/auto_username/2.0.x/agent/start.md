# Auto Username — agent index

Generates a user's `name` from a token pattern (default `[user:mail]`) or an API hook, hiding the
username field on the register/edit forms. Depends on `token` and core `user`. Provides config
schema and permissions; no Drush; no plugin *types* (but ships one Action plugin).

- **Settings form, every `aun_*` config key, cleaning pipeline, update-on-edit, the bulk Action** →
  [configure/settings.md](configure/settings.md)
- **The `auto_username.utilities` service + the hooks it invokes/alters (for custom generators)** →
  [api/api.md](api/api.md)
- **The three permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts (mostly in `auto_username.module` + `src/AutoUsernameUtilities.php`):
- Configure route `auto_username.admin_config` → `/admin/config/people/accounts/patterns`
  (permission `administer auto username`, restricted).
- Register form: `account.name` hidden, pre-set to a UUID so core username validation passes.
  Real name is assigned in `hook_user_insert`; profile edit re-runs it only if `aun_update_on_edit`.
- Name = `hook_auto_username_name()` result if any, else token replacement of `aun_pattern` cleaned by
  `autoUsernameCleanstring()`; then made unique (`_1`,`_2`,…) against `users_field_data`; then
  `hook_auto_username_alter()`; users with `bypass auto_username` are skipped.
- PHP-eval of the pattern is gated by BOTH `aun_php` config AND the `php` contrib module AND the
  restricted `use PHP for username patterns` permission.
- Config object `auto_username.settings`; bulk user Action plugin id `auto_username_rename_action`.
