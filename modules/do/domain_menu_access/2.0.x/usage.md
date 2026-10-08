<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menu Access scopes individual **menu links** to domains on a multi-domain Domain site: each link is assigned to one or more domains (or to "all affiliates"), and when the menu is rendered through the module's "Domain Menu" block, links that do not belong to the domain being served are dropped from the tree.

---

Domain Access scopes nodes to domains, but menus stay global — every domain shows every link. This module closes that gap by reusing the same two fields on the `menu_link_content` entity: `hook_install` runs `domain_access_confirm_fields()` to add `field_domain_access` (a multi-value reference to `domain`) and `field_domain_all_affiliates` (a boolean), and a form alter groups them into a *Domain* details element on the menu-link edit form. Which menus participate is configuration: `domain_menu_access.settings:menu_enabled` lists them, edited at `/admin/config/domain/domain_menu_access/config` (permission `administer domains`); for menus not in that list the domain fields are hidden on the link form. Filtering is a menu-tree manipulator, `DomainMenuLinkTreeManipulators::checkDomain()`, which walks the tree and — respecting any decision another manipulator already made — replaces a link that is not available on the active domain with an `InaccessibleMenuLink`, empties its subtree, and adds the `url.site` cache context so menus cache correctly per domain. That manipulator runs only where a block wires it in, so a menu gets domain-aware output when it is placed with the module's **Domain Menu** block (`domain_access_menu_block`, one derivative per enabled menu) rather than the core System Menu block; a submodule adds the same for the contrib Menu Block module. The menu overview table also gains a *Domains* column showing each link's assignments, and a permission, `administer menu items across domains`, lets trusted users manage links belonging to any domain rather than only the current one.

---

- Show different menu links on each domain of a multi-domain site.
- Give a country site its own navigation without duplicating menus.
- Hide an affiliate-specific link from the main site's menu.
- Assign a menu link to several domains at once.
- Use the "all affiliates" flag for links that appear in every domain's menu.
- Restrict which menus participate in domain filtering.
- Let editors see which domains each link targets in the menu overview.
- Allow trusted staff to manage menu links across all domains.
- Keep menu caching correct per domain via the url.site context.
- Reuse Domain Access field configuration for menu links.
- Drop a subtree when its parent link is not available on a domain.
- Present brand-specific navigation from one Drupal install.
- Combine with the Menu Block module for domain-filtered menu blocks.
- Avoid building and maintaining a separate menu per domain.
- Keep menu structure shared while varying which links appear.
- Apply domain rules to a footer menu only, leaving other menus global.
- Give a staging domain a reduced navigation menu.
- Vary a mega-menu's items per domain from a single menu.
- Manage menu domain assignment from the standard menu-link form.
- Migrate an existing menu to domain-aware visibility.
- Apply the domain filter from a custom menu block via the shared manipulator service.
