ECA (Events – Conditions – Actions) is a visual, no-code automation and orchestration framework for Drupal: you model workflows and business rules that react to events, evaluate conditions, and run actions without writing custom code.

---

ECA Core is the processing engine. It listens to Drupal events, matches them against **models** you build, evaluates the model's **conditions**, and executes its **actions**. Events, conditions, and actions are all plugins — ECA defines its own plugin types for events (`EcaEvent`) and conditions (`EcaCondition`) and decorates core's action plugin manager so every core/contrib action is usable too. Models are stored as `eca` configuration entities, so they import, export, and deploy through Drupal's standard config management or Drush. ECA Core ships no capabilities on its own; functionality comes from its many submodules (content, form, user, views, workflow, queue, cache, endpoint, log, etc.), and you build models with a separate visual modeler module (e.g. `bpmn_io`) surfaced by ECA UI at `/admin/config/workflow/eca`. It builds directly on Drupal's architecture — events, actions, queues, workflows, forms, tokens, and APIs — letting site builders replace bespoke glue code with transparent, maintainable, deployable workflows. It integrates with tokens for data passing and supports scheduled/cron-based triggers via the cron-expression library. It is the successor generation to the Rules module for modern Drupal.

---

- Automatically publish or unpublish content when a field value changes.
- Send an email when a node of a given type is created.
- Notify a Slack/webhook endpoint when content is updated.
- Assign a role to a user after they complete a profile.
- Run approval/moderation workflows on content state transitions.
- Validate or alter form submissions with no custom module.
- Set default field values dynamically on entity presave.
- Redirect users based on conditions after a form submit.
- Schedule recurring actions with cron expressions.
- Enqueue heavy work and process it from a queue.
- Create related entities automatically when one is saved.
- Clear specific caches when certain content changes.
- Log custom messages or watchdog entries from a workflow.
- Serve a custom URL endpoint whose response is built by a model.
- React to user login/logout/registration events.
- Grant or deny node access based on model logic.
- Trigger actions from Views results (iterate rows, export).
- Send notifications on content moderation state changes.
- Manipulate menu links programmatically.
- Respond to config import/export events.
- Build multi-step business rules visually via BPMN.
- Pass data between steps using tokens.
- Deploy automation models across environments as configuration.
- Replace legacy Rules module workflows on Drupal 10/11.
- Add HTMX-driven auto-polling regions and response headers.
- Extend ECA with custom event, condition, or action plugins.
- Orchestrate AI-powered processes (with AI integration modules).
- Enforce field-level or entity-level access rules declaratively.
- Rebuild the event subscriber cache after model changes via Drush.
