<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menu Access (domain_menu_access) — agent index

Extends the Domain module to scope individual **menu links** to domains: on a multi-domain site a
menu link is shown only on the domains it is assigned to. It reuses Domain Access's own two fields
on the `menu_link_content` entity and filters the menu tree when the menu is rendered through the
module's "Domain Menu" block.

- Requires: `domain:domain`, `domain:domain_access`, `drupal:menu_link_content`. Core `^10.2 || ^11`.
- Configure: `domain_menu_access.settings` → `/admin/config/domain/domain_menu_access/config`
  (permission `administer domains`).
- Defines: 1 permission, config schema, 1 block plugin (+ deriver), 1 tree-manipulator service.
  No Drush commands. No plugin types.
- Submodule (own docs): **Domain Menu Access (Menu Block)** →
  [../../modules/domain_menu_access_menu_block/2.0.x/agent/start.md](../../modules/domain_menu_access_menu_block/2.0.x/agent/start.md)

## Solution docs

- **Choose which menus use domain control** → [configure/menus.md](configure/menus.md)
- **Assign a menu link to domains (the fields, the link form, semantics)** →
  [configure/menu-link-domains.md](configure/menu-link-domains.md)
- **Render a menu filtered per domain (the block)** → [blocks/domain-menu-block.md](blocks/domain-menu-block.md)
- **Apply the domain filter from your own code** → [api/tree-manipulator.md](api/tree-manipulator.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

## Key facts

- Config: object `domain_menu_access.settings`, key `menu_enabled` (sequence of menu machine
  names; default `[]`). Form `DomainMenuAccessSettingsForm` (id `domain_menu_access_settings`).
- Fields on `menu_link_content` (created in `hook_install` via `domain_access_confirm_fields`):
  `field_domain_access` (entity_reference → `domain`, multi) and `field_domain_all_affiliates`
  (boolean) — the `DomainAccessManagerInterface::DOMAIN_ACCESS_FIELD` / `DOMAIN_ACCESS_ALL_FIELD`
  constants.
- Filter: service `domain_menu_access.default_tree_manipulators` → `DomainMenuLinkTreeManipulators::checkDomain()`
  (untagged; only runs where a block adds it to `menuTree->transform()`).
- Block: `domain_access_menu_block` ("Domain Menu"), extends core `SystemMenuBlock`; deriver
  publishes one per menu in `menu_enabled`. Adds the `url.site` cache context.
- Permission: `administer menu items across domains`. Settings route uses `administer domains`.
- Hooks in `.module`: `hook_menu_link_content_presave`, `hook_form_menu_link_content_form_alter`,
  `hook_preprocess_table__menu_overview` (adds a **Domains** column to the menu overview).

```bash
drush cget domain_menu_access.settings menu_enabled
drush cset domain_menu_access.settings menu_enabled.0 main -y
drush role:perm:add site_admin 'administer menu items across domains'
```
