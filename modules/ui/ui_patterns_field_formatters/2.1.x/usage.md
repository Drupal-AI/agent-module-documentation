<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Field Formatters lets a Drupal field be displayed through a UI Patterns (1.x) component, so field values render into a reusable design-system pattern instead of a custom field template.

---

The module adds two field formatters, "Pattern (one for all)" and "Pattern (one for each)", available on every field type from a display's Manage display screen (and in Layout Builder). You pick a pattern and, optionally, a variant, then map field properties onto the pattern's fields: meta sources such as the field label or the field's normally formatted output, and raw sources such as each stored property (value, uri, title, referenced-entity label, and so on). "One for all" renders every field item into a single pattern instance; "one for each" renders each item into its own instance and is offered only on multi-value fields. It requires the UI Patterns and Field Formatter modules, exposes no settings page, and stores its configuration per field in the entity view display.

---

- Render a field through a UI Patterns component.
- Use a design-system pattern as a field formatter.
- Map a field's label and value onto pattern props.
- Display a multi-value field as one pattern per item.
- Display all items of a field in a single pattern.
- Feed the field's formatted output into a pattern slot.
- Map an entity-reference field's label into a component.
- Render a link field's URL through a pattern.
- Reuse an atomic-design component library for field display.
- Avoid writing custom field.html.twig templates.
- Pick a pattern variant per field display.
- Build a card component from a field's properties.
- Standardise field markup across content types.
- Combine field raw properties into one component.
- Show a field label plus value inside a pattern.
- Format fields consistently with a shared component set.
- Wrap a core formatter's output in a pattern (via Field Formatter).
- Use processed (formatted) text as a pattern field.
- Drive field display from configuration, not theme code.
- Extend the mappable sources with a custom field_properties source plugin.
- Apply patterns to fields inside Layout Builder.
- Migrate legacy pattern_formatter settings to the current formatters.
- Hide a mapped property from the pattern with the _hidden destination.
- Theme reference and media fields through shared components.
