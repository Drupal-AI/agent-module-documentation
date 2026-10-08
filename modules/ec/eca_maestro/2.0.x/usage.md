ECA Maestro adds ECA action and condition plugins that let ECA models drive the Maestro workflow engine — launching processes, completing and reassigning tasks, and reading or writing process variables.

---

ECA Maestro is a small integration module that connects the ECA (Events, Conditions, Actions) no-code automation engine to the Maestro business-process/workflow module. It ships eight action plugins and one condition plugin, all of which wrap static helpers on Maestro's `MaestroEngine`. Because every configuration field is resolved through ECA's token service, you can feed values from earlier steps of an ECA model (entity fields, prior process IDs, request data, etc.) straight into Maestro operations. Typical use is to trigger Maestro processes from Drupal events (node saved, form submitted, cron), to advance or complete interactive tasks as a side effect of other logic, and to move data between ECA tokens and Maestro process variables. The module has no admin UI, routes, permissions, services or config objects of its own — you use it entirely by adding its actions and conditions inside ECA models with the ECA modeller. It requires the ECA and Maestro projects (Maestro is pulled in via Composer; the declared module dependencies are `eca` and `eca_endpoint`, the latter supplying the request-action base class used by the "get queue ID from query" action).

---

- Launch a new Maestro process from a template when a node of a given type is created.
- Start a Maestro approval workflow when a webform or contact-form submission arrives.
- Kick off a workflow from an ECA "cron" event to run scheduled business processes.
- Store the new process ID returned by "Maestro: new process" into an ECA token for later steps.
- Override the Maestro start task name (default `start`) when launching a process.
- Complete a Maestro interactive task programmatically as the current user once some condition is met.
- Auto-complete a task when an approving entity reaches a certain field value.
- Set a Maestro task status explicitly to active, success, cancel, hold or aborted.
- Cancel or place on hold a stuck task from an administrative ECA model.
- Reassign a Maestro production assignment to a different user by display name.
- Reassign a task to a role instead of an individual user.
- Read a Maestro process variable and place its value in an ECA token for use downstream.
- Write a Maestro process variable from an ECA token or computed value.
- Copy data from a saved entity into a running Maestro process's variables.
- Resolve the Maestro process ID that owns a given queue ID and store it in a token.
- Extract a `queueid` (or `queueid_or_token`) from the current request query into a token for ECA endpoint flows.
- Branch an ECA model based on whether a specific user is allowed to execute a specific task.
- Guard a "complete task" action with a "can user execute task" condition before acting.
- Chain: read queue ID from query, resolve its process ID, then read a process variable — all in one model.
- Build human-in-the-loop workflows where ECA handles side effects and Maestro tracks the task queue.
- Combine Maestro task completion with ECA notification actions (email/message) in a single model.
- Drive multi-step onboarding or editorial approval pipelines without writing custom PHP.
- Use tokens to make the same ECA model handle many templates, queue IDs or process IDs dynamically.
