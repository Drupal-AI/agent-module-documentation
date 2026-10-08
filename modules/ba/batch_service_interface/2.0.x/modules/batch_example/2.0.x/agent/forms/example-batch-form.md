<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example batch form

## Install & enable

```bash
drush en batch_example -y   # pulls in batch_service_interface
```

The module is `hidden: true` (won't show on the normal Extend list without "show experimental/hidden" or `drush en`). It is illustrative reference code — do not enable it on production.

## Route & menu

`batch_example.routing.yml`:

- id `batch_example.example_form`, path `/batch_example/form`, `_form` = `\Drupal\batch_example\Form\ExampleBatchForm`, `_title` "Example Batch Form", requirement `_access: 'TRUE'`.

`batch_example.links.menu.yml` adds a link under `system.admin_config` titled "Example Batch Form".

## Service

`batch_example.services.yml` registers `batch_example.example_batch` → `Drupal\batch_example\ExampleBatchService` with args `['@logger.factory', '@string_translation']`. The class extends `AbstractBatchService` and sets `protected static $serviceName = 'batch_example.example_batch'`.

## Request-to-log flow

1. `ExampleBatchForm::create()` injects `batch_example.example_batch`; `buildForm()` renders an intro markup line and a `number` field `message_count`, plus submit. `validateForm()` only calls the parent (no bounds check).
2. `submitForm()` reads `message_count` into `$data`, calls `$this->exampleBatchService->generateBatchJob($data)`, then core `batch_set($batch)`.
3. `ExampleBatchService::generateBatchJob($data)` loops `for ($i = 0; $i < $data['message_count']; $i++)` building `$ops[] = ['logMessage' => ['MessageIndex' => $i + 1]]`, then returns `prepBatchArray($this->t('Logging Messages'), $this->t('Starting Batch Processing'), $ops)`.
4. Each operation runs `ExampleBatchService::runTask` (from the abstract base) → `doTask('logMessage', …)` → `logMessage($data, &$context)`: logs `getRandomMessage()` (a random quote from a hard-coded list of 14) at `info` level on channel `Batch Service: batch_example.example_batch`, and increments `$context['results']['message_count']`.
5. On completion, `finishedBatch` → `doFinishBatch($success, $results, $operations)` shows the status message "Logged %count quotes".

Net effect: submitting the form writes `message_count` random-quote log entries and reports the total. It is a demonstration of the parent module's pattern, nothing more.
