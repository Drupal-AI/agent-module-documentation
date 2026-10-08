# E-Mail Username — agent index

Uses the e-mail address as the account username: `name` follows `mail`, `mail` is required and
strictly validated. No admin UI (`configure` null), no permissions, no Drush. Depends on core
`user`. Login is core's (authenticates by `name`, which now holds the e-mail).

- **Behaviour, the settings.php validation toggles, and the `UserMail` constraint** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `mail` → `name` sync happens in `hook_user_presave` and a first-priority user-form validate
  handler; the Username field is disabled/hidden on the form.
- `hook_entity_base_field_info_alter` clears `user.name` constraints + makes it optional, and
  makes `user.mail` required with the `UserMail` constraint.
- `hook_install` back-fills existing users' `name` from `mail`.
- No config entity/schema — the only settings are `$settings['email_username'][…]` in
  `settings.php`.
