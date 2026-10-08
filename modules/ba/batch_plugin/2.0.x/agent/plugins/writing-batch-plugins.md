<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a batch plugin

## Install & enable

```bash
composer require drupal/batch_plugin
drush en batch_plugin -y
```

No module dependencies. Optionally enable `batch_plugin_entity` (UI) and/or
`batch_plugin_example` (demos).

## The plugin type

- Discovery: `src/Plugin/BatchPlugin` under any module's namespace.
- Interface: `Drupal\batch_plugin\BatchPluginInterface`; base class
  `Drupal\batch_plugin\BatchPluginBase` (extends core `PluginBase`).
- Attribute: `#[Drupal\batch_plugin\Attribute\BatchPlugin(...)]`. A legacy Doctrine annotation
  `@BatchPlugin` (`src/Annotation/BatchPlugin.php`) is also supported; `processStatic()` reads the
  annotation form via `SimpleAnnotationReader`, so if you rely on `processStatic()` the class must
  carry the annotation, not only the attribute.
- Manager: service `plugin.manager.batch_plugin` (`BatchPluginManager`), cache `batch_plugins`.

### Attribute parameters (`Attribute/BatchPlugin`)

| Param | Meaning |
|---|---|
| `id` | Plugin id. Must equal the group or be prefixed `group:...` (plugin-discovery constraint noted in source). |
| `label` | `TranslatableMarkup` title. |
| `description` | Optional description. |
| `processors` | Comma list of allowed processor ids; default `'batch_api,cron,queue'`. **First = default** when none is passed. |
| `permission` | Documented as **NOT IMPLEMENTED YET** for execution; only used by the entity UI listing to hide plugins the current user lacks. |
| `cronexpression` | Cron expression / macro (dragonmantank format) used when run under the `cron` processor. |
| `hidden` | Hide from the `batch_plugin_entity` add UI. Default `FALSE`. |

## The two methods you implement

```php
#[BatchPlugin(id: 'my_batch', label: new TranslatableMarkup('My batch'))]
class MyBatch extends BatchPluginBase {
  public function setupOperations(): void {
    // MUST populate $this->operations with serializable payloads.
    $this->operations = \Drupal::entityQuery('node')->accessCheck(TRUE)->execute();
  }
  public function processOperation($payload, array|\DrushBatchContext &$context): void {
    // Handle one payload. $payload is the first arg; $context is the batch/drush context.
  }
}
```

- `setupOperations()` — build `$this->operations` (each element is passed as `$payload` to the
  callback). Data **must be serializable** — Batch API re-creates the plugin statically between
  operations, so instance properties set in `setupOperations()` are otherwise lost.
- `processOperation($payload, &$context)` — default operation callback. Write progress into
  `$context['message']` and results into `$context['results'][...]`.

## Optional overrides (all on `BatchPluginBase`)

- `finished(bool $success, array $results, array $operations)` — completion callback (post-process,
  notify). Called by the `batch_api` processor's static `batchFinished()` and by the queue worker's
  finished item. Always `parent::finished()` first (it fires `ConfigTableSelectTrait` hooks).
- `appendOperations(array $operations, $context, string $callback = '')` — queue a **nested** wave
  of operations mid-run (recursive batches). Default callback is `processAppendedOperation($payload,
  $previousContext, &$context)`; pass a custom method name with the same signature.
- `defaultConfiguration()` / `buildConfigurationForm()` / `validate…` / `submitConfigurationForm()`
  — standard `ConfigurableInterface` + `PluginFormInterface`. The base's `buildConfigurationForm()`
  already renders a **Processor** select plus the chosen processor's own sub-form (AJAX-swapped);
  call `parent::…` and add your own fields (see the example complex plugin).
- `setBatchTitle($message, $context)` / `setBatchErrorMessage($message)` — Batch API UI strings;
  `@plugin` and `@count` tokens are injected automatically.
- Persistable state: `setPesistable()` / `getPersistable()` — a serializable array that survives the
  static re-instantiation (unlike normal properties). `setConfigKey()` also stores into it.
- `setHelpfulData()` / `getHelpfulData()` (`HelpfulDataTrait`) — arbitrary data available in
  `setupOperations()`; **not** carried to `processOperation()` unless you put it into a payload.
- `getQueueWorkerDerivatives()` — return custom queue-worker derivative definitions (default `[]`).

## How discovery adds a queue name

`BatchPluginManager::getDefinitions()` adds `queue_name` =
`batch_plugin_queue_worker:<plugin_id>` to every definition.
`getDefinitionsByType($type, $include_entities = TRUE)` returns plugins whose `processors` include
`$type`, and (when `batch_plugin_entity` is installed) also enabled entities whose configured
`processor_plugin_id` matches — used by `hook_cron()` and the queue-worker deriver.

## Traits available

- `ConfigTableSelectTrait` (`src/ConfigTableSelectTrait.php`) — adds a `tableselect` element to a
  config form (`addTableSelect()`), sanitises checkbox arrays, and on `finished()` persists selected
  rows back into the plugin's config object.
- `PluginCreationTrait` — static helpers `createBatchPlugin()`, `createProcessorPlugin()`,
  `getPluginForm()`.

See the example plugins for concrete patterns →
[batch_plugin_example](../../modules/batch_plugin_example/2.0.x/agent/start.md)
