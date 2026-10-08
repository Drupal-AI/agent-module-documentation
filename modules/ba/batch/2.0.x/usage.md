Batch API is a developer toolkit that wraps Drupal's core Batch API with object-oriented operation classes, a batch builder, a finish handler, and Drush code generators.

---

Batch API (machine name `batch`) provides no user-facing features; it is a framework for developers who need to process large numbers of items in Drupal batches. Instead of writing procedural batch callbacks, you extend an operation base class and implement `processItem()`. `EnumeratedOperationBase` handles a known, in-memory list of items; `HighwaterOperationBase` progressively queries items for very large data sets so nothing has to be held in memory at once. `OperationBase` supplies chunked processing (configurable `itemsPerProcess`, default 10), automatic progress reporting, and opportunistic memory reclamation (resetting entity caches and running the garbage collector when memory usage exceeds 85% of the limit). A `BatchBuilder` (extending core's `\Drupal\Core\Batch\BatchBuilder`) accepts operation objects via `addBatchOperation()`, and a `FinishDefault` class runs on completion and can issue a redirect. The `batch:operation` and `batch:finish` Drush generators scaffold new classes. The module depends on the Awareness module for its entity-manager and memory-cache traits.

---

- Process a fixed list of node/entity IDs in a batch by extending `EnumeratedOperationBase` and implementing `processItem()`.
- Bulk-update thousands of nodes (e.g. re-save, re-index, migrate a field) without hitting PHP memory limits.
- Progressively iterate a huge or unbounded result set with `HighwaterOperationBase`, querying the next chunk each run instead of loading everything up front.
- Build a batch definition from operation objects with `BatchBuilder::addBatchOperation()` and hand it to core `batch_set($batch->toArray())`.
- Tune how many items run per batch iteration with `OperationInterface::setItemsPerProcess()`.
- Get automatic progress reporting (`$context['finished']`) computed from remaining vs. total items.
- Reclaim memory automatically during long batches (entity cache resets + `gc_collect_cycles()` above 85% memory usage).
- Redirect the user to a specific route/URL when a batch completes using `FinishDefault::setRedirectUrl()`.
- Add custom completion behavior (status messages, cleanup) by extending `FinishDefault` and overriding `finished()`.
- Run batches from a form submit handler, a controller, or a custom Drush command.
- Run batches non-progressively from Drush via `drush_backend_batch_process()`.
- Scaffold a new operation class with `drush generate batch:operation`.
- Scaffold a new finish-operation class with `drush generate batch:finish`.
- Log per-item processing results from inside an operation via the `LoggerChannelTrait`.
- Add status/warning messages during processing via the `MessengerTrait`.
- Load entities inside an operation using the injected entity type manager (`getEntityTypeManager()`).
- Keep batch operations serializable across HTTP requests thanks to `DependencySerializationTrait`.
- Standardize batch code across a team so every batch follows the same structure and conventions.
- Replace ad-hoc procedural batch callback functions with reusable, testable classes.
- Chain multiple operations in one batch by adding several operation objects to the builder.
- Set a total-item count in a highwater operation (`countItems()`) to show accurate progress.
