<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menus lets each domain (from the Domain module) have its own set of menus — e.g. a per-domain main or footer menu — so menu and menu-link administration can be delegated to users with domain-scoped permissions instead of full "administer menus".

---

The module marks any menu as a "domain menu" by storing Domain third-party settings on the menu config entity: `domain_menus.domains` (a map of assigned domain ids) and, for machine-generated ones, `domain_menus.auto-created`. On the settings form (`/admin/config/domain/domain_menus`, config object `domain_menus.settings`) you list menu "names" (e.g. `main`, `alt`) and can **bulk create** one menu per name per domain — auto-named `dm<domainId>-<name>` (constant `DOMAIN_MENUS_MENU_ID_PATTERN = 'dm%u-%s'`) — or bulk delete them; auto-create/auto-delete also fire on domain insert/delete (`hook_domain_insert`/`_delete`). Access is enforced through `hook_ENTITY_TYPE_access()` on menus and menu links: `administer menu` edits any menu, while the two module permissions — **Edit assigned domain menus** and **Edit active domain menus** — grant editing only where the user's Domain Access assignment intersects the menu's domains (the "active" variant additionally requires the menu to belong to the currently active domain). A management page at `/admin/structure/domain-menus` lists the domain menus a user may edit. Two blocks render the *active* domain's menu: `domain_menus_active_domain_menu_block` (core menu block) and, in the submodule, a Superfish-based one. Extra options filter node-link autocomplete to the domain (via an EntityReferenceSelection plugin `domain_menus:node`), hide auto-created menus from `admin/structure/menu` and the Admin Toolbar, set a default menu parent for node forms, and provide `menu__domain_menu` template suggestions.

---

- Give each domain its own main menu so sites on one Drupal install have independent navigation.
- Give each domain its own footer (or any named) menu set.
- Bulk create a menu for every domain from a list of menu names in one click.
- Bulk delete all domain menus for a menu name.
- Auto-create a domain's menus when the domain is added, and remove them when it is deleted.
- Delegate menu editing to per-domain editors without granting full "administer menus".
- Let a user edit only the menus of the domains they are assigned (Edit assigned domain menus).
- Restrict a user to editing only the currently active domain's menus (Edit active domain menus).
- Place a block that always shows the active domain's version of a named menu.
- Show the active domain's menu using Superfish drop-downs (domain_menus_superfish submodule).
- Assign a single menu to multiple domains for a shared/common menu.
- Filter internal node-link autocomplete on menu links to nodes available on that domain.
- Hide auto-created domain menus from the standard `admin/structure/menu` list to reduce clutter.
- Hide auto-created domain menus from the Admin Toolbar menu dropdown.
- Set a default parent menu for new menu links added on node forms, per active domain.
- Enable domain menus as an available menu parent on selected content types' node forms.
- Recognize any hand-made menu as a domain menu by assigning it domains on the menu edit form.
- Copy content-translation settings from a source menu to auto-created domain menus.
- Provide `menu__domain_menu` theme suggestions to style domain menus distinctly.
- Run a multi-brand / affiliate site where each brand manages its own navigation.
- Scope menu-link create/edit access to domain editors on `/admin/structure/domain-menus`.
