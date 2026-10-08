Demonstration sub-module with four example batch plugins showing the Batch Plugin framework.

---

Batch Plugin Example ships four reference batch plugins that exercise the framework's main patterns. `example_batch_plugin` (`ExampleBatchPlugin`) is the minimal case: `setupOperations()` queries all node IDs, `processOperation()` loads each node and records its title, and `finished()` reports a count — runnable via Batch API. `example_drush_batch_plugin` is the same job restricted to the `drush` processor. `example_cron_batch_plugin` restricts to `cron,queue` and carries a `*/5 * * * *` cron expression, logging each node title. `example_batch_plugin_from_config` (`ExampleBatchPluginComplex`) adds a configuration form to pick node bundles, uses a custom `processNodeOperation` callback, and calls `appendOperations()` to spawn a nested batch over each node's referenced taxonomy terms. It depends on `batch_plugin` (and, in practice, core `node`/`taxonomy`). Use it to learn or copy the patterns; it is not meant to run in production.

---

- Learn the minimum a batch plugin needs: `setupOperations()` + `processOperation()`.
- See how to query entity IDs into `$this->operations` with an access-checked entity query.
- See how to write progress messages (`$context['message']`) and results (`$context['results']`).
- See a `finished()` completion callback that summarises results to the user.
- Run the basic example via Batch API from `drush batch_plugin:process example_batch_plugin batch_api`.
- Run a plugin restricted to Drush with `drush batch_plugin:process example_drush_batch_plugin`.
- See how the `processors` attribute limits a plugin to specific execution mechanisms.
- See a cron/queue plugin with a `cronexpression` attribute (`*/5 * * * *`).
- Observe cron logging behaviour by watching the example cron plugin write node titles to the log.
- Learn how to add a configuration form to a batch plugin (`buildConfigurationForm()` + `submitConfigurationForm()`).
- Filter operations by a configured value (node content types) in `setupOperations()`.
- Use a custom operation callback name instead of the default `processOperation`.
- Build a nested/recursive batch with `appendOperations()` (nodes → their taxonomy terms).
- Pass context between a parent operation and appended operations via `$previousContext`.
- Drive the complex example from the UI by enabling `batch_plugin_entity` and adding it.
- Copy any of the four classes as a starting point for a real batch plugin.
