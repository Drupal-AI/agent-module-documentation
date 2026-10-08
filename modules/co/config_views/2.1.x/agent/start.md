<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Entity View (config_views) — agent index

Lets Views list **config entities** (roles, menus, image styles, content types, views, …).
Registers a base table `config_<prefix>` per config-entity type and a Views query plugin that
uses the Entity Query API. No settings form, no `configure` route, no permissions, no Drush.

- **Build a View of config entities; the base-table naming; the shipped default Views** →
  [configure/config-view.md](configure/config-view.md)
- **How the Views data & query are generated (schema walk, query plugin)** →
  [api/mechanism.md](api/mechanism.md)
- **The Views handlers + the config_views entity-reference selection plugin** →
  [plugins/handlers.md](plugins/handlers.md)

Key facts:
- Base table = `config_` + the type's config prefix with `.` → `_`: `node.type` →
  `config_node_type`, `user.role` → `config_user_role`, `image.style` → `config_image_style`,
  `system.menu` → `config_system_menu`, `views.view` → `config_views_view`.
- Query plugin id `views_config_entity_query` (extends the SQL query plugin but runs
  `EntityQuery`). Only config-entity types that have a **list builder** and a **config prefix**
  are exposed.
- Ships ~14 Views (some enabled, some disabled) that can replace core admin list pages, e.g.
  `content_types` at `admin/structure/types`.
