<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Menu Access (Menu Block) (domain_menu_access_menu_block) — agent index

Bridges [domain_menu_access](../../../../2.0.x/agent/start.md) with the **Menu Block** module so
Menu Block-built trees are domain-filtered too. No config, permissions, schema or Drush.

Key facts:
- Dependencies: `domain_menu_access:domain_menu_access` and `menu_block:menu_block`. Both must be
  present; the submodule is inert without Menu Block.
- Core menu blocks already pass through the parent module's
  `DomainMenuLinkTreeManipulators::checkDomain()`. Menu Block builds its own block plugins with
  extra configuration (starting level, depth, expand-all), which is why the integration is a
  separate module rather than automatic.
- Behaviour and caching match the parent: forbidden links become `InaccessibleMenuLink`, their
  subtrees are cleared, and the `url.site` cache context is added so blocks cache per domain.

```bash
drush en menu_block domain_menu_access_menu_block -y
drush cr
```
