<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes every SDC component as a block plugin so components can be placed in regions or Layout Builder. Part of UI Patterns 2.x.

---

This submodule of `ui_patterns` derives a block plugin for each discovered SDC component (block plugin base id `ui_patterns`, deriver appends the component id, giving `ui_patterns:<theme_or_module>:<component>`, e.g. `ui_patterns:olivero:teaser`). Placing such a block — through Block Layout, Layout Builder, or programmatically — lets a site builder fill the component's props and slots from Source plugins, exactly like the field formatter. The configuration is stored on the `block.block.<id>` config entity under `settings.ui_patterns` (`component_id`, `variant_id`, `props`, `slots`). A second variant, `EntityComponentBlock`, exposes context (like the current entity) to the component's sources. This is how you turn design-system components into placeable page furniture.

---

- Place a design-system button/banner/card component in a theme region
- Add a component block to a Layout Builder section
- Fill a component's title/content slots with static text or tokens
- Feed a component prop from the current entity via an entity-aware block
- Build a marketing hero out of a component instead of a custom block module
- Reuse one component in multiple regions with different prop values
- Configure a component `variant` per block placement
- Constrain editors to schema-validated component fields when building blocks
- Place the same component on multiple pages via block visibility rules
- Compose a footer from several component blocks
- Render a menu or breadcrumb component as a block using menu/breadcrumb sources
- Swap bespoke block templates for portable SDC components
- Place an entity-aware component block that reads the current node's fields
- Build a call-to-action block from a component with a token-driven link
- Add a sidebar promo component block with a configurable variant
- Compose a homepage hero region from a single component block
- Give editors a schema-validated component instead of a free-form custom block
- Standardize card blocks across the site with one shared component
