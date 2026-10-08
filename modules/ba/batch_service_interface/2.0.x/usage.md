<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Batch Service Interface provides an abstract class and interface for writing Drupal Batch API jobs as dependency-injected services instead of procedural batch arrays.

---

Batch Service Interface is a small developer/API module (no configuration, no permissions, no routes of its own) that supplies `AbstractBatchService` and `BatchServiceInterface` in the `Drupal\batch_service_interface` namespace. A developer defines a batch by registering a service that extends `AbstractBatchService`, sets its static `$serviceName` to that service id, and implements `generateBatchJob()` to return an operations list plus `doFinishBatch()` for completion. Each operation names a public method on the service; the abstract class turns the list into a standard Drupal batch array (via `prepBatchArray()`) whose operation and finished callbacks re-bootstrap the service from the container with `\Drupal::service()`, so every task method runs with full access to logging (`$this->logger`), translation (`$this->t()`), the messenger, and any injected service. The hidden `batch_example` submodule demonstrates the whole pattern with a form that queues N random-quote log messages. Batches run with the privileges of whoever triggers them; the module itself performs no access control.

---

- Define a Drupal batch job as an injectable service rather than a procedural batch array.
- Extend `AbstractBatchService` to get logging, translation, and messenger wired in automatically.
- Implement `BatchServiceInterface` directly when you need a non-abstract base.
- Give each batch operation clean access to any container service (no `\Drupal::service()` scattered in callbacks).
- Turn a list of `[method => data]` operations into a batch array with `prepBatchArray($title, $initMessage, $rawOps)`.
- Write batch operation callbacks as ordinary public methods on the service (`doTask()` dispatches to `$this->$taskName()`).
- Use per-service log channels (`Batch Service: <serviceName>`) for isolated batch logging.
- Generate a batch from a form submit handler and hand it to `batch_set()`.
- Kick off a batch from a Drush command, controller, or queue worker by calling `YourService::generateBatch($data)`.
- Centralize batch completion messaging in `doFinishBatch()` using the injected messenger.
- Structure long-running content operations (bulk node/entity updates, imports, re-saves) as testable service methods.
- Reuse the same service methods both inside and outside of a batch context (they are plain methods).
- Support both associative (`method => data`) and sequential (`[[method => data]]`) operation lists.
- Skip malformed operations gracefully — `prepBatchArray()` logs a notice for entries that are neither a known method nor an array.
- Encourage a consistent team convention for authoring batches across custom modules.
- Learn the pattern from the bundled `batch_example` submodule and its `ExampleBatchForm`.
- Provide a foundation module that other custom modules depend on for batch scaffolding.
- Keep batch logic unit-test friendly by isolating it in a service with injected collaborators.
- Migrate legacy procedural batch code to a service-oriented structure incrementally.
- Run on Drupal 10.3+ and Drupal 11 with no external dependencies.
