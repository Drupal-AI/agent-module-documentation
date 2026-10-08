<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menu Access (Menu Block) extends the domain filtering of menu links to blocks created with the Menu Block module, so a domain-filtered menu renders correctly when placed through Menu Block rather than core's menu blocks.

---

Core's menu blocks build their tree through the standard menu tree service, so the parent module's tree manipulator applies automatically. Menu Block builds its own block plugins with additional configuration (depth, starting level, expanding all children), and without this submodule those blocks can bypass the domain check. Enabling it adds the integration so Menu Block-provided blocks pass through the same `DomainMenuLinkTreeManipulators::checkDomain()` logic, keeping links restricted to the domains they are assigned to and preserving the `url.site` cache context. It has no configuration, permissions or schema of its own; it exists purely to bridge the two modules, and its only dependencies are `domain_menu_access` and `menu_block`.

---

- Use Menu Block for navigation on a multi-domain site.
- Keep domain filtering when a menu is placed via Menu Block.
- Render a domain-filtered submenu from a chosen starting level.
- Limit menu depth while respecting domain assignments.
- Avoid links from other domains leaking into a Menu Block block.
- Combine Menu Block's configuration with domain access.
- Place several domain-aware menu blocks in different regions.
- Keep per-domain caching correct for Menu Block output.
- Reuse one menu across domains with different visible subsets.
- Add domain filtering to an existing Menu Block setup.
- Support brand-specific footer navigation.
- Avoid writing a custom block plugin for domain menus.
- Keep menu structure shared between domains.
- Provide a reduced navigation on a staging domain.
- Filter expanded menu trees by domain.
- Support nested menus with hidden parents.
- Keep the integration optional for sites without Menu Block.
- Deploy the same menu configuration across domains.
- Ensure editors see consistent behaviour in both block types.
- Migrate from core menu blocks to Menu Block without losing filtering.
