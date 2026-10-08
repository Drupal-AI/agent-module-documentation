<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views field formatter adds a **"View"** field formatter that renders a chosen View (with the field's value/entity passed as contextual arguments) in place of the field's own value.

---

The module provides a single field formatter plugin (id `views_field_formatter`, label "View") that is available on almost every field type. Instead of printing the field value, you pick a View and display (`viewid::display`) in the formatter settings, and the formatter embeds that view via a `#type => 'view'` render element — passing the current field's value (and the host entity id) as contextual **arguments** so the view can react to the field being formatted. You choose which arguments are sent and in what order (a weighted, checkbox list of available arguments: the delta, the field value, the entity id, etc.), whether to render once per value or a single time, whether to hide the output when the view returns nothing (`hide_empty`), and — for multi-value fields — whether to render the view separately per value (`multiple`) and which character to join them with (`implode_character`). Everything is stored in the field's formatter settings on the `entity_view_display` config (schema `field.formatter.settings.views_field_formatter`), so it exports like any display config; the formatter declares a config dependency on the selected view. There is no settings page, permission, or Drush — it is a display-layer plugin that depends only on Views.

---

- Show a list of related content (a view) on an entity, keyed off one of its fields.
- Render a "more like this" view using the current node's field as the argument.
- Replace a taxonomy-term reference field's output with a view of content in that term.
- Display a user's authored content by passing the user id field as a contextual filter.
- Turn an entity-reference field into a rich rendered list via a view.
- Show aggregated data (counts, sums) computed by a view next to a field.
- Pass a field's raw value into a view as a contextual argument.
- Render a view once per value of a multi-value field (`multiple`).
- Join multiple per-value view outputs with a custom character (`implode_character`).
- Hide the field entirely when the embedded view has no results (`hide_empty`).
- Pick exactly which contextual arguments the view receives, and their order.
- Display a block-style view inline within an entity's field output.
- Build a "products in this category" listing from a category field.
- Show upcoming events filtered by a date field's value.
- Render a map/listing view seeded by a location field.
- Reuse an existing view as a field formatter without writing code.
- Present different views per view mode by configuring the formatter per display.
- Combine with any field type (string, entity_reference, list, number, date, etc.).
- Export the whole setup as display config for repeatable deployment.
- Drive a related-content sidebar from a single reference field.
- Show a filtered comment/review list keyed on the entity being viewed.
