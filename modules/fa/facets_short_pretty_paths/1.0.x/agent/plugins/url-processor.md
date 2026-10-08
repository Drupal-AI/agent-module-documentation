<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `facets_short_pretty_paths` URL processor

File: `src/Plugin/facets/url_processor/FacetsShortPrettyPathsUrlProcessor.php`
Class: `Drupal\facets_short_pretty_paths\Plugin\facets\url_processor\FacetsShortPrettyPathsUrlProcessor`
extends `Drupal\facets_pretty_paths\Plugin\facets\url_processor\FacetsPrettyPathsUrlProcessor`
implements `ContainerFactoryPluginInterface`.

## Plugin definition

Annotation `@FacetsUrlProcessor(id = "facets_short_pretty_paths", label = "Short pretty paths")`. Select it
as the URL processor on a Facets **facet source** (Configuration → Search and metadata → Facets). Doing so
is what makes the `RouteSubscriber` add the `{facets_query}` path parameter to that source's route and what
makes `.module`'s form alter show the coder radios on the facet edit form.

## Constant

- `FACET_ITEMS_DELIMITER = '.'` — the character used to join multiple active values of the same facet in
  the path (e.g. `black.yellow.red`). Also read by `ShortPrettyPathsActiveFilters` when decoding.

## `buildUrls(FacetInterface $facet, array $results)`

Overrides the parent to produce shortened links. For each result it:

1. Starts from the current active filters (`getActiveFilters()`), then adds or removes this result's raw
   value depending on `isActive()`. Hierarchy is honoured: on disable it re-enables the parent id when
   `getEnableParentWhenChildGetsDisabled()` + `getUseHierarchy()`; on enable it strips the parent trail and
   nested child ids (via `getHierarchyInstance()->getParentIds()`/`getNestedChildIds()`). "Show only one
   result" mode replaces the facet's values with just this one.
2. Encodes every active value through the facet's configured `facets_pretty_paths` coder (loaded once per
   facet id) into `pretty_path_alias` entries `"/<url_alias>/<encoded_value>"`, then sorts them by facet
   weight and name (`sortByWeightAndName()`).
3. **Short-paths aggregation**: groups entries by facet name; the first occurrence keeps
   `/<alias>/<value>`, subsequent values of the same facet are appended as `.<value>` (using
   `FACET_ITEMS_DELIMITER`). The grouped aliases are concatenated into `$pretty_paths_string`.
4. Builds the link with `Url::fromUri('internal:' . $facet->getFacetSource()->getPath())`, sets the
   `facets_query` route parameter to that string, adds `rel="nofollow"`, and carries the current query
   parameters (temporarily removing/restoring `page` so a stale pager index is dropped, per
   drupal.org/node/2726455).

The facet value is only ever placed into a Drupal `Url` route parameter — it is not concatenated into raw
markup or a raw database query. Facet result access continues to follow the underlying search index.

## `initializeActiveFilters()`

Overrides the parent so active-filter parsing uses this module's service:
`\Drupal::service('facets_short_pretty_paths.active_filters')->getActiveFilters($facet_source_id)`, keyed by
`$this->configuration['facet']->getFacetSourceId()`. See
[../services/active-filters.md](../services/active-filters.md).

## Choosing the coder per facet

`.module`'s `hook_form_facets_facet_edit_form_alter()` adds a `facets_pretty_paths_coder` radios element
(options + descriptions from `plugin.manager.facets_pretty_paths.coder`) when the source's URL processor is
`facets_short_pretty_paths`. `facets_short_pretty_paths_facet_edit_form_submit()` (prepended to the submit
handlers) saves the choice as the facet's `facets_pretty_paths`/`coder` third-party setting.
