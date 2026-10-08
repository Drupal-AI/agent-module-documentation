<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menu Links (domain_menu_links) — agent index

Adds a **"Domains" dropdown to the administration toolbar** listing every **enabled** Domain
entity as a link (title = domain label, URL = the domain's path, opens in `_blank`), so an admin
can switch between the domains of a Domain-module multisite. Package **Domain**. Version **2.x**
(2.0.2 on disk). Core `^10 || ^11`. License GPL-2.0-or-later.

Depends on **`domain:domain`** (`drupal/domain ^2.0 || ^3.0`) and **`admin_toolbar:admin_toolbar`**
(`^3.3`). Admin-UX navigation only — it does **not** add fields to menu links and does **not**
filter or hide front-end menu links per domain.

- **The toolbar menu, the derivative, the menu-link plugins, caching, the permission, and the hooks**
  → [menu/toolbar-domains.md](menu/toolbar-domains.md)
- **The settings form and its config object/schema** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One **derived menu link** advertised in `domain_menu_links.links.menu.yml`:
  `domain_menu_links.domain` (title "Domains", `parent: system.admin`, `menu_name: admin`,
  toolbar icon class `toolbar-icon-domain-menu`), with `deriver:
  Drupal\domain_menu_links\Plugin\Derivative\DomainMenuDeriver`.
- `DomainMenuDeriver::getDerivativeDefinitions()` loads all `domain` entities; emits a base entry
  under key `0` (the parent) and one derivative **per enabled domain** (`$domain->status()`), each
  titled `$domain->label()`, URL `$domain->getPath()`, weight `$domain->getWeight()`, class
  `DomainMenuLink`, `options.attributes.target = _blank` + class `domain-menu-links-link`, and cache
  metadata copied from the domain.
- `Plugin/Menu/DomainMenu` (parent link): `getWeight()` reads config `parent_menu_link_weight`;
  `getCacheContexts()` = `['url.site']`; `getCacheTags()` = `['domain_list']`; `isEnabled()` =
  current user has **`view toolbar domain menu`** AND at least one domain exists.
- `Plugin/Menu/DomainMenuLink` (child links): resolves its domain from the plugin id suffix and
  returns that domain's `getCacheContexts()`/`getCacheTags()`.
- **Permission** (`domain_menu_links.permissions.yml`): `view toolbar domain menu`.
- **Hooks** (`domain_menu_links.module`): `hook_page_attachments` attaches the CSS library
  `domain_menu_links/domain_menu_links` when the user is authenticated and has both `access toolbar`
  and `view toolbar domain menu`; `hook_domain_insert/update/delete` each call
  `plugin.manager.menu.link->rebuild()`; `hook_help` for `help.page.domain_menu_links`.
- **Settings**: route `domain_menu_links.settings` at
  `/admin/config/domain/domain_menu_links/settings` (permission **`administer site
  configuration`**), form `DomainMenuLinksSettingsForm`, config object
  `domain_menu_links.settings` (single key `parent_menu_link_weight`, default `'-11'`).
- No services.yml, no Drush, no submodules, no config entities, no field/base-field additions.
