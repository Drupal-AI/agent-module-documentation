<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menus Superfish — agent index

Glue submodule: one block that renders the **active domain's** menu using **Superfish**. Requires
`domain_menus` + `superfish`. No config object, no permissions, no Drush, no configure route.

- **The Superfish domain block and how to place/configure it** →
  [configure/block.md](configure/block.md)

Key facts:
- Block plugin id: `domain_menus_active_domain_superfish_block`
  (`Drupal\domain_menus_superfish\Plugin\Block\DomainMenusSuperfishBlock`, extends
  `Drupal\superfish\Plugin\Block\SuperfishBlock`, category "Superfish").
- Extra block setting: `menu_name` — a domain-menu name from
  `domain_menus.settings:domain_menus_menu_names`; resolved to `dm<activeDomainId>-<name>` at render.
- All other block settings come from Superfish's `SuperfishBlock`.
- Counterpart of the parent module's core `domain_menus_active_domain_menu_block`.
