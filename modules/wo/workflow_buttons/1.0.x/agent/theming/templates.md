# Workflow buttons theming

## Button markup & classes

Buttons are built in `WorkflowButtonsWidget::processActions()` and placed in `form['actions']`
(clustered as a dropbutton). Each button:
- `#value` = the workflow **transition label**.
- `#attributes['class']` = `workflow-buttons-<transition_machine_name>` — target these in CSS.
- The first button and any `publish` transition keep `#button_type = 'primary'`.
- A `delete` transition renders as `#button_type = 'danger'` with classes `submit-trash
  action-link--danger` and a trash-icon prefix span; it attaches the
  `workflow_buttons/delete-button` library (`css/delete-button.css`) and relabels the core delete
  link to "Permanently delete".

## Top / bottom placement

Controlled by `workflow_buttons.settings:display.top_buttons`:
- Standard themes: a second copy is added as `form['actions_top']` (`#weight -900`).
- Gin admin theme (`form['gin_actions']` present): the actions are moved into Gin's sticky area;
  with `top_buttons` on, the extra set is added at the **bottom** (`form['actions_bottom']`,
  `#weight 900`) instead of the top.
On an entity-view/revision render (`$form_state->get('workflow_buttons')`), only one set is shown.

## Current-state display

When the widget's `show_current_state` is on, `processActions()` adds an item to `form['meta']`:
`current_moderation_state` (title "Moderation State"), shown inline in the form's meta section.

## Node template variables

`workflow_buttons_preprocess_node()` exposes two variables to `node.html.twig`:
- `current_revision_state` — the moderation state of the currently rendered node revision.
- `latest_revision_state` — the moderation state of the latest revision (set only when viewing the
  default revision while a newer non-default revision exists; otherwise empty).

Use them for status badges, e.g. `{% if latest_revision_state %}Pending: {{ latest_revision_state }}{% endif %}`.

## Pseudo-field

`hook_entity_extra_field_info()` exposes a `workflow_buttons` display component on moderated
bundles (hidden by default); `hook_entity_view()` renders it as an inline default-form so the
buttons can appear on the entity view page, not just the edit form.
