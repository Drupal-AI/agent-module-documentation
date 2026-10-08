<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Field Group lets a **field group** be rendered by a UI Patterns **component** (an SDC), so a group of fields is output through a design-system component instead of a generic fieldset or div.

---

Field Group solves arrangement — these fields belong together — and normally renders the grouping with one of its own generic HTML formatters. UI Patterns 2.x (the Component API layer over Drupal's Single Directory Components) solves componentisation: a component declares named **slots** and typed **props**, and *sources* supply their values. This module joins the two by adding a field-group formatter, **`component_formatter`** (label "Component"), available on entity **view** displays. When a group uses it, the group's edit form embeds the full UI Patterns component picker: you choose a component, a variant, and fill each slot/prop from any available source. Two dedicated sources ship with the module: **`field_group_child`** maps one of the group's own children (a field, extra field, or nested group) into a slot, and **`field_group_label`** feeds the group's label into a slot or string prop (escaped, or admin-filtered when `label_as_html` is on). At render time `preRender()` turns the group into a `#type => component` renderable, passing the entity, entity type, bundle, the group config and the group's built render array as source contexts. The whole module is tiny — one formatter, two sources, one `EntityFinder` helper — with no routes, permissions, or global settings. The dependency line is load-bearing: `ui_patterns (>=2)`, i.e. UI Patterns **2.x**, a substantially different architecture from 1.x; a 1.x site needs the bridge that ships inside the `ui_patterns` project instead. This release is **2.0.0-beta1** (beta), core range `^9 || ^10 || ^11`.

---

- Render a field group through an SDC / UI Patterns component.
- Wrap a set of related fields in a card component.
- Map one grouped field into a specific component slot.
- Feed a field group's label into a component slot or heading prop.
- Reuse a theme's or component module's SDC components from Manage Display.
- Avoid writing a preprocess function per field grouping.
- Keep field arrangement and component choice together in one display config.
- Pick a component variant per group (e.g. "first" vs "second").
- Build a media object (image + body) from grouped fields.
- Standardise component usage across bundles and entity types.
- Render an address group through an address component.
- Nest a component group inside another group.
- Give site builders access to the component library without code.
- Swap a component or variant without touching Twig templates.
- Export the component choice and slot mapping with the view display.
- Align Drupal's display layer with a Single Directory Components design system.
- Prototype component-driven display from the admin UI.
- Fill component props from entity/field data via UI Patterns sources.
- Reduce bespoke theming for common, repeated groupings.
- Migrate a UI Patterns 1.x pattern-formatter setup to the 2.x Component API.
