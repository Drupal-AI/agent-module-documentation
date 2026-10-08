<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Layout Builder makes every UI Patterns pattern usable as a Layout Builder layout, mapping each pattern field to a Layout Builder region so editors can drop blocks into a component's slots.

---

This is a thin glue module between `ui_patterns` and core `layout_builder`. `hook_layout_alter` iterates the registered pattern definitions and, for each `pattern_<id>` layout, copies the pattern's `icon_map`/`icon_path` and re-points the layout plugin class to `PatternLayoutBuilder` (a subclass of `ui_patterns_layouts`' `PatternLayout` that exposes region names/regions and injects `#layout` into the build). A `hook_module_implements_alter` forces this module's `layout_alter` to run last so `ui_patterns_layout` has already registered the base layouts. `hook_element_info_alter` adds a `#pre_render` callback (`PatternLayoutBuilder::processLayoutBuilderRegions`, a trusted callback) to the `pattern` render element: after Layout Builder has populated each region as a renderable array, the callback reassigns those region children onto the pattern's `#<field>` variables and moves region `#attributes` into `#region_attributes`, so the pattern template receives block content in the right slots. `hook_entity_view_alter` attaches layout context (entity type, bundle, view mode, entity, delta) to each `PatternLayout` child, and `hook_theme_registry_alter` adds a `region_attributes` variable to every pattern theme hook. There is no configuration UI, no permissions and no schema; you simply enable it (with a layout-discovery module such as `ui_patterns_layout`) and patterns appear in the Layout Builder layout selector. Note this 1.x release targets the UI Patterns 1.x API.

---

- Use a design-system pattern as a Layout Builder section layout.
- Drop blocks into a pattern's named slots (regions) via the Layout Builder UI.
- Reuse existing UI Patterns components in entity Layout Builder displays without new code.
- Expose a card/grid/hero pattern's fields as arrangeable Layout Builder regions.
- Pick component-based layouts from the standard "Add section" layout list.
- Show each pattern's icon in the layout selector via its `icon_map`/`icon_path`.
- Pass entity context (type, bundle, view mode, id) into a pattern rendered as a layout.
- Apply per-region HTML attributes to pattern slots through `region_attributes`.
- Keep a single source of truth for components shared between fields and layouts.
- Let site builders compose pages from branded components instead of raw HTML layouts.
- Combine Layout Builder's drag-and-drop with a maintained pattern library.
- Render nested block content inside a pattern template's designated placeholders.
- Support quick-edit by preserving region keys on the rendered pattern.
- Avoid writing custom `Layout` plugins for each component.
- Ensure component layouts register after base pattern layouts for correct overrides.
- Standardise editorial page building around approved components.
- Migrate ad-hoc Layout Builder markup toward a consistent component system.
- Provide accessible, consistent section structure driven by the pattern definitions.
- Let themers control slot wrappers through the pattern's Twig template.
- Bridge a legacy UI Patterns 1.x component set into Layout Builder.
