# Plugin types

Purge defines seven plugin types (annotations in `src/Annotation/`, managers under
`src/Plugin/Purge/*/PluginManager.php`). Most custom work is a **Purger**, a
**DiagnosticCheck**, or a **TagsHeader**.

| Plugin type | Annotation | Manager service | Role |
|---|---|---|---|
| Purger | `@PurgePurger` | `plugin.manager.purge.purgers` | Flush the external cache. Declare which invalidation types you support + capacity/cost. |
| Processor | `@PurgeProcessor` | `plugin.manager.purge.processor` | Drain the queue and hand items to purgers. |
| Queuer | `@PurgeQueuer` | `plugin.manager.purge.queuer` | Add invalidations to the queue. |
| Queue | `@PurgeQueue` | `plugin.manager.purge.queue` | Storage backend for queued invalidations. |
| Invalidation | `@PurgeInvalidation` | `plugin.manager.purge.invalidation` | An invalidation "type": `tag`, `path`, `url`, `wildcardpath`, `wildcardurl`, `regularexpression`, `everything`. |
| DiagnosticCheck | `@PurgeDiagnosticCheck` | `plugin.manager.purge.diagnostics` | Health/precondition checks shown on status report. |
| TagsHeader | `@PurgeTagsHeader` | `plugin.manager.purge.tagsheader` | Emit cache-tag headers on responses for edge caches. |

## Implementing a Purger (most common)
```php
#[PurgePurger(
  id: 'my_cdn',
  label: new TranslatableMarkup('My CDN'),
  cooldown_time: 0.2,
  types: ['tag', 'url', 'everything'],   // invalidation types handled
  multi_instance: false,
)]
class MyCdnPurger extends PurgerBase implements PurgerInterface {
  public function invalidate(array $invalidations) {
    foreach ($invalidations as $inv) {
      $inv->setState(InvalidationInterface::PROCESSING);
      // ... call the CDN API ...
      $inv->setState(InvalidationInterface::SUCCEEDED); // or FAILED
    }
  }
  public function getTimeHint() { return 2.0; } // seconds per invalidation (capacity)
}
```
Base classes live under `src/Plugin/Purge/Purger/` (`PurgerBase`), and similar `*Base`
classes exist for the other types. Set each invalidation's state (SUCCEEDED / FAILED /
NOT_SUPPORTED) so the queue and capacity tracker behave correctly.
