<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `respect_global_max_facets` Facets processor

File: `src/Plugin/facets/processor/RespectGlobalMaxFacets.php`
Class: `final class RespectGlobalMaxFacets extends ProcessorPluginBase implements BuildProcessorInterface`
(base class and interface from the `facets` module).

## Plugin definition

Annotation `@FacetsProcessor(id = "respect_global_max_facets", label = "Respect global max facets",
stages = {"build" = 100})`. It is a **build**-stage processor with weight **100**, so it runs late in Facets'
result-build pipeline. It is discovered by the Facets processor plugin manager; this module defines no plugin type.

## Enabling it (per-facet opt-in)

The cap only applies to facets that enable this processor. On a facet's edit form, turn on **Respect global max
facets**. `build()` first checks `isset($facet->getProcessorConfigs()['respect_global_max_facets'])` and returns
the unmodified `$results` if the facet has not opted in.

> Note (not a vuln): `config/schema/facets_max_facets.schema.yml` also declares a
> `facets.facet.third_party_settings.facets_max_facets.respect_global_max` boolean, but the runtime opt-in check
> reads the standard Facets processor config keyed by the processor id (`respect_global_max_facets`), not that
> third-party-settings key. The schema entry is effectively unused by the code.

## What `build(FacetInterface $facet, array $results): array` does

1. Reads the global cap `$max = (int) \Drupal::config('facets_max_facets.settings')->get('max_active_facets')`.
   If `$max <= 0`, returns `$results` unchanged (0 disables the limit).
2. Reads `\Drupal::request()->query->all()`. If there is no `f` query parameter, returns `$results`.
   Otherwise `$total_active = is_array($query['f']) ? count(array_filter($query['f'])) : 0` — the number of active
   facet selections carried in the standard Facets `?f[]` URL parameter.
3. If `$total_active < $max`, returns `$results` unchanged (limit not yet reached).
4. Once the limit is reached, it **prunes** the result tree: it keeps only results that have an active descendant
   (`hasActiveDescendant()`) and, for those, removes inactive child branches while preserving active paths
   (`pruneInactiveBranches()`, recursive, via `ResultInterface::getChildren()` / `setChildren()`). Net effect: no
   *new* facet options are offered, but the links needed to *remove* current filters remain.
5. Shows the limit message once per page: guarded by a `static $message_shown` flag, it reads
   `limit_message` from config, does `str_replace(':max-count', (string) $max, $message)`, and calls
   `\Drupal::messenger()->addWarning($message)` (only when the message is a non-empty string).

## Notes for operators

- The count is derived purely from the request's `?f[]` array; it is a display-time guard on facet options, not an
  access control on results. Search results themselves continue to follow the underlying index's access.
- The message uses `:max-count` as the only placeholder for the configured maximum.
- Because pruning happens at build stage, it composes with other Facets processors on the same facet.
