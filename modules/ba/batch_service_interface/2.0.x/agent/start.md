<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Service Interface (batch_service_interface) — agent index

Developer/API module: a design pattern for writing Drupal Batch API jobs as dependency-injected **services** instead of procedural batch arrays. No config, no permissions, no routes, no config schema. Core `^10.3 || ^11`; no external dependencies (`composer require`/`require` are empty).

## What it provides (namespace `Drupal\batch_service_interface`)

- **`BatchServiceInterface`** (`src/BatchServiceInterface.php`) — contract: statics `generateBatch($data)`, `runTask($taskName, $parameters, &$context)`, `finishedBatch($success, $results, $operations)`; instance `generateBatchJob($data)`, `doTask($taskName, $parameters, &$context)`, `doFinishBatch($success, $results, $operations)`.
- **`AbstractBatchService`** (`src/AbstractBatchService.php`) — abstract base you extend. Uses `MessengerTrait` + `StringTranslationTrait`; injects `logger.factory` + `string_translation` via constructor; child must set static `$serviceName` (its own service id). Key helper `prepBatchArray($title, $initMessage, $rawOps)` builds the Drupal batch array. Static callbacks re-bootstrap the service from the container with `\Drupal::service($serviceName)`.

Only hook: `batch_service_interface_help()` in `.module` (help.page text). No install/schema files.

## How to use it

See **[agent/api/batch-service.md](api/batch-service.md)** — the class contract, the two operation-list shapes, and the callback/bootstrap flow.

## Submodule

- **batch_example** (hidden demo) — a form that queues N random-quote log messages. Documented at **[batch_example agent index](../modules/batch_example/2.0.x/agent/start.md)**.
