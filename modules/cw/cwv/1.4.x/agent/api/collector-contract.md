<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CWV collector contract (extend from a sibling module)

CWV's extension point is a **tagged-service** contract, not a Drupal plugin type: there is no plugin
manager, no annotation/attribute discovery. A sibling module registers a service tagged
`{ name: cwv_collector }`; `Drupal\cwv\Plugin\CwvContextCollector\CollectorRegistry` (service
`cwv.collector_registry`, built from `!tagged_iterator cwv_collector`) materialises each tagged
service once and routes it by **which interface(s) it implements**. One service may implement any
combination of the four shapes.

## The four shapes

1. **Synchronous** — `CwvSynchronousCollectorInterface`
   (`getKey(): string`, `collect(BeaconRequest $beacon): mixed`). Runs at beacon time from the
   request/payload only; return value is stored at `context_data[getKey()]` (NULL/`[]` omits the
   key). Must be fast and must not throw (the registry catches + logs to the `cwv` channel).
   Built-ins: `DrupalCacheCollector`, `UserStateCollector`, `UpstreamIdCollector`.

2. **Async decoration** — `CwvAsyncDecoratorInterface`
   (`getKey()`, `finalize(TerminateEvent): mixed`). Observes state during the *page request* and
   attaches it to the *later* beacon. Reconciliation is by a 16-char request ID stamped as
   `Server-Timing: cwv-rid;desc=<id>` by `CwvRequestIdSubscriber`, forwarded by the JS, and looked
   up from `AsyncContextStore` (keyvalue.expirable, ~60s TTL) at beacon write time. Extend
   `CwvAsyncDecoratorBase` (handles the `kernel.terminate` subscription + store write); tag the
   service with both `cwv_collector` and `event_subscriber`. Built-ins: `KernelTimingDecorator`,
   `BackendCacheCollector`, `RenderTreeCollector`, `DatabaseCollector`.

3. **Probe** — `CwvProbeCollectorInterface`
   (`getKey()`, `getProbeTargets(): array`, `probe(string $target, int $timeout): mixed`). Cron-
   driven synthetic observation, independent of any visitor; `ProbeRunner` writes each result to
   `cwv_probes`. Runs only when `probe_enabled`. Built-ins: `EdgeCacheProbeCollector` (HEAD-requests
   `probe_targets`, http(s)-scheme-restricted, reads CDN cache-state headers),
   `OpcacheHealthProbeCollector`, `ApcuHealthProbeCollector`.

4. **Panel contribution** — `CwvPanelContributionInterface`
   (`getPanelKey()`, `getWeight()`, `build(int $window_seconds, array $filters): array`). Adds one
   render-array panel to `/admin/reports/cwv`; panels are weight-sorted (`CwvPanelWeight` constants).
   Built-ins: `CacheComparisonPanel`, `DistributionPanel`, `PerRouteSummaryPanel`,
   `DailyCountsPanel`, `RecentMeasurementsPanel`, `HealthTimeSeriesPanel`.

## Registry API (`CollectorRegistry`)

- `collect(BeaconRequest): array` — runs all synchronous collectors, catching exceptions per
  collector (a failing collector omits its field instead of failing the beacon).
- `getSynchronousCollectors()`, `getProbeCollectors()`, `getPanelContributors()` (weight-sorted).

## Minimal example (a synchronous collector)

```yaml
# my_module.services.yml
services:
  my_module.cwv_collector.foo:
    class: Drupal\my_module\CwvFooCollector
    tags:
      - { name: cwv_collector }
```

```php
namespace Drupal\my_module;

use Drupal\cwv\Plugin\CwvContextCollector\BeaconRequest;
use Drupal\cwv\Plugin\CwvContextCollector\CwvSynchronousCollectorInterface;

class CwvFooCollector implements CwvSynchronousCollectorInterface {
  public function getKey(): string { return 'foo_state'; }
  public function collect(BeaconRequest $beacon): mixed {
    // Return a JSON-serialisable value, or NULL to record nothing.
    return ['bar' => 1];
  }
}
```

Keys should be lowercase snake_case, namespaced by the contributing module (`lscache_state`,
`jelastic_env`) to avoid collisions in `context_data`. `BeaconRequest`
(`src/Plugin/CwvContextCollector/BeaconRequest.php`) wraps the Symfony `Request` plus the decoded
payload and exposes `getRequestId()`.
