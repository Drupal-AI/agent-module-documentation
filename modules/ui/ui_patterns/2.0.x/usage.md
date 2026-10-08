<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns 2.x turns Drupal core's Single Directory Components (SDC) into plugins you can place and configure all over the site — as field formatters, blocks, layouts, Views styles, and field values — without writing render code.

---

UI Patterns 2.x builds on Drupal core's SDC system: it decorates the core `plugin.manager.sdc` component plugin manager and re-exposes every discovered `theme_or_module:component` as something site builders can use through the normal Drupal admin UI. Each component's `*.component.yml` schema (its `props` and `slots`) becomes a configurable form. The value fed into each prop or slot comes from a **Source plugin** (`ui_patterns_source`) — a small pluggable resolver such as a plain textfield, a token, a referenced entity field, a menu, a breadcrumb, or another nested component — so the same component can be driven by static text in one place and by live entity data in another. A **PropType plugin** (`ui_patterns_prop_type`) system validates and normalizes each value against the component's JSON-schema-typed prop (string, number, enum, links, attributes, slot, …), and **PropTypeAdapter** plugins bridge Drupal data structures (like `Attribute` objects or link lists) onto those schema types. The submodules are the delivery surfaces: `ui_patterns_field_formatters` (render a field as a component), `ui_patterns_blocks` (place a component as a block), `ui_patterns_layouts` (use a component as a Layout Builder / Display Suite layout), `ui_patterns_views` (component-based Views rows and styles), and `ui_patterns_field` (store a component as a field value). Nothing about your components changes — they remain standard, portable SDC — so a design system stays framework-agnostic while site builders wire it into content without a developer.

---

- Expose an existing SDC component (from a theme or module) to site builders with zero glue code
- Render an entity reference field as a card/teaser component with `ui_patterns_component_per_item`
- Render any field's value into a component slot via `ui_patterns_component`
- Place a design-system component (button, banner, card) as a block in a region
- Use a component as a Layout Builder section layout with configurable regions/slots
- Build Views listings whose rows or style are a repeatable component
- Feed a component prop from a token like `[node:title]`
- Feed a component slot from a referenced entity's rendered field
- Populate a component's menu/breadcrumb slot from the site's real menu or breadcrumb
- Configure a component's enum prop (e.g. a "variant") through a dropdown in the display form
- Map an entity's field to a component prop while keeping cacheability metadata intact
- Nest one component inside another component's slot as a source
- Give content editors a widget to pick and fill a component stored in a field (`ui_patterns_field`)
- Preview and browse all available components on a library page (`ui_patterns_library`)
- Migrate legacy UI Patterns 1.x `pattern` definitions onto SDC (`ui_patterns_legacy`)
- Standardize front-end markup across blocks, fields, and layouts using one component set
- Drive a component's HTML wrapper attributes from a class/attribute source
- Attach a component to an entity display without touching Twig templates
- Reuse the same component across multiple entity view modes with different sources
- Let a design system live in a theme while site builders consume it through the UI
- Replace bespoke field-formatter modules with a single component-driven formatter
- Compose page regions out of components instead of hand-written block templates
- Provide editors a constrained, schema-validated way to fill marketing components
- Keep prop values type-checked against each component's JSON schema at configuration time
- Add new Source plugins to expose new kinds of data (custom API, computed value) to any component
