# Theming

`hook_theme` (via `Hook/ThemeHooks`) registers three theme hooks:

| Theme hook | Template | Variables |
|---|---|---|
| `webform_workflows_element` | `templates/webform-workflows-element.html.twig` | render element (`element`) — the workflow widget on the submission form |
| `webform_workflows_element_value` | `templates/webform-workflows-element-value.html.twig` | `element`, `values`, `color_class` — the read-only state display |
| `webform_handler_workflows_transition_email_summary` | `templates/webform-handler-workflows-transition-email-summary.html.twig` | `settings`, `handler` — the email handler summary row |

## Colour classes for states

`preprocessWebformWorkflowsElementValue()` sets `color_class = 'with-color <css-class>'` from
`WebformWorkflowsManager::getColorClassForState()`, using the colour chosen for the state. The available
colours come from `webform_workflows_element.settings` `ui.color_options` (newline `Label|css-class`
list; default install ships blue/green/red/orange/yellow/purple/gray/black/white in normal + dark
variants, e.g. `webform-workflow-color-green`).

The library `webform_workflows_element/default_colors` (`css/colors.default.css`) provides the default
styling for those classes. Override colours by editing `ui.color_options` and/or providing your own CSS
for the `webform-workflow-color-*` classes.

## JS libraries

- `webform_workflows_element.states` — depends on `webform/webform.state` (conditional element states).
- `webform_workflows_element.ui`, `.edit_element`, `.filters` — small jQuery UI helpers for the element
  widget, the element edit form, and the submission results filters.
