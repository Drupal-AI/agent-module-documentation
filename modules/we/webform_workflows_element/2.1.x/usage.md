Adds a Webform element that ties submissions into core's Workflows module, so each submission can be moved through workflow states (e.g. draft → review → approved) with per-transition, per-state access control, logging, notification emails, and Views/Maestro integration.

---

The module defines a core Workflows **workflow type** `webform_workflows_element` (its states/transitions are managed with core Workflows UI). You then add a **Webform element** of type `webform_workflows_element` to a form and bind it to one of those workflows; the element stores `workflow_state`, `workflow_state_previous`, `workflow_state_label`, the chosen `transition`, and public/admin log messages in the submission data. On the submission form it shows the current state and a select/buttons of the transitions the current user may perform. Access is fine-grained: the element's *Access* tab configures, per transition (`access_transition_<id>_*`) and per state (`access_update_at_state_<id>_*`), which roles/users/permissions may act — enforced through Webform's access-rules manager in `WebformWorkflowsManager` (`checkAccessForSubmissionAndTransition`, `checkAccessToUpdateBasedOnState`) plus `hook_webform_submission_access`. A dedicated confirm route (`entity.webform.transition`) performs a transition with a `_custom_access` callback; a summary controller (`entity.webform.workflows_summary`, gated by `webform.update` access) lists submissions by state. A `TransitionEventSubscriber` dispatches `WebformSubmissionWorkflowTransitionEvent` on each change. A Webform **handler** `workflows_transition_email` (extends core's email handler; label "Workflow transition email") sends an email when a configured transition fires, with default bodies configurable at `/admin/structure/webform/config/workflows` (`administer webform`) and workflow-specific tokens (`webform_workflow:transition-url` / `transition-link`, including secure-token variants for logged-out updates). A Webform **Action** `webform_workflow_transition` runs a transition in bulk over submissions. Tokens, theming (three Twig templates + colour options), and three access-alter hooks round it out. Two submodules add a **Views** state filter (`webform_workflows_element_views`) and **Maestro** engine tasks (`webform_workflows_element_maestro`). The module ships no permissions of its own and no Drush.

---

- Add an editorial workflow (draft → needs review → published) to Webform submissions.
- Build an approval queue where reviewers move submissions from "submitted" to "approved"/"rejected".
- Restrict who can perform each transition by role, user, or permission (per-transition access).
- Restrict who can edit a submission while it sits at a given state (per-state update access).
- Show submitters the current workflow state of their own submission.
- Require a log/comment message when performing certain transitions.
- Keep separate public and admin-only log messages against each state change.
- Email the submitter (or staff) automatically whenever a transition fires.
- Customise the default transition-email body (plain text and HTML) site-wide.
- Send transition emails only for specific transitions selected on the handler.
- Give reviewers a "Workflows summary" page listing submissions grouped by state.
- Let users update a submission's workflow via a secure-token link without logging in (webform token feature).
- Bulk-transition many submissions at once with the "Perform workflow transition" Action.
- Filter a View of submissions by workflow state (via the Views submodule).
- Drive submission transitions from a Maestro business-process template (via the Maestro submodule).
- React to transitions in custom code by subscribing to `WebformSubmissionWorkflowTransitionEvent`.
- Override transition/element access in custom code via the provided access-alter hooks.
- Use workflow tokens (transition URLs/links) inside emails or other webform messages.
- Colour-code workflow states in the UI using the configurable colour options.
- Model multi-stage intake processes (e.g. applications, support tickets, RFPs) on a single webform.
- Preset a transition via URL query so a link lands the user on the right transition.
- Track the previous state alongside the new state for auditing each change.
- Integrate submission workflows with existing Views-based dashboards.
- Add multiple workflow elements to one webform for parallel/independent state tracks.
