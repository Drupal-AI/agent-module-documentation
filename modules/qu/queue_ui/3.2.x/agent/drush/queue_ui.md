# Drush commands

Registered via `drush.services.yml` (service `queue_ui.commands`,
`Drupal\queue_ui\Commands\QueueUiCommands`). Requires Drush `^12 || ^13`.

| Command | Aliases | Argument | Action |
|---|---|---|---|
| `queue:process` | `qp`, `queue-process` | `[queueName]` (optional) | Batch-process one queue. If the name is omitted, prompts to choose from all defined queues. |
| `queue:process-all` | `qpa`, `queue-process-all` | — | Batch-process every defined queue. |
| `queue:release` | `qr`, `queue-release` | `[queueName]` (optional) | Reset (release) leases on all items in one queue; prompts for the queue if omitted. |
| `queue:release-all` | `qra`, `queue-release-all` | — | Release leases on every defined queue. |

Examples:

```
drush queue:process my_queue      # process one named queue
drush qp                          # interactive queue picker
drush queue:process-all           # process all queues
drush queue:release my_queue      # reset stuck leases on one queue
drush qra                         # release leases on all queues
```

Notes:

- Processing runs through the Batch API (`BatchBuilder` → `queue_ui.batch::step`), executed
  with `drush_backend_batch_process()` (`progressive = FALSE`).
- `queue:release` resolves the backend via `QueueUIManager::fromQueueName()` then calls
  `releaseItems()`, logging the count reset.
- Queue names come from `QueueWorkerManagerInterface::getDefinitions()`.
- There is no "clear/delete queue" Drush command — clearing is UI-only
  (`queue_ui.confirm_clear_form`). Core's own `drush queue:run` also exists but is separate
  from Queue UI.
