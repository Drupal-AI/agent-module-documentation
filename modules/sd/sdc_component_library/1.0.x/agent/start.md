<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SDC - Component library (sdc_component_library) — agent index

Renders one preview page listing every Single Directory Component (SDC) known to the
site. Each component that ships a `<machine>.story.twig` file is rendered with that
file's dummy data; each component also gets a "Show code" snippet and an in-page
axe-core accessibility scan. No module dependencies (uses core's SDC plugin manager).
Core requirement: `^10.3 || ^11`.

Configure route: `sdc_component_library.settings` (`/admin/config/system/sdc-component-library`).
Defines 1 permission. No drush commands. Defines no plugin types (it consumes core's
`plugin.manager.sdc`). Provides config schema and a theme hook.

- **Change the preview page path** → [configure/settings.md](configure/settings.md)
- **Control who can view the library** → [permissions/permissions.md](permissions/permissions.md)
- **How the page discovers and renders components (theme hook + template)** → [theme/component-preview.md](theme/component-preview.md)

Key facts:
- Preview route: `sdc_component_library.component_list`, default path `/sdc-component-library`, controller `\Drupal\sdc_component_library\Controller\ComponentsController::content`.
- Config object `sdc_component_library.settings`, single key `path`; changing it rebuilds routes so the page moves to the new path.
- Permission: `access sdc component library` (settings form uses core `administer site configuration`).
- Theme hook `component_preview` (variable `components`); template `templates/component-preview.html.twig`.
- Libraries `sdc_component_library/components_preview` and `sdc_component_library/axe_core`.
- Controller dependencies: `@plugin.manager.sdc` (core `ComponentPluginManager`) and `@theme.manager`.
