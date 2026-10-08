<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Views Select — agent index

Adds two field widgets that render a **View-backed entity-reference field** as a select list or
as checkboxes/radio buttons, using the View's own row output as each option's label. No settings
page, permission, service, or plugin type. Requires `field` + `views`.

- **Assign and configure the widgets on a field (Manage form display), settings, mechanics** →
  [configure/widgets.md](configure/widgets.md)

Key facts:
- Widgets (field type `entity_reference`, both `multiple_values`):
  - `erviews_options_select` — "Entity Reference Views Select list" (has an `empty_value` setting,
    default "- None -").
  - `erviews_options_buttons` — "Entity Reference Views Check boxes/radio buttons".
- Both extend core `OptionsWidgetBase`. They only do the special rendering when the field's
  reference method (`handler`) is `views`; otherwise they fall back to standard select/checkbox.
- Stored as the widget `type` of the field's component in the bundle's `entity_form_display`
  config (`core.entity_form_display.<entity>.<bundle>.<mode>` → `content.<field>.type`).
- Provides a config schema for the two widget settings; nothing else.
