<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Grid Widget provides an options selection widget (check boxes and radio buttons) with CSS-grid layout options, for text, numeric and entity reference fields, so allowed-value selections can be laid out in styled grids instead of a plain vertical list.

---

The module registers an `OptionsGridWidget` field widget plugin that extends the core options widget and adds grid layout settings (columns/styling driven by the module's CSS and libraries). It applies to list/text, numeric and entity reference fields that expose a fixed set of allowed values, rendering the choices as a responsive grid of checkboxes or radios.

This is a form/display-layer widget. It changes how field options are presented on entity edit forms; it does not add access control or alter which values a user may set beyond the field's own allowed-values constraints. Content access and field access are unchanged.

---

- Render field options as a CSS-grid of check boxes or radio buttons.
- Style allowed-value selections instead of a plain list.
- Apply to list/text fields with allowed values.
- Apply to numeric fields with allowed values.
- Apply to entity reference fields.
- Lay out many options in multiple columns.
- Provide a responsive grid selection UI.
- Configure grid styling through the widget settings.
- Improve usability of long option lists on edit forms.
- Support single-select (radios) and multi-select (checkboxes).
- Reuse the core options widget behavior underneath.
- Attach the module's grid CSS library automatically.
- Keep field allowed-values constraints intact.
- Offer a nicer editorial selection experience.
- Replace the default options_buttons widget where grids are wanted.
- Configure per field instance in Manage form display.
