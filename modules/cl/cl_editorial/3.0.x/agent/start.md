<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Libraries: Editorial (cl_editorial) — agent index

A **developer toolkit** for low-code UIs around Single Directory Components (SDC). No end-user
config (`configure: null`), no permissions, no Drush, no routes. You consume its API from your own
module. Bundles the **sdc_tags** submodule.

- **The API surface: `cl_component_selector` element, `NoThemeComponentManager`, `cl_editorial_component_mappings_form()`, `ComponentFiltersFormTrait`, `Util`** →
  [api/toolkit.md](api/toolkit.md)
- **Theme hooks, templates, and the bundled `cl_editorial:component-card` SDC** →
  [theming/theme.md](theming/theme.md)

Submodule docs: `modules/sdc_tags/3.0.x/agent/start.md` (component tagging + a `component_tag`
plugin type + config UI).

Key facts:
- Services: `Drupal\cl_editorial\NoThemeComponentManager` (decorates `plugin.manager.sdc`),
  `cl_editorial.form_generator` (`SchemaForms\Drupal\FormGeneratorDrupal`).
- No plugin types of its own; it *provides* a Form API element and *consumes* SDC.
- Depends on core `serialization`; props-form generation needs the `SchemaForms`/`Shaper` libs.
