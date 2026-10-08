<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component blocks turns a theme's **UI Patterns** components into Layout Builder blocks whose variables are filled from the host entity's fields (through a field formatter) or from a fixed string with token support, so a designed component can be dropped into a layout and wired to real content instead of retyped values.

---

UI Patterns 1.x declares reusable components (a Twig template plus named `fields`, optional `variants`, `settings` and `libraries`) in `*.ui_patterns.yml`; Layout Builder places configurable blocks. This module bridges them: a block deriver (`ComponentBlockBlockDeriver`) creates one block plugin per component × content entity type — plugin id `component_blocks:<entity_type_id>:<pattern_id>` — each carrying an `entity` context. The block's configuration form (`ComponentBlock::blockForm`) lets an editor map every component field either to an entity field (choosing a formatter) or to a fixed/token string, and pick a variant; at render time `build()` renders each mapping and hands the results to UI Patterns' `#type => pattern` element, attaching the component's libraries. Fields marked `ui: false` are locked to their declared default. There is no settings page — all configuration is per placed block — and the module adds a `block__bare` markup suggestion outside Layout Builder plus a `field__component_block` theme hook for field output. Dependencies are core `block` and `layout_builder` plus `ui_patterns`, with the composer constraint pinning **`drupal/ui_patterns ^1.0`** (UI Patterns 1.x; 2.x is a different, SDC-aligned architecture — a UI Patterns 2 site needs a different bridge). Core requirement is `^9.0 || ^10.0 || ^11`.

---

- Place a design-system component in Layout Builder.
- Fill a component's fields from entity fields.
- Avoid retyping content into an inline block.
- Reuse theme components as configurable blocks.
- Keep component markup in the theme, content on the entity.
- Choose a field formatter per component field.
- Use a fixed string with tokens for a component field.
- Render a card component from node fields.
- Map a node's body field to a component slot with a text formatter.
- Select a component variant per placement.
- Expose ui_patterns_settings pattern settings on the block.
- Lock a component field to a default with `ui: false`.
- Build a landing page from components and real content.
- Reuse one component across multiple content types.
- Wire a hero component to a node's title, body and media.
- Reduce bespoke custom block plugins.
- Attach a component's asset libraries automatically.
- Render a component without block chrome outside Layout Builder.
- Support a UI Patterns 1.x design system.
- Rebuild cache to discover newly defined components as blocks.
