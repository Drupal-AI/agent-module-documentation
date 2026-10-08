<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns 2.x — agent index

Exposes core **SDC components** (`theme_or_module:component`, defined in `*.component.yml`
with `props` + `slots`) as configurable Drupal plugins. Values for props/slots come from
**Source plugins**. Delivery surfaces are the submodules (formatters, blocks, layouts,
views, field). The main module has **no config UI** (`configure: null`) and defines no
permissions — you use it through whichever submodule you enable.

- Config structure (block / field-formatter / layout settings, the `ui_patterns` array, slot & prop sources): [configure/components.md](configure/components.md)
- Plugin types it defines (Source, PropType, PropTypeAdapter, DerivableContext) + Source ids: [plugins/plugin-types.md](plugins/plugin-types.md)
- Write a custom Source plugin (feed new data into any component): [extend/source-plugin.md](extend/source-plugin.md)
- Services, Twig extension, alter hooks to call programmatically: [api/services-and-hooks.md](api/services-and-hooks.md)
- Submodules (what each one adds): see this module's `submodules` in data.json. Documented here: `ui_patterns_field_formatters`, `ui_patterns_blocks`, `ui_patterns_layouts` (nested under `modules/`).
