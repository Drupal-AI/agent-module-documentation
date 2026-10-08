# Workflow buttons — agent index

Replaces the Content Moderation **moderation_state select + Save button** with one submit button
per allowed transition (labelled from the transition name). Requires `workflows` +
`content_moderation`. Ships a config schema; **no permissions, no Drush.**

- **Enable the widget, the global settings, and the widget settings** →
  [configure/settings-and-widget.md](configure/settings-and-widget.md)
- **Alter the target state before save (`hook_workflow_buttons_state_alter`)** →
  [hooks/state-alter.md](hooks/state-alter.md)
- **Template variables, button classes, top/bottom placement, delete styling** →
  [theming/templates.md](theming/templates.md)
- **Trash (soft-delete) submodule** → `../../modules/workflow_buttons_trash/1.0.x/agent/start.md`

Key facts:
- Field widget id **`workflow_buttons`** (for the `moderation_state` field). Set it on a bundle's
  *Manage form display*. The module also makes it the moderation_state default via
  `hook_entity_base_field_info_alter`.
- Global config **`workflow_buttons.settings`** → `display.top_buttons` (bool): also render the
  buttons at the top of the form. UI route `workflow_buttons.settings` at
  `/admin/config/workflow/workflow-buttons` (permission `administer site configuration`).
- Widget setting **`show_current_state`** (bool): show the current state in the form meta section.
  Schema `field.widget.settings.workflow_buttons`.
- Each button gets class `workflow-buttons-<transition_id>`; a `publish` transition / first button
  stays primary; a `delete` transition renders as a danger/trash button (library
  `workflow_buttons/delete-button`).
- Entity builder `WorkflowButtonsWidget::updateStatus` applies the clicked button's
  `#moderation_state`, first invoking `hook_workflow_buttons_state_alter`.
- Node templates get `current_revision_state` / `latest_revision_state` variables.
