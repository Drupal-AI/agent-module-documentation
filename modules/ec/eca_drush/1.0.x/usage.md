ECA Drush Integration adds one ECA action plugin that runs a chosen Drush command with arguments from inside an ECA model.

---

ECA Drush Integration extends the ECA (Event-Condition-Action) module with a single configurable action plugin, "Execute Drush command" (`eca_drush_simple_execute_drush_command`). When an ECA model reaches this action, the module locates the site's Drush executable, builds the command from a configured command name plus a free-text arguments string, and runs it as a Symfony Process subprocess with the Drupal root as the working directory. The action's configuration form auto-discovers the available Drush commands by running `drush list --format=json`, groups them by namespace, and presents them in a select list; a `--uri=` argument is detected and forwarded as the `DRUSH_OPTIONS_URI` environment variable. Command output is written to the module logger on success, and failures are logged as errors. It requires the ECA module and `drush/drush >= 13.0.0`, and targets Drupal core `^11.1`.

---

- Run any site Drush command as a step in an ECA automation model.
- Trigger `cache:rebuild` (cr) automatically after a specific content or config change.
- Kick off `queue:run` for a named queue from within a model.
- Run `cron` on demand as part of an ECA-driven workflow.
- Invoke `config:import` or `config:export` from an automated model.
- Trigger a `sql:dump` / backup command in response to a model event.
- Run `search-api:index` to reindex after content updates.
- Fire `pm:list` or other reporting commands and capture output to the log.
- Execute `user:role:add` / `user:role:remove` as part of an onboarding model.
- Run `updatedb` (updb) as a scheduled maintenance step.
- Chain Drush maintenance tasks behind ECA conditions and events.
- Pass extra options through the free-text arguments field (e.g. `--yes`, `--format=json`).
- Forward a site URI to Drush via a `--uri=` argument for multisite contexts.
- Select the target command from an auto-generated, namespace-grouped list in the UI.
- Automate command-line operations without writing a custom Drush command or hook.
- Bridge ECA's event/condition logic to CLI-level site operations.
- Log Drush command output centrally through Drupal's logging channel.
- Let non-developer model authors reuse existing Drush commands inside no-code workflows.
- Combine with other ECA actions (entity CRUD, email) so a workflow ends with a Drush step.
- Schedule recurring Drush operations by pairing the action with an ECA cron/timer event.
- Rebuild caches or run maintenance after a deployment-related model event.
