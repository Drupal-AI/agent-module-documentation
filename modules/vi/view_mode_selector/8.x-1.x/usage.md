<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Mode Selector adds a field type that lets an entity carry its own chosen view mode, which then overrides how the entity is rendered.
---
The module provides a `view_mode_selector` field type (a 255-char varchar storing a view mode id) plus a placeholder view mode. When an entity with the field is rendered using the special `view_mode_selector` view mode, `hook_entity_view_mode_alter()` reads the stored value and swaps the active view mode to the one the editor picked (falling back to `default` when the field is empty or absent). `hook_entity_view_mode_info_alter()` lazily creates a `view_mode_selector` placeholder view mode for every entity type that has such a field, and the display-edit form for that placeholder is disabled with a notice, since it only stands in for the selected mode.

Editors choose the mode through one of three widgets: a Select list, Radio buttons, or Icons. The field settings form lists every view mode available for the bundle with an "enable" checkbox, an optional "hide title" flag, and a managed-file "icon" upload (stored under `public://view-mode-selector/<entity_type>`); the Icons widget renders those uploaded images as the radio labels. Only enabled view modes appear in the widget, unless none are enabled, in which case all are shown. The default formatter reuses core's text_default formatter to print the stored mode name.

Typical setup: add a View Mode Selector field to a bundle, enable the view modes editors may pick and optionally upload icons, pick a widget, then render the entity (or its reference/view row) with the `view_mode_selector` view mode so each entity displays in its per-entity selected mode. If the mode does not change as expected, check other modules implementing `hook_entity_view_mode_alter`, which may run afterwards and override it.
---
- Let editors choose per-entity how a node/entity is displayed
- Add a "View Mode Selector" field to any fieldable bundle
- Store a chosen view mode id directly on the entity
- Override the render view mode via the `view_mode_selector` placeholder mode
- Fall back to the `default` view mode when no selection is made
- Offer a Select list widget for compact view-mode choice
- Offer Radio buttons widget for view-mode choice
- Offer an Icons widget with uploaded preview images as labels
- Upload a custom icon per view mode for the Icons widget
- Restrict selectable modes by enabling only chosen view modes in field settings
- Show all view modes automatically when none are explicitly enabled
- Hide the title/label of a view mode in the widget via "hide title"
- Give content teams a visual layout/format switcher per item
- Vary teaser vs. full presentation on a per-node basis
- Drive view-row rendering from an editor-selected mode
- Reference-field displays that respect each entity's chosen mode
- Print the selected view mode name as text with the default formatter
- Auto-provision a placeholder view mode per entity type using the field
- Diagnose overridden modes by checking other hook_entity_view_mode_alter implementations
- Build editorial UIs where format is content, not code
