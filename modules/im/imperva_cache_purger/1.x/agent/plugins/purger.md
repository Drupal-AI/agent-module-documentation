<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purger plugin — ImpervaCachePurger

`src/Plugin/Purge/Purger/ImpervaCachePurger.php`, class `ImpervaCachePurger extends
PurgerBase` (from `drupal/purge`). Annotation `@PurgePurger`:

- `id = "imperva_cache_purger"`, `label = "Imperva cache Purger"`,
  `description = "Uses Imperva API invalidations."`
- `configform = "\Drupal\imperva_cache_purger\Form\ImpervaCachePurgerConfigForm"`
- `cooldown_time = 0.0`, `multi_instance = FALSE`
- `types = {"path", "wildcardpath", "everything", "tag"}` — the four invalidation types it
  claims to handle.

## Dependencies / construction

`create()` injects `imperva_cache_purger.invalidator` (the `ImpervaCacheInvalidator` service)
and `config.factory`; the constructor stores the invalidator and reads the immutable config
`imperva_cache_purger.settings` into `$this->settings`.

## `invalidate(array $invalidations)`

1. Split incoming invalidations into `$paths` / `$tags`:
   - `EverythingInvalidation` → `$paths = ['^/']` and `break` (purge everything).
   - `PathInvalidation` / `WildcardPathInvalidation` → expression normalised to a leading
     slash and passed through `htmlentities()`, appended to `$paths`.
   - `TagInvalidation` → expression appended to `$tags`.
   - Anything else → `setState(NOT_SUPPORTED)`.
2. If both `$paths` and `$tags` are empty → `logger()->info('No paths and tags found to
   purge')` and return.
3. If `settings.disabled` is truthy → log and `setStates(..., SUCCEEDED)` **without** calling
   Imperva (no-op mode).
4. Otherwise, inside try/catch:
   `$this->invalidator->invalidate($this->settings, $this->logger(), $paths, $tags)` then
   `setStates(..., SUCCEEDED)`. On `\Exception`, log via `Error::decodeException($e)` and
   `setStates(..., FAILED)`.

`setStates()` is a private helper that loops and calls `$invalidation->setState($state)`.

## Runtime hints

- `hasRuntimeMeasurement()` → `TRUE` (Purge measures capacity from real timings).
- `getTimeHint()` → `4.0` seconds — the per-invalidation time budget Purge uses to size batches.

## Behavioural notes

- `multi_instance = FALSE` → exactly one Imperva purger can exist. Only one site id / credential
  set is configured (see config/settings.md), so it targets a single Imperva site.
- Because the endpoint fires **one DELETE per path and per tag**, large invalidation batches
  translate into many sequential HTTP calls; `getTimeHint()` (4s) informs Purge's batching.
