<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Service Interface Example Module (batch_example) — agent index

Hidden (`hidden: true`) example submodule of **batch_service_interface**, package "Developer (Examples)". Reference code that demonstrates the service-based batch pattern. Depends on its parent `batch_service_interface`. No config, no permissions, no config schema. Core `^10.3 || ^11`.

## What it provides

- **Service** `batch_example.example_batch` (`batch_example.services.yml`) → class `Drupal\batch_example\ExampleBatchService` (`src/ExampleBatchService.php`), args `['@logger.factory', '@string_translation']`. Extends `AbstractBatchService`, `$serviceName = 'batch_example.example_batch'`. Methods: `generateBatchJob($data)` (one `logMessage` op per `$data['message_count']`), `logMessage($data, &$context)` (logs a random quote, increments `results['message_count']`), `doFinishBatch()` (messenger "Logged %count quotes"), `getRandomMessage()`.
- **Form** `Drupal\batch_example\Form\ExampleBatchForm` (`src/Form/ExampleBatchForm.php`) — injects the service via `create()`; `buildForm` has a `message_count` number field; `submitForm` calls `generateBatchJob()` then `batch_set()`.
- **Route** `batch_example.example_form` (`batch_example.routing.yml`) — path `/batch_example/form`, `_form` = `ExampleBatchForm`, `_access: 'TRUE'`.
- **Menu link** `batch_example.example_form` (`batch_example.links.menu.yml`) — under `system.admin_config`, title "Example Batch Form".

## How to use it

See **[agent/forms/example-batch-form.md](forms/example-batch-form.md)** — enable, the route, and the request-to-log flow.

Parent pattern: **[batch_service_interface agent index](../../../../agent/start.md)**.
