<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Strikethrough Options is a field widget that displays radio-button or checkbox options struck through in one of four colors.

---

The widget (`StrikethroughOptionsWidget`, extending core `OptionsWidgetBase`) applies to boolean, entity_reference(_revisions) and list_(integer|float|string) fields. It adds a `strikethrough-options-check` class plus a color class (a `strikethrough_color` widget setting: black, red, green, or blue), with the visual styling supplied by the module's CSS library. Configure it on a field's form display (Manage form display) by selecting the "Check boxes/radio buttons - Strikethrough" widget and choosing the color.

There is no routing, permissions, or server-side logic beyond the widget rendering — it is a presentational field widget only, with no security surface.

---

- Show list-field options with a strikethrough style.
- Strike out radio-button options.
- Strike out checkbox options.
- Choose black strikethrough color.
- Choose red strikethrough color.
- Choose green strikethrough color.
- Choose blue strikethrough color.
- Apply the widget to a list_string field.
- Apply the widget to a list_integer field.
- Apply the widget to a list_float field.
- Apply the widget to a boolean field.
- Apply the widget to an entity_reference field.
- Select the widget on Manage form display.
- Visually indicate deprecated or unavailable choices.
- Highlight struck options via the bundled CSS.
- Keep native options behavior while restyling.
- Preselect a single required option automatically.
- Use consistent option styling across forms.
- Signal crossed-out choices to content editors.
- Style multi-value checkbox groups.
