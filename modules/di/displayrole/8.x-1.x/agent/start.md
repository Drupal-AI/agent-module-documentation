<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Role (displayrole) — agent index

Adds a **"Roles" pseudo-field** to the user entity display so a user's assigned roles render on
their profile page. Version **8.x-1.3**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Depends only on core **`user`**. Ships **only** a `.module` hook file — no `src/`, no routes,
no permissions, no services, no plugins, no config schema/install.

- **How it works, the hooks, config flag, and how to enable/operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- `displayrole_entity_extra_field_info()` registers an extra display component
  `roles` on `user`/`user` (label "Roles", weight 5) — this is what appears on
  **Manage display** (`entity.entity_view_display.user.default`, the `configure` route).
- `displayrole_user_view(&$build, $account, $display)` — if the `roles` component is enabled on
  the display, builds `$build['roles']` as `#theme => item_list__roles` from the account's roles.
- `displayrole_preprocess_username(&$variables)` — if config
  `displayrole.settings:append_role_to_username` is truthy, appends the role list in parentheses
  to `$variables['extra']` for rendered usernames (UI-less flag; set via drush/config import).
- `_displayrole_user_role_names()` — helper returning `[rid => label]` from `Role::loadMultiple()`
  (replacement for core's removed `user_role_names()`).
- `displayrole_help()` — help text pointing at the user display form.

## Operate it

1. `drush en displayrole -y`.
2. People » Account settings » **Manage display** → drag **Roles** out of Disabled into place.
3. (Optional) `drush config:set displayrole.settings append_role_to_username 1`.

Role labels render through core `item_list` (HTML-escaped). No admin form is provided beyond the
core Manage display screen. See [config/settings.md](config/settings.md).
