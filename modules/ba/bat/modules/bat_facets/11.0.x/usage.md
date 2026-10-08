BAT Facets makes BAT availability searchable through Search API + Facets: it adds a `bat_state` facet widget and a date-range availability form so a visitor can search for unit types that are in a given state (e.g. "available") over a chosen date range, narrowing Search API results to only the matching units.

---

The module provides the `bat_state` Facets widget (`BatStateWidget`, extending the core Links widget)
whose build renders a `FacetsAvailabilityForm` — a start/end date filter. When those dates are
submitted, `hook_search_api_query_alter()` (`bat_facets_search_api_query_alter`) intercepts Search API
queries whose datasource is `bat_unit_type`: it reads `bat_start_date` / `bat_end_date` from the
request, builds a Roomify `Calendar` over the configured event type's state store
(`DrupalDBStore`), computes which unit types have at least one unit in the widget's configured
`state`(s) across the period (applying `bat_event_constraints_get_info()` constraints), fires
`hook_bat_facets_search_results_alter()`, and then constrains the Search API query to those type ids
(or zeroes out results when none match). The widget's configuration form lets an admin pick the
`event_type` and valid `state`s the facet searches against. This module has no entities, permissions
or config schema of its own — it is pure glue between BAT availability and Search API/Facets. Requires
`search_api` and `facets`.

---

- Add an availability date-range search to a Search API index of BAT unit types.
- Let visitors find unit types that are available over a chosen start/end date.
- Configure which BAT `event_type` the availability facet queries.
- Configure which state(s) count as a match (e.g. "available").
- Narrow Search API results to only unit types with matching availability.
- Apply BAT booking constraints (min stay, etc.) during the availability search.
- Zero out search results when no unit type is available for the requested dates.
- Alter the availability search result set via `hook_bat_facets_search_results_alter()`.
- Present availability as a Facets widget (`bat_state`) alongside other facets.
- Build a "search availability" front end for a hotel/rental catalog on Search API.
- Combine availability filtering with other Search API facets (location, price, amenities).
- Reuse the `FacetsAvailabilityForm` date inputs as the availability query UI.
- Drive availability off the same per-event-type calendar tables `bat_event` maintains.
- Read `bat_start_date` / `bat_end_date` request parameters as the search window.
- Integrate BAT into a decoupled or Views-based faceted search page.
- Count available units per type during the search (`available_unit_count` context).
- Keep availability search consistent with the calendar admins manage.
