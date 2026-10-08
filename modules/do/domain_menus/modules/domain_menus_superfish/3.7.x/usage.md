<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menus Superfish is a small glue submodule that adds a Superfish-powered block for rendering the active domain's menu, combining Domain Menus' active-domain resolution with the Superfish drop-down menu module.

---

It provides a single block plugin, `domain_menus_active_domain_superfish_block`
(`DomainMenusSuperfishBlock`), which extends `superfish`'s `SuperfishBlock` so it inherits all of
Superfish's drop-down styling/behavior options, and adds one setting: **`menu_name`**, a select whose
options are the domain-menu "names" from `domain_menus.settings:domain_menus_menu_names`. At render
time `getDerivativeId()` resolves the chosen name to the active domain's menu id
`dm<activeDomainId>-<name>` (via `DomainMenusConstants::DOMAIN_MENUS_MENU_ID_PATTERN`), so the block
always shows the current domain's version of that menu as a Superfish menu. It requires both
`domain_menus` and `superfish`, ships no config, no permissions, no Drush, and no configure route —
you use it purely by placing the block. It is the Superfish counterpart of the parent module's core
`domain_menus_active_domain_menu_block`.

---

- Show the active domain's main menu as a Superfish drop-down menu.
- Place a per-domain footer/secondary menu with Superfish styling.
- Give a multi-domain site consistent Superfish menus that follow the active domain automatically.
- Reuse all Superfish options (depth, animation, hover intent) on a domain-aware menu.
- Pick which named domain menu the Superfish block renders (`menu_name` setting).
- Swap the core domain-menus block for a Superfish version without changing the menu structure.
- Render a domain's navigation with accessible keyboard/hover drop-downs.
- Place the block in a region and have it resolve `dm<domainId>-<name>` per request.
- Provide brand-specific drop-down navigation on an affiliate/multi-brand site.
- Combine domain-scoped menu editing (from domain_menus) with Superfish presentation.
- Offer editors the same Superfish configuration UI they already know, but domain-aware.
- Display different Superfish menus on different domains from one block placement per domain.
- Use Superfish's multi-column/large-menu features on a per-domain menu.
- Keep the mobile/drop-down behavior identical across domains while the links differ.
- Avoid writing custom code to wire Superfish to per-domain menus.
