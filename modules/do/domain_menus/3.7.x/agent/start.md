<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menus — agent index

Gives each Domain (Domain module) its own set of menus and delegates menu editing via
domain-scoped permissions. A menu becomes a "domain menu" when it carries the
`domain_menus.domains` third-party setting on its config entity.

- **Settings form, config keys, bulk create/delete, menu naming** →
  [configure/settings.md](configure/settings.md)
- **Permissions (`edit assigned/active domain menus`) and access logic** →
  [permissions/permissions.md](permissions/permissions.md)
- **Blocks, entity-reference selection, third-party settings, domain hooks, autocomplete filter** →
  [api/behavior.md](api/behavior.md)
- **Theme suggestions (`menu__domain_menu`)** →
  [theming/theming.md](theming/theming.md)

Key facts:
- Configure route: `domain_menus.settings` → `/admin/config/domain/domain_menus`; management list
  `domain_menus.menus` → `/admin/structure/domain-menus`.
- Config object `domain_menus.settings` (menu names + toggles). Depends on `domain` and `menu_ui`.
- Auto-created menu id pattern: `dm<domainId>-<name>` (`DomainMenusConstants::DOMAIN_MENUS_MENU_ID_PATTERN = 'dm%u-%s'`).
  Do not manually machine-name menus in that pattern.
- Domain-menu marker: menu third-party settings `domain_menus.domains` (assignment map) and
  `domain_menus.auto-created` (1 for machine-generated).
- Submodule: `domain_menus_superfish` (Superfish block). Blocks: `domain_menus_active_domain_menu_block`.
