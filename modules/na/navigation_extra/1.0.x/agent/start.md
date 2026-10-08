<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Extra — agent index

Plugin-driven extras for core's `navigation` sidebar: extra sections (content/media/taxonomy/users/
files/blocks/forms/local-tasks/tools/version), collections, and three blocks. Depends on `navigation`.
No permissions of its own; the settings form requires `administer site configuration`
(all behaviour is admin-config behind a trusted permission).

- **Settings form, config structure (`plugins.<id>` maps), per-plugin options** →
  [configure/settings.md](configure/settings.md)
- **The `NavigationExtraPlugin` plugin type, manager, base class, alter phases, and the three blocks** →
  [plugins/plugins.md](plugins/plugins.md)
- **`hook_navigation_extra_collections()` — declare hierarchical navigation collections** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config `navigation_extra.settings`: `plugins` sequence keyed by plugin id; each is
  `navigation_extra.plugin.<id>` (base keys `enabled`, `weight`, optional `icon`, plus plugin-specific
  keys — see schema `config/schema/`).
- Plugin manager `navigation_extra.manager`, namespace `Plugin/Navigation/Extra`, annotation
  `@NavigationExtraPlugin` (`id`, `name`, `description`, `weight`, `dependencies`).
- Built-in plugins: `common`, `blocks`, `content`, `files`, `media`, `taxonomies`, `users`, `forms`,
  `local_tasks`, `tools`, `version`.
- Blocks: `NavigationExtraLocalTasksBlock`, `NavigationExtraVersionBlock`, `NavigationMenuBlockOverride`.
- Route `navigation_extra.settings` → `/admin/config/user-interface/navigation/extra`
  (`administer site configuration`).
