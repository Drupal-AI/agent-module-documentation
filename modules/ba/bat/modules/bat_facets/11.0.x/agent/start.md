# BAT Facets — agent index

Glue between BAT availability and Search API + Facets. Adds a `bat_state` facet widget with a
date-range form; a Search API query-alter narrows results to unit types available over the requested
dates. No entities, permissions, or config schema of its own. Requires `bat_event`, `search_api`,
`facets`.

- **The `bat_state` widget, availability form, and query-alter** → [configure/facets.md](configure/facets.md)

Key facts:
- Widget `bat_state` (`BatStateWidget` extends Facets `LinksWidget`) renders `FacetsAvailabilityForm`
  (start/end date inputs). Widget config: `event_type`, `state`(s).
- `bat_facets_search_api_query_alter()` acts on datasources of entity type `bat_unit_type`, reads
  `bat_start_date`/`bat_end_date` from the request, builds a Roomify `Calendar` on the event type's
  state store, and constrains the query to matching type ids (or `id < 1` when none match).
- Fires `hook_bat_facets_search_results_alter(&$valid_type_ids, $context)` (defined in `bat_event`).
