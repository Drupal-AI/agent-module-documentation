# Registration Link — agent index

Adds a **Register** menu link to the core `account` menu for anonymous visitors (and admins),
re-declaring `/user/register` with a custom access check that respects core's registration setting.
No settings form (`configure` null), no permissions, no config schema, no Drush. Core-only.

- **The menu link, the route + custom access check, and how visibility is decided** →
  [configure/link.md](configure/link.md)

Key facts:
- Menu link `registration_link.user_register` → route `registration_link.register`, `menu_name: account`, weight 10.
- Route `/user/register` (`_entity_form: user.register`) requires `_role: 'administrator+anonymous'` and
  `_registration_link_custom_access: 'TRUE'`.
- Access checker `RegistrationLinkAccessCheck`: allows `administrator` role always; else allows only if
  anonymous AND `user.settings:register !== REGISTER_ADMINISTRATORS_ONLY` (cache-tagged to `user.settings`).
- It only exposes/gates a link; account creation is still core's own `user.register` form and its rules.
