<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Plugin (batch_plugin) — agent index

A developer framework that wraps Drupal's four bulk-processing mechanisms — **Batch API, cron,
the Queue API, and Drush batches** — behind a single plugin type. Write one *batch plugin* and run
it unchanged through any of them by choosing a *processor*. Package `Batch Plugin`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 2.0.9 (dir `2.0.x`).

Composer requires `dragonmantank/cron-expression: ^3` (used for cron scheduling). No Drupal module
dependencies. Ships **no permissions of its own** and **no config schema** at the top level.

## Two plugin types it provides

- **Batch plugins** — discovery dir `src/Plugin/BatchPlugin`, interface
  `BatchPluginInterface`, base `BatchPluginBase`, attribute `#[BatchPlugin]` (legacy annotation
  also supported), manager service `plugin.manager.batch_plugin` (`BatchPluginManager`). You write
  these. → [plugins/writing-batch-plugins.md](plugins/writing-batch-plugins.md)
- **Processor plugins** — discovery dir `src/Plugin/Processor`, interface
  `ProcessorPluginInterface`, base `ProcessorPluginBase`, attribute `#[Processor]`, manager
  service `plugin.manager.batch_plugin_processor` (`ProcessorPluginManager`). Ships four:
  `batch_api`, `cron`, `queue`, `drush`. → [plugins/processors.md](plugins/processors.md)

## How to run a batch plugin

Directly (`$plugin->process()`), statically (`YourPlugin::processStatic()`), from `hook_cron()`
(auto-runs every plugin whose processors include `cron`), from the Drush command
`batch_plugin:process` (alias `bpp`), from the UI (sub-module `batch_plugin_entity`), or embedded
via the `#type => 'batch_plugin_config'` Form API element (`Element/BatchPluginConfig`).
→ [api/executing.md](api/executing.md)

## Services

- `plugin.manager.batch_plugin` — batch plugin manager (`getDefinitionsByType()` finds plugins by
  processor, including UI entities).
- `plugin.manager.batch_plugin_processor` — processor manager (`processBatchPlugin()`,
  `addBatch()`, `getProcessorOptions()`).
- `logger.batch_plugin_cron` (`Logger\BatchPluginCronLog`) — records cron/queue run windows and
  the running lock in table `batch_plugin_cron_log`.
- `batch_plugin.commands` — the Drush command (tagged `drush.command`).

## Storage (`hook_schema`, `batch_plugin.install`)

- `batch_plugin_cron_log` — per plugin/queue id: `start_time`, `end_time`, `uid`, `running` lock.
- `batch_plugin_queue_context` — per queue id: json-encoded `operations` and `context` carried
  across queue items.

## Sub-modules (documented separately)

- **batch_plugin_entity** — config entity + admin UI to create, configure and run batch plugins
  without code. → [modules/batch_plugin_entity/2.0.x/agent/start.md](modules/batch_plugin_entity/2.0.x/agent/start.md)
- **batch_plugin_example** — four demonstration batch plugins (Batch API, cron, drush, complex
  nested/config). → [modules/batch_plugin_example/2.0.x/agent/start.md](modules/batch_plugin_example/2.0.x/agent/start.md)

## Hooks

- `hook_cron()` in `batch_plugin.module` runs every `cron`-type batch plugin.
- Alter hooks: `batch_api_plugin_info` / `batch_plugin_definitions_alter` (batch plugins),
  `processor_info` (processors).
