<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Plugin Example (batch_plugin_example) — agent index

Demonstration sub-module of **batch_plugin** (dependency `batch_plugin:batch_plugin`). Four example
batch plugins in `src/Plugin/BatchPlugin`. No routes, permissions, config, services, or schema —
pure reference code. Package `Batch Plugin`. Core `^10 || ^11`. GPL-2.0-or-later. Version 2.0.9
(dir `2.0.x`). In practice also needs core `node` (all four) and `taxonomy` (the complex one).

## The four plugins

| id | Class | `processors` | Notes |
|---|---|---|---|
| `example_batch_plugin` | `ExampleBatchPlugin` | default (`batch_api,cron,queue`) | Lists all nodes; records title into results; `finished()` reports count. |
| `example_drush_batch_plugin` | `ExampleDrushBatchPlugin` | `drush` | Same job, Drush only. |
| `example_cron_batch_plugin` | `ExampleCronBatchPlugin` | `cron,queue` | `cronexpression: '*/5 * * * *'`; logs each node title via `\Drupal::logger`. |
| `example_batch_plugin_from_config` | `ExampleBatchPluginComplex` | default | Configurable (pick node bundles); custom callback; nested append over taxonomy terms. |

## What each demonstrates

- **`ExampleBatchPlugin`** — the minimum: `setupOperations()` = `\Drupal::entityQuery('node')
  ->accessCheck(TRUE)->execute()`; `processOperation($payload, &$context)` loads the node and writes
  `$context['message']` / `$context['results']['nodes']`; `finished()` messages a count.
- **`ExampleDrushBatchPlugin`** — identical body, `processors: 'drush'` — shows restricting a plugin
  to one processor.
- **`ExampleCronBatchPlugin`** — `processors: 'cron,queue'` + `cronexpression` attribute; runs from
  `hook_cron()`/queue and logs rather than messaging.
- **`ExampleBatchPluginComplex`** — injects `entity_type.bundle.info`; `defaultConfiguration()` adds
  `node_bundles`/`term_bundles`; `buildConfigurationForm()` calls `parent::` then adds a bundle
  `checkboxes`; `submitConfigurationForm()` sanitises them; `setupOperations()` sets a custom
  `operationCallback = 'processNodeOperation'` and filters nodes by bundle; `processNodeOperation()`
  finds each node's referenced taxonomy terms and calls `appendOperations($terms, $context,
  'processTermOperation')` to spawn a **nested** batch; `finished()` reports node and term counts.

## Run them

```bash
drush en batch_plugin_example -y
drush batch_plugin:process example_batch_plugin batch_api
drush batch_plugin:process example_drush_batch_plugin
```

Or enable `batch_plugin_entity` and add/process any of them from
`/admin/structure/batch-plugin`.

Framework reference → [../../../../agent/plugins/writing-batch-plugins.md](../../../../agent/plugins/writing-batch-plugins.md)
