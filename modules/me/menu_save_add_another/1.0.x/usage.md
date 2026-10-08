<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes building out a menu faster by fixing the post-save redirect and adding a 'Save and Add Another' button.

---

`hook_menu_local_actions_alter()` (`menu_save_add_another.module`) swaps core's menu add-link local action class for `MenuLinkAddFixRedirect` (`src/Plugin/Menu/LocalAction/...`), which extends core `MenuLinkAdd` and strips the `?destination` query so the redirect is controlled by the form instead. `hook_form_menu_link_content_form_alter()` adds a **Save and Add Another** submit button (weight 6) plus submit handlers: `_menu_save_add_another_redirect_add` redirects back to the menu's add-link form (`entity.menu.add_link_form`), while the normal Save redirects to the menu edit page (`entity.menu.edit_form`); the correct menu is resolved from the route's `menu` raw param or the edited `menu_link_content`'s menu name. `hook_form_menu_edit_form_alter()` also clears the per-row edit-link `destination` query so edits redirect back to the menu. No config, permissions, routes or services; access rides the core `administer menu` permission.

---

- Add many menu links in a row without returning to the menu each time.
- Land back on the 'Add link' form immediately after saving via 'Save and Add Another'.
- Fix core's redirect so saving a new link returns to the menu edit page.
- Stub out an entire navigation structure quickly.
- Keep edits redirecting to the menu instead of the front page.
- Reduce clicks when populating large menus.
- Preserve which menu you're working in across successive adds.
- Work with any menu managed by core `menu_ui`.
- Improve editorial throughput when launching a new site section.
- Require no configuration - the buttons appear automatically.
- Compose with other menu form alterations.
- Use the standard `administer menu` permission for access.
- Avoid manual navigation back to `/admin/structure/menu/manage/<menu>`.
- Support Drupal 8/9/10.
- Streamline repetitive menu-building tasks for content teams.
- Keep the default Save button behaviour intact while adding the new option.
