<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menu Access — agent index

Submodule of Domain Access Entity that scopes **core menu links** per domain. Ships a
`domain_access` field on `menu_link_content`; you enable control **per menu**, and links then
only render on the domain(s) they reference.

- **Enable control per menu, the field, the block swap, and tree filtering** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `configure` route: `domain_menu_access.settings` at
  `/admin/config/domain/menu/access/settings` (permission `administer domains`).
- Per-menu opt-in = `third_party_settings.domain_menu_access.access_enabled = true` on the
  `system.menu.<id>` config entity (set via the settings-form checkbox).
- Field: `domain_access` on `menu_link_content` (entity_reference → `domain`, cardinality -1),
  installed from this module's `config/install`. Empty value = visible on all domains.
- On an enabled menu, `hook_block_alter` swaps `system_menu_block:<menu>` for
  `DomainMenuAccessMenuBlock`; `DomainMenuLinkTreeManipulators::checkDomain()` forbids links
  whose domains exclude the active domain. Access varies by `url.site`.
- No permissions of its own; form field visibility uses Domain Access's `publish to any domain`
  / `publish to any assigned domain`.
