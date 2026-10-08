<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Position — agent index

Rules that dynamically place the **current page** into a menu. A rule is a
`menu_position_rule` config entity whose conditions are **core Condition plugins**; placement is
done by a service that **decorates `menu.active_trail`**.

- **Create/read/order rules, the config entity shape, the settings key, routes and drush**
  → [configure/rules.md](configure/rules.md)
- **How matching and placement actually work (decorator, deriver, link plugin) and how to
  extend it** → [api/active-trail.md](api/active-trail.md)
- **The one permission and what it gates** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- Config entity prefix: `menu_position.menu_position_rule.<id>`; exported keys
  `id, label, enabled, conditions, menu_name, parent, menu_link, weight`.
- Settings: `menu_position.settings:link_display` ∈ `parent` (default) | `child` | `none`.
- `configure` route = `entity.menu_position_rule.order_form` → `/admin/structure/menu-position`.
- **No plugin type of its own.** Conditions come from core's `plugin.manager.condition`
  (`entity_bundle:node`, `request_path`, `user_role`, `current_theme`, `language`, …).
- Each rule derives a menu link `menu_position_link:<rule_id>` (deriver
  `Drupal\menu_position\Plugin\Derivative\MenuPositionLink`).
- No Drush commands. `menu_position.services.yml` also declares
  `plugin.manager.menu_position_condition_plugin.processor`, but **the class it points at does
  not exist in this release** — do not use that service.
