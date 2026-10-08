<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menu Links adds a "Domains" dropdown to the Drupal administration toolbar that lists every enabled Domain-module domain as a link, so an administrator can switch between the domains of a multisite while browsing.

---

Domain Menu Links is an extension of the Domain (Domain Access) module that surfaces your site's domains in the admin toolbar. It registers a derived menu link plugin: a parent "Domains" item placed in the admin menu (rendered by Admin Toolbar), plus one child link per enabled domain entity. Each child link is titled with the domain's label, points at the domain's configured path, and opens in a new browser tab so you land on that domain. The dropdown is shown only to users holding the "view toolbar domain menu" permission, and the menu is rebuilt automatically whenever a domain is created, updated, or deleted. A small settings form (at /admin/config/domain/domain_menu_links/settings) lets an administrator set the weight of the parent toolbar link so it can be positioned among the other toolbar items. It is an admin-facing navigation convenience — it does not add fields to menu links and does not change front-end menu rendering.

---

- Add a domain switcher to the admin toolbar of a Domain multisite.
- Jump from the current domain to another registered domain in one click.
- List every enabled domain as a link in the toolbar Domains dropdown.
- Open each domain in a new browser tab from the toolbar.
- Give administrators quick cross-domain navigation while editing content.
- Restrict the domain dropdown to specific roles with the "view toolbar domain menu" permission.
- Hide the domain menu from editors who should not switch domains.
- Position the Domains toolbar item by setting its parent menu link weight.
- Automatically refresh the domain links when a new domain is added.
- Automatically remove a link from the toolbar when a domain is deleted.
- Keep the toolbar in sync when a domain is renamed or reconfigured.
- Only list domains that are enabled (disabled domains are skipped).
- Provide a consistent way to reach each domain's home page during QA.
- Speed up testing of per-domain theming or content across a multisite.
- Let a site builder verify domain paths are correct by clicking through them.
- Combine with Admin Toolbar for a native-looking toolbar dropdown.
- Use on Domain 2.x or 3.x installations under Drupal 10 or 11.
- Avoid manually typing or bookmarking each domain URL.
- Give support staff a fast way to reach the affected domain.
- Reduce mistakes from editing the wrong domain by making the current set visible.
