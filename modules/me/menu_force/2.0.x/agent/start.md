<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Force — agent index

Makes the core **Menu settings** mandatory on chosen content types: a node of that type
cannot be saved until it is placed in a menu. Pure form-alter module — depends on
`menu_ui`, has **no configure route** (`configure: null`), no settings form, no permissions,
no plugins, no Drush. All persistent state is **two booleans** stored as third-party
settings on the `node.type.<bundle>` config entity.

- **Turn the requirement on for a content type / where it is stored** →
  [configure/require-menu.md](configure/require-menu.md)
- **How it enforces the requirement on the node form (hooks, form alterations)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: config path is
`node.type.<bundle>` → `third_party_settings.menu_force.menu_force: true`
(and optionally `menu_force_parent: true` to also lock the default parent item). The
`menu_force_taxonomy_menu_ui` submodule mirrors this for taxonomy vocabularies — see
[../../modules/menu_force_taxonomy_menu_ui/2.0.x/agent/start.md](../../modules/menu_force_taxonomy_menu_ui/2.0.x/agent/start.md).
