<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Title length - agent index

Sets `menu_link_content.title` `max_length` from config (or settings.php / a default constant). No deps.

Key facts:
- `hook_entity_base_field_info_alter()` resolves length: config `menu_title_length.settings:menu_title_length`
  -> `Settings::get('menu_title_length')` -> `MenuTitleLengthConstant::MENU_TITLE_LENGTH` (20).
- Form `MenuTitleLengthSettingsForm` at `/admin/config/system/menu-title-length/settings`
  (perm `administer site configuration`). Default config `menu_title_length: 20`.
- Only alters the field setting (input validation length), NOT the DB column. Version dir `8.x-1.x`.
