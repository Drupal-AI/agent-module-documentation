<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds field formatters that render any field's value through an SDC component instead of a stock template. Part of UI Patterns 2.x.

---

This submodule of `ui_patterns` provides two field formatters — `ui_patterns_component` (renders the whole field into one component) and `ui_patterns_component_per_item` (renders each field item into its own component) — and a `ui_patterns_source` formatter. A `hook_field_formatter_info_alter()` widens the two component formatters so they apply to **every** field type, letting a site builder pick "Component (UI Patterns)" or "Component per item (UI Patterns)" on any field in Manage Display and map the field's data into the component's props and slots via Source plugins. The choice is stored in `core.entity_view_display.*` under the field component's `settings.ui_patterns` array (`component_id`, `variant_id`, `props`, `slots`). It is the most common way to consume components on entity displays.

---

- Render an entity reference field as a card/teaser component
- Render each item of a multi-value field as its own component
- Turn a field's value into a component slot (title, content, image)
- Feed a component prop from a field property using an entity-field source
- Replace a bespoke field-formatter module with a component
- Apply different components to the same field across view modes
- Map a link field into a component's `links` prop
- Wrap a field in a design-system component without editing Twig
- Configure a component `variant` per field display
- Render a taxonomy/term reference as a badge component
- Show a media field through a media-card component
- Standardize how one field looks across content types via a shared component
- Feed a component prop from a token like `[node:title]` on the field display
- Render a datetime field into a formatted date component
- Wrap a numeric field in a stat/metric component
- Use `ui_patterns_component` to render an entire multi-value field as one component
- Drive component wrapper attributes from a class/attribute source on the field
