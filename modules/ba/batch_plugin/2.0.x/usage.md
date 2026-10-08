Batch Plugin lets you write one plugin and run it unchanged as a Batch API job, a cron job, a queue, or a Drush batch.

---

Batch Plugin is a developer framework that collapses Drupal's four separate bulk-processing mechanisms (Batch API, cron, the Queue API, and Drush batches) behind a single plugin type. A batch plugin implements `setupOperations()` to build an array of serializable payloads and `processOperation($payload, &$context)` to handle each item; the module's *processor* plugins (`batch_api`, `cron`, `queue`, `drush`) take that same plugin and execute it through the chosen mechanism, so switching from an interactive Batch API run to a background queue or a scheduled cron job is a one-argument change and needs no rewrite. Plugins can be configurable (their own config form via the standard plugin-form methods), can append further operations mid-run for nested/recursive batches, and can carry serializable state between operations through a `persistable` array. Processing is triggered directly in code (`$plugin->process()` or `YourPlugin::processStatic()`), from the UI with the `batch_plugin_entity` sub-module, from `hook_cron()`, or from the `drush batch_plugin:process` command. Because processors are themselves plugins, custom execution strategies can be added by extending `ProcessorPluginBase`.

---

- Run a data-migration or bulk-update routine as a progress-bar Batch API job from a form submit handler with a few lines of code.
- Convert that same job to a background queue with no code change, just by selecting the `queue` processor.
- Schedule a plugin to run on cron using a cron expression (e.g. `*/5 * * * *` or `@daily`) via the `cron` processor.
- Trigger any batch plugin from the command line with `drush batch_plugin:process <plugin_id>` (alias `bpp`), optionally overriding the processor.
- Bulk-process every node (or a filtered subset by content type) and act on each, as shown by the `batch_plugin_example` plugins.
- Build nested batches: append a second wave of operations (e.g. taxonomy terms per node) while processing the first, via `appendOperations()`.
- Give site builders a UI to add, configure, enable/disable and run batch jobs without code, using `batch_plugin_entity` at `/admin/structure/batch-plugin`.
- Let editors choose which content bundles a batch should target through a plugin configuration form.
- Embed a batch plugin's configuration form inside your own settings form with the `#type => 'batch_plugin_config'` Form API element.
- Add a per-plugin processor selector so an administrator picks Batch API vs cron vs queue at configuration time.
- Carry state between operations (running totals, IDs already handled) using the `persistable` array that survives Batch API's static re-instantiation.
- Run a completion callback once all operations finish via the plugin's `finished()` method (post-processing, notifications, config writes).
- Implement recurring maintenance tasks (cache warming, index rebuilds, remote sync) as cron batch plugins with built-in due-time and running-lock handling.
- Queue one-off work items on demand with `Queue::addOperationToQueue()` without building a full batch.
- Restrict which processors a plugin may use through the attribute's `processors` list (e.g. `'cron,queue'` only).
- Hide internal plugins from the entity UI with the attribute's `hidden` flag.
- Add a custom processor (e.g. a rate-limited or externally dispatched runner) by extending `ProcessorPluginBase` and tagging it with the `#[Processor]` attribute.
- Alter discovered batch plugin or processor definitions through the `hook_batch_plugin_definitions_alter` / `hook_processor_info_alter` hooks.
- Log and inspect cron/queue execution windows through the `batch_plugin_cron_log` table (start/end time, running lock).
- Break a stuck running-lock so a cron/queue plugin can run again after an interrupted execution.
- Provide a table-select UI in a plugin config form via the `ConfigTableSelectTrait` for choosing rows to process.
- Use `getDefinitionsByType()` to discover all plugins (including UI-created entities) that run under a given processor.
- Ship a library of reusable, distributable batch operations as a module of batch plugins for other teams to enable and run.
