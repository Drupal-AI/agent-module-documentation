<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Executing batch plugins

Five entry points. All ultimately call `ProcessorPluginManager::processBatchPlugin()`
(see [../plugins/processors.md](../plugins/processors.md)).

## 1. Directly, from an instance

```php
/** @var \Drupal\batch_plugin\BatchPluginInterface $plugin */
$plugin = \Drupal::service('plugin.manager.batch_plugin')->createInstance('my_batch');
$plugin->process();               // uses the plugin's default/first processor
$plugin->process('queue');        // override processor by id
$plugin->process($processorInstance); // or by instance
```

`BatchPluginBase::process($processor = NULL)` delegates to the processor manager, passing
`$this->helpfulData`. If you use the `batch_api` processor from a form submit handler, core shows the
progress bar; from other contexts you drive Batch API as usual.

## 2. Statically

```php
MyBatch::processStatic($helpfulData = NULL, $processor = NULL);
```

`processStatic()` reflects the class, reads the plugin id from its **annotation** (via
`SimpleAnnotationReader` over `Drupal\batch_plugin\Annotation`), creates the plugin, sets helpful
data, and processes. Throws if called on an abstract class or if no annotation/id is found — so the
target class must carry the `@BatchPlugin` annotation (not only the `#[BatchPlugin]` attribute).

## 3. Cron

`batch_plugin_cron()` (in `batch_plugin.module`) loads every batch plugin whose `processors` include
`cron` via `getDefinitionsByType('cron')`, creates a `cron` processor per plugin (queue id =
definition `queue_name`), and calls `processBatchPlugin()`. Actual item processing happens when the
core queue worker runs (deriver-created queue, `cron time = 90`). Due-time and running-lock are
enforced by the cron processor (see processors doc).

## 4. Drush

Command class `Drush/Commands/ProcessBatchPluginCommands` (service `batch_plugin.commands`, also a
legacy `Commands/ProcessBatchPluginCommands`):

```bash
drush batch_plugin:process <plugin_id> [<processor_plugin_id>]   # alias: bpp
```

`processor_plugin_id` defaults to `drush`. `DrushCommandsTrait::processPlugin()` validates that both
the batch plugin and processor ids exist, creates and processes the plugin, and if operations were
queued for Batch API/Drush calls `drush_backend_batch_process()`.

## 5. UI / embedded form element

- Sub-module `batch_plugin_entity` gives an admin UI (Structure → Batch plugins) to add, configure,
  enable and **Process** a plugin. →
  [../../modules/batch_plugin_entity/2.0.x/agent/start.md](../../modules/batch_plugin_entity/2.0.x/agent/start.md)
- Form element `#type => 'batch_plugin_config'` (`Element/BatchPluginConfig`) embeds a plugin's own
  configuration form anywhere:

```php
$form['batch_plugin_config'] = [
  '#type' => 'batch_plugin_config',
  '#plugin_id' => 'example_batch_plugin_from_config',
  '#plugin_configuration' => [],
  '#show_processor_element' => TRUE, // FALSE hides the processor selector
];
```

The element builds the plugin, calls `setConfigFormFromElement()` (which suppresses the base
Processor selector when `#show_processor_element` is falsy), and returns the plugin's configuration
via its `valueCallback`.

## Return / status constants

`processBatchPlugin()` may return `STATUS_QUEUE_ALREADY_BUILDING`, `STATUS_CRON_NOT_DUE`,
`STATUS_NO_OPERATIONS`, or `STATUS_OPERATIONS_ADDED` (on `ProcessorPluginInterface` /
`QueueProcessorPluginInterface` / `CronProcessorPluginInterface`).
