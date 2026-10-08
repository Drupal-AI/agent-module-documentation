<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link Save and Add Another - agent index

Fixes the menu add-link redirect and adds a 'Save and Add Another' button. Depends on `menu_ui`.
No config/routes/permissions/services; access via core `administer menu`.

Key facts (`menu_save_add_another.module`):
- `hook_menu_local_actions_alter()` -> `MenuLinkAddFixRedirect` (extends `MenuLinkAdd`, strips `?destination`).
- `hook_form_menu_link_content_form_alter()` adds `submit_and_add` button + redirect submit handlers:
  add-another -> `entity.menu.add_link_form`, normal save -> `entity.menu.edit_form` (menu resolved from
  route param or the link's `getMenuName()`).
- `hook_form_menu_edit_form_alter()` clears per-row edit-link destination query. Version dir `1.0.x`.
