<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field States UI — agent index

Exposes Drupal's form **States API** (`#states`) in the Manage form display UI. Add states
(visible, required, …) to a field's widget; they are stored as a **third-party setting** on the
widget component in the `entity_form_display` config entity. No central settings page
(`configure: null`), no own permissions, no Drush.

- **Add/read a field state on a widget; storage shape; states & comparisons** →
  [configure/field-states.md](configure/field-states.md)
- **The `FieldState` plugin type — implement a custom state** →
  [plugins/field-state.md](plugins/field-state.md)

Key facts:
- Built-in state ids: `visible`, `invisible`, `required`, `optional`, `enabled`, `disabled`,
  `checked`, `unchecked`, `expanded`, `collapsed` (`Plugin\FieldState\*`).
- Storage: `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.field_states_ui.field_states` = list of
  `{id, data:{target, comparison, value}, uuid}`.
- Plugin manager service: `plugin.manager.field_states_ui.fieldstate` (`FieldStateManager`),
  annotation `@FieldState`, base `FieldStateBase`, interface `FieldStateInterface`.
- Applied via `hook_field_widget_complete_form_alter()` → manager builds the `#states` array.
