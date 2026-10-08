<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a batch as a service

## Install & enable

```bash
composer require drupal/batch_service_interface
drush en batch_service_interface -y
```

No dependencies beyond Drupal core, no configuration, no permissions. You consume it from your own custom module's code.

## The two classes

Namespace `Drupal\batch_service_interface`.

- `BatchServiceInterface` (`src/BatchServiceInterface.php`) — the contract (6 methods listed in the index).
- `AbstractBatchService` (`src/AbstractBatchService.php`) — implement your batch by extending this.

`AbstractBatchService` `use`s `MessengerTrait` and `StringTranslationTrait`. Its constructor takes `LoggerChannelFactoryInterface $logger_factory` and `TranslationInterface $string_translation`; it sets `$this->logger = $logger_factory->get('Batch Service: ' . static::$serviceName)` and wires `$this->stringTranslation`. So every task method has `$this->logger`, `$this->t()`, and `$this->messenger()`.

## Steps to define a batch

1. **Register a service** whose `class` extends `AbstractBatchService`, with arguments `['@logger.factory', '@string_translation']` (add more args + a constructor if you need them).
2. **Set `protected static $serviceName`** to that exact service id. This is required — the static callbacks re-bootstrap the service with `\Drupal::service(static::$serviceName)` via `bootstrapService()`, so a wrong/empty name breaks the batch.
3. **Implement `generateBatchJob($data)`** — build a `$rawOps` list and return `$this->prepBatchArray($title, $initMessage, $rawOps)`.
4. **Write one public method per operation** — signature `(mixed $data, array &$context)`.
5. **Implement `doFinishBatch($success, $results, $operations)`** — completion handler (`callback_batch_finished`), typically messenger output.

## Operation-list shapes accepted by `prepBatchArray()`

`prepBatchArray($title, $initMessage, $rawOps)` iterates `$rawOps` and, per entry, emits `[ ClassName::runTask, [ $taskName, $data ] ]`:

- **Associative**: key is a method name → `if (method_exists($this, $key))` it uses `$key` as the task and the value as data.
- **Sequential wrapping an assoc array**: entry is an array → it takes `key($data)` as the task and `$data[$task]` as the payload (this is the shape the example submodule uses: `[['logMessage' => [...]]]`).
- **Anything else** → logs `notice('Skipping requested operation during prep. Invalid operation structure.')` and drops it.

The returned batch array is:

```php
['title' => $title, 'init_message' => $initMessage, 'operations' => $ops, 'finished' => ClassName . '::finishedBatch']
```

## Callback / bootstrap flow

Drupal's Batch API calls only string callbacks, so the abstract class exposes statics that re-enter the container:

- `static generateBatch($data)` → `bootstrapService()->generateBatchJob($data)` (convenience entry point; you can also call `generateBatchJob()` on the service directly, as the example form does).
- `static runTask($taskName, $parameters, &$context)` (the `callback_batch_operation`) → `$service->doTask(...)` → `doTask()` dispatches `$this->$taskName($parameters, $context)`.
- `static finishedBatch(...)` (the `callback_batch_finished`) → `$service->doFinishBatch(...)`.

Task names come from `$rawOps` keys that your own `generateBatchJob()` produces (guarded by `method_exists`), not from request input.

## Trigger the batch

Get the service and hand its generated array to core `batch_set()`:

```php
$service = \Drupal::service('my_module.my_batch'); // or inject it
$batch = $service->generateBatchJob($data);
batch_set($batch);
// In a form submit, core runs it after submission; elsewhere call batch_process().
```

Batches run with the privileges of whoever triggers them; this module adds no access layer. `bootstrapService()` carries a `TODO` to switch to a more generic Symfony construct instead of `\Drupal::service()`.
