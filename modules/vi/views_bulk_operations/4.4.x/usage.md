Views Bulk Operations (VBO) adds a checkbox column and an actions dropdown to any View, letting users select rows (even across pages, or the entire result set) and run an action — delete, update, or any custom operation — on all of them at once.

---

VBO exposes a special Views field, "Views bulk operations", that renders per-row checkboxes plus a "select all"/"select all results" control and an action selector above the results. When a display is configured, the site builder chooses which actions are available, can preconfigure each action, and can require a confirmation step or a configuration step before execution. On submit, selected rows are handed to the chosen action plugin and processed either immediately or through the Batch API (with a configurable batch size), so operations scale to thousands of entities without timeouts. Actions are standard Drupal Action plugins extended by VBO's own `ViewsBulkOperationsActionBase`, which gives each action access to the full view, the selected result rows, and per-execution context. VBO ships delete and cancel-user actions, an event to alter the available action list, a Drush command to run a view's action from the CLI, and an optional Actions Permissions submodule for per-role, per-action access control. Selections are held in tempstore so they survive the multi-step (select → configure → confirm → execute) flow and multi-page AJAX selection. Because everything is driven by Views, any entity type or query exposed through Views can be bulk-processed.

---

- Bulk-delete selected nodes, users, taxonomy terms, or any entity listed in a View.
- Select every result across all pages ("select all results") and act on the whole set.
- Run an action on thousands of rows via the Batch API without PHP timeouts.
- Add a custom bulk action (e.g. "publish", "set field value") as an Action plugin.
- Publish or unpublish many content items in one operation.
- Cancel/block multiple user accounts from an admin user View.
- Preconfigure an action with fixed settings so editors just pick it and run.
- Add a per-execution configuration form (collect input before running the action).
- Require a confirmation step before a destructive bulk operation.
- Restrict which actions appear on a given View display.
- Gate each action per role using the Actions Permissions submodule.
- Execute a View's action from the command line with `drush vbo-execute`.
- Schedule bulk processing via cron by calling the Drush command.
- Build a moderation queue View with approve/reject bulk actions.
- Mass-assign taxonomy terms or authors to selected content.
- Bulk-update a field value across filtered content.
- Alter the list of available actions programmatically via VBO's action-definitions event.
- Process results in a custom order or with a custom batch size.
- Return per-row result messages/counts from an action's `execute()`.
- Redirect the user somewhere specific after a batch finishes.
- Provide bulk operations on a custom entity type exposed through Views.
- Combine exposed filters with bulk actions to target a precise subset.
- Act on view rows that are not entities by reading raw result rows in the action.
- Persist a selection across multi-page AJAX navigation before executing.
- Give a decoupled/admin dashboard mass-action buttons backed by a View.
- Localize/translate-aware deletion of specific entity translations.
- Limit an action to a single entity type via the plugin `type` property.
