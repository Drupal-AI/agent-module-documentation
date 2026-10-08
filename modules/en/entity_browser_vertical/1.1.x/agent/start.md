<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser Vertical — agent index

Adds one Entity Browser field-widget-display plugin, `entity_browser_vertical_label`
("Entity label, stacked vertically"), that renders the current selection of an Entity
Browser entity-reference widget as a vertical, drag-to-reorder list. No settings form, no
configure route, no permissions, no Drush, no plugin types of its own. Depends on
`entity_browser`.

- **Select the vertical display / where the choice is stored** →
  [configure/vertical-display.md](configure/vertical-display.md)
- **How the stacking works (plugin class + widget-alter hook + CSS)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the selection is a widget setting, not a third-party setting. In
`core.entity_form_display.<entity>.<bundle>.<mode>` the entity-reference component uses
widget `entity_browser_entity_reference` and its `settings.field_widget_display` is set to
`entity_browser_vertical_label`. The alter hook only fires for that widget type and that
display value.
