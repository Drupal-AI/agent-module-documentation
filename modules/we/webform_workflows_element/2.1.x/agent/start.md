# Webform Workflows Element — agent index

Ties Webform submissions into core Workflows: add a `webform_workflows_element` element to a form,
bind it to a workflow, and move submissions through states with per-transition/per-state access,
logging, transition emails, and Views/Maestro integration. Depends on `workflows` + `webform` (^6.3).
Config schema provided; **no permissions of its own, no Drush, no new plugin types** (it *implements*
several plugins). `configure` in info.yml is null; global config lives at a webform config subpath.

- **End-to-end setup (create workflow, add element, per-transition/state access, admin email config,
  colour options) + all config objects/routes** → [configure/setup.md](configure/setup.md)
- **The plugins it implements: WorkflowType, WebformElement, WebformHandler (email), Action** →
  [plugins/plugins.md](plugins/plugins.md)
- **`webform_workflows_element.manager` service, the transition event, workflow tokens** →
  [api/api.md](api/api.md)
- **The three access/note alter hooks (`webform_workflows_element.api.php`)** →
  [hooks/hooks.md](hooks/hooks.md)
- **Templates, `hook_theme`, colour classes/CSS** → [theming/theming.md](theming/theming.md)

Submodules (own docs):
- `webform_workflows_element_views` (Views state filter) →
  [../../modules/webform_workflows_element_views/2.1.x/agent/start.md](../../modules/webform_workflows_element_views/2.1.x/agent/start.md)
- `webform_workflows_element_maestro` (Maestro engine tasks) →
  [../../modules/webform_workflows_element_maestro/2.1.x/agent/start.md](../../modules/webform_workflows_element_maestro/2.1.x/agent/start.md)

Key facts:
- Workflow type plugin id `webform_workflows_element` (states/transitions edited with core Workflows UI).
- Element type `webform_workflows_element`; stores `workflow_state`, `workflow_state_previous`,
  `workflow_state_label`, `transition`, `log_public`, `log_admin` in submission data.
- Access is enforced in `WebformWorkflowsManager` via Webform's access-rules manager plus
  `hook_webform_submission_access` — configured on the element's *Access* tab per transition/state.
- Routes: `entity.webform.transition` (confirm form, `_custom_access`), `entity.webform.workflows_summary`
  & `webform_workflows_element.workflows_summary` (summary, `webform.update`),
  `webform_workflows_element.config.workflows` (admin email defaults, `administer webform`),
  `entity.webform.handler.add_workflow_email` (`webform.update`).
- Config objects: `webform_workflows_element.settings` (`ui.color_options`, `mail.default_body_text/html`).
