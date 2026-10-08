<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form Mode Manager — agent index

Makes Drupal form modes usable: generates add/edit routes, tabs, local actions, operations links
and per-mode permissions for each **active** form mode. Depends only on core `field`.

- **Activate a form mode, the two settings forms, config objects, and generated routes** →
  [configure/settings.md](configure/settings.md)
- **The `entity_routing_map` plugin type and supporting a custom entity** →
  [plugins/entity-routing-map.md](plugins/entity-routing-map.md)
- **The dynamic per-form-mode permissions** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `form_mode.manager` service (public API methods)** →
  [api/service.md](api/service.md)

Key facts:
- A form mode is **active** for an entity type when a `core.entity_form_display.<entity>.<bundle>.<mode>`
  config exists (mode != `default`). That is what enabling "Custom Display settings" on *Manage form
  display* creates. Then FMM exposes `entity/add/{bundle}/{mode}` etc.
- Settings form (configure route): `form_mode_manager.admin_settings`
  (`/admin/config/content/form_mode_manager`) → config `form_mode_manager.settings`
  (`form_modes.<entity>.to_exclude`). Second form: `form_mode_manager.admin_settings_links_task`
  (`/…/links-task`) → config `form_mode_manager.links` (`local_tasks.<entity>.position`).
- Plugin type: **`entity_routing_map`** (manager `plugin.manager.entity_routing_map`; annotation
  `@EntityRoutingMap`). Built-ins: node, user, taxonomy_term, block_content, `generic` (fallback).
- Dynamic permissions: `use <entity_type>.<form_mode> form mode` and `use <entity_type>.default form mode`.
- Submodules: `form_mode_manager_examples`, `form_mode_manager_theme_switcher`, `form_mode_user_roles_assign`.
