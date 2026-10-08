# Services & programmatic invalidation

Core services (each plugin type has a "service" that manages instances plus a plugin manager):

- `purge.purgers` (`PurgersService`) — the configured purgers; `invalidate()` entry point.
- `purge.processors` (`ProcessorsService`) — enabled processors.
- `purge.queuers` (`QueuersService`) — enabled queuers.
- `purge.queue` (`QueueService`) — the queue; add/claim/delete invalidations.
- `purge.queue.stats` (`StatsTracker`), `purge.queue.txbuffer` (`TxBuffer`).
- `purge.invalidation.factory` (`InvalidationsService`) — create typed invalidation objects.
- `purge.diagnostics` (`DiagnosticsService`) — run diagnostic checks.
- `purge.purgers.tracker.capacity` (`CapacityTracker`) — rate limiting.
- `purge.logger` (`LoggerService`).

## Queue a tag invalidation in code
```php
$factory = \Drupal::service('purge.invalidation.factory');
$queue   = \Drupal::service('purge.queue');

$inv = $factory->get('tag', 'node:123');   // type + expression
$queue->add([$inv]);                        // queuers normally do this for you
```

## Invalidate immediately (bypass the queue)
```php
$purgers = \Drupal::service('purge.purgers');
$inv = \Drupal::service('purge.invalidation.factory')->get('url', 'https://example.com/news');
$purgers->invalidate($someProcessor, [$inv]);   // subject to capacity limits
```
Invalidation types: `tag`, `path`, `url`, `wildcardpath`, `wildcardurl`,
`regularexpression`, `everything`. Check `$inv->getState()` afterwards. Normally you rely on
queuers (e.g. `purge_queuer_coretags`) + processors rather than invalidating directly.
