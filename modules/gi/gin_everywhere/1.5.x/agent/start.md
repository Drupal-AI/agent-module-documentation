<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Everywhere — agent index

Extends the **Gin** admin theme's content-form layout (sticky action bar + advanced meta
sidebar) to **every content entity's** forms, not just nodes. **No configuration** — enabling
the module is the whole setup. Requires the Gin theme. No settings page, permissions, Drush,
config, or plugin types.

- **How it works: the two hooks, the routes it adds, the meta/advanced groups, requirements** →
  [api/behavior.md](api/behavior.md)

Key facts:
- `hook_gin_content_form_routes_alter()` (service
  `Drupal\gin_everywhere\Hook\GinEverywhereHooks::ginContentFormRoutesAlter`) appends, for every
  entity type whose group is `content`, the routes `entity.<type>.add_form`, `.edit_form`,
  `.create_form`, `.override_form`, `.revision`, `.content_translation_add`, and `<type>.add`,
  plus extras: `block_content.add_page`/`add_form`, `entity.block_content.canonical`,
  `entity.media.canonical`, `entity.menu.add_link_form`, `entity.menu_link_content.canonical`.
- `hook_form_alter()` only transforms a form when Gin's `GinContentFormHelper::isContentForm()`
  is true **and** the active theme is `gin` (or has `gin` as a base theme). It then builds the
  `advanced` vertical tabs, the `meta` details (Status/last-saved/author), moves `status` to
  `footer`, adds Authoring information, and moves the path widget into `advanced`.
- Inspect coverage on a running site by invoking
  `\Drupal::service(GinEverywhereHooks::class)->ginContentFormRoutesAlter($routes)` and reading `$routes`.
