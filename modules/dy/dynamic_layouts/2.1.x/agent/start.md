<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Layouts (dynamic_layouts) — agent index

Build Drupal Layout API layouts **through the admin UI** instead of declaring them in a theme's
`*.layouts.yml`. Each layout you create is a `dynamic_layout` **config entity** whose rows/columns
become a derived core `@Layout` plugin (id `dynamic_layout:<layout_id>`), usable anywhere layouts are
consumed (Layout Builder, Display Suite, Panels). Depends only on core `layout_discovery` + `system`.
Core `^10 || ^11`. One permission, `admin dynamic layouts`, gates every page.

- **Configure global settings** (frontend library, column prefix, grid size) → [configure/settings.md](configure/settings.md)
- **Create / manage a layout** (rows, columns, classes, regions, category) → [configure/layouts.md](configure/layouts.md)
- **The layout plugin it provides** (deriver, region derivation, frontend render) → [plugins/layout.md](plugins/layout.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Configure route: `dynamic_layout.dynamic_layout_settings` → `/admin/config/dynamic-layouts/settings`.
- Admin list: `/admin/config/dynamic-layouts` (route `dynamic_layout.dynamic_layout_list`, under *Structure*).
- Config entity types: `dynamic_layout` (a layout) and `dynamic_layout_settings` (one singleton entity, id `settings`).
- Config prefixes: `dynamic_layouts.dynamic_layout.*`, `dynamic_layouts.dynamic_layout_settings.*`.
- Layout plugin id `dynamic_layout`, deriver `Drupal\dynamic_layouts\Plugin\Derivative\DynamicLayoutDeriver`;
  derived plugins are `dynamic_layout:<layout_id>`.
- Permission: `admin dynamic layouts`. No Drush commands. No services declared. Provides config schema.
- The `regions` field of a `dynamic_layout` is a PHP-`serialize()`d rows structure (not human-editable YAML);
  create layouts through the UI/entity API, not by hand-writing that string.
