# BAT Facets — widget & availability query

## The `bat_state` facet widget

`Drupal\bat_facets\Plugin\facets\widget\BatStateWidget` (`@FacetsWidget(id = "bat_state")`), extends
the Facets `LinksWidget`. Its `build()` returns the `FacetsAvailabilityForm` (a start/end date
filter). `buildConfigurationForm()` exposes:

- `event_type` — which `bat_event_type` to check availability against (options from
  `bat_event_get_types()`).
- `state` — the state(s) that count as a match (e.g. available).

Configure it on a facet whose source indexes `bat_unit_type` entities.

## How the search narrows results

`bat_facets_search_api_query_alter(QueryInterface &$query)` (in `bat_facets.module`):

1. Runs only for Search API datasources whose entity type is `bat_unit_type`.
2. Reads the enabled `bat_state` facet's config (`event_type`, `state`).
3. Reads `bat_start_date` and `bat_end_date` from `\Drupal::request()->query` (the end date is
   reduced by one minute — BAT treats the end as inclusive).
4. Opens a Roomify `DrupalDBStore` on the event type's **state store** and builds a `Calendar` over
   the units of each candidate type.
5. Collects booking constraints via `bat_event_constraints_get_info()` and calls
   `$calendar->getMatchingUnits($start, $end, $valid_states, $constraints)`.
6. Fires `hook_bat_facets_search_results_alter($valid_type_ids, $context)` (context includes
   `types_before_search`, dates, `event_type`, `valid_states`, `available_unit_count`).
7. Constrains the query: `->addCondition('id', $valid_type_ids, 'IN')`, or `->addCondition('id', 1, '<')`
   (no results) when nothing matches.

## Setup outline

1. Enable `search_api` + `facets`, index `bat_unit_type` in a Search API index.
2. Create a facet on that index; set its widget to **BAT State**; configure `event_type` + `state`.
3. Place the facet; submit its date form with `bat_start_date` / `bat_end_date` to filter by availability.

No permissions, routes, or config entities are defined by this module.
