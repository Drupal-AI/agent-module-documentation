<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Controls the maximum length of the menu link title field via a simple config value (with a code override option).

---

`hook_entity_base_field_info_alter()` (`menu_title_length.module`) sets `menu_link_content.title`'s `max_length` from the first available of: config `menu_title_length.settings:menu_title_length`, then `Settings::get('menu_title_length')` (settings.php), then the constant `MenuTitleLengthConstant::MENU_TITLE_LENGTH` (20). The settings form `MenuTitleLengthSettingsForm` at `/admin/config/system/menu-title-length/settings` (permission **`administer site configuration`**) stores the number in config; default config ships `menu_title_length: 20`. Unlike Media Title Length, this only changes the field definition's `max_length` setting (validation length), not the database column - so it constrains input length rather than altering storage. No submodule, service or Drush command.

---

- Cap menu link titles at a chosen length (default 20 characters).
- Enforce concise navigation labels site-wide.
- Increase the limit for menus that need longer labels.
- Set the limit through config at `/admin/config/system/menu-title-length/settings`.
- Override the limit per-environment via `$settings['menu_title_length']` in settings.php.
- Fall back to a sensible default constant when nothing is configured.
- Keep navigation tidy by preventing overly long menu titles.
- Apply the constraint to all `menu_link_content` links.
- Restrict configuration to users with `administer site configuration`.
- Validate menu title input length at the field-definition level.
- Use on Drupal 8.8+, 9 or 10.
- Coordinate menu label length with theme/design constraints.
- Avoid truncating long titles in navigation by disallowing them up front.
- Change the limit without touching the database schema.
- Support editorial guidelines that require short menu labels.
- Ship a default of 20 so the constraint is active immediately after install.
