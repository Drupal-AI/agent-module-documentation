# Body Roles Classes — agent index

Adds role-based CSS classes to `<body>` via `hook_preprocess_html`. Core `^10 || ^11 || ^12`,
no dependencies, no Drush. Provides a config object + schema and a settings form.

- **Config keys, defaults, the settings form, and exactly how each class is built** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Service `RoleClassGenerator::getClasses()` builds `Html::cleanCssIdentifier(prefix . role)`
  per role (lowercased, `_`→`-`), skips `exclude_roles`, applies `role_map` overrides, and
  always appends `user-authenticated` / `user-anonymous`.
- Config: `body_roles_classes.settings` — `enabled`, `prefix` (`role-`), `exclude_roles`
  (`administrator` by default), `role_map`.
- Output varies by the `user.roles` cache context. Role ids are admin-defined and CSS-escaped,
  so no untrusted data reaches the class attribute.
