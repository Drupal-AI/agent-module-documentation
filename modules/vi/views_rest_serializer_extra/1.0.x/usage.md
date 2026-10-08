<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Results Serializer Extra adds one Views **style plugin** for REST Export (`data`) displays that wraps the serialized rows in a metadata envelope — pager counts, exposed filters and sorts, optional Facets, and a typeahead path — instead of returning a bare array of rows.

---

The core "Serializer" style on a Views REST Export display returns exactly the rows as a flat JSON (or XML) array, which is enough for a static list but not enough to build a search UI: a decoupled front end still needs the total count, the page count, which exposed filters and sort options exist, and — for faceted search — the available facets. This module ships a single style plugin (`ResultsSerializer`, id `views_rest_serializer_extra`) that subclasses core `rest`'s `Serializer`: it calls the parent to serialize the rows, then assembles an envelope keyed `results`, `pager`, `filters`, `sorters`, `system`, and (optionally) `facets` / `facets_metadata`, and serializes the whole structure with the display's negotiated format. Pager data is read from the view's `SqlBase` pager (current page, total results, total pages, items per page, and the exposed items-per-page options); `filters` lists the exposed filter keys actually present in the request; `sorters` lists each exposed sort with its label, identifier and whether it is selected, plus the active `sort_order`. If the contrib **`facets_rest`** module is installed and the display's "Show facets" checkbox is on, it builds every facet configured against this view's REST facet source and emits both the rendered facet results and a compact `facets_metadata` map (label, weight, field id, url alias, has_results). Every top-level key label is configurable in the display's style settings, so `results` can be renamed to `data` and so on to match an existing front-end contract, and an optional typeahead path can be surfaced under `system.typeahead`. It is selected in place of the standard serializer on the display and changes nothing else about the view; dependencies are core `rest` and `serialization`, with core `^9 || ^10 || ^11`. Two things to keep in mind for consumers: the envelope **changes the response shape**, so switching an existing endpoint to it is a breaking change for anything parsing the bare array; and asking for the total count implies a count query, which is not free on a large or expensive view.

---

- Return a total result count alongside a Views REST Export.
- Give a decoupled front end the pager metadata (current page, total pages, items per page) it needs to paginate.
- Build pagination or infinite scroll in React/Vue without fetching every row to count them.
- Wrap Views REST rows in a JSON envelope (`results` + metadata) instead of a bare array.
- Show "showing 10 of 250" in a client from the returned totals.
- Expose the list of available exposed filters to a search UI.
- Expose the available exposed sort options (label, identifier, selected state) and the active sort order.
- Surface the configured items-per-page options so the front end can offer a page-size selector.
- Emit Facets (via the `facets_rest` module) directly in the REST response for a faceted search UI.
- Return per-facet metadata (label, weight, field id, url alias, whether it has results) for building facet widgets.
- Toggle facet inclusion per display without changing code.
- Rename the response keys (e.g. `results` → `data`, `total_results` → `count`) to match an existing front-end data contract.
- Provide a typeahead/autocomplete path (Search API Autocomplete or custom) to the client under `system.typeahead`.
- Back a Search API / Search API Solr search page with a single REST endpoint that carries everything the UI needs.
- Standardise the response shape of several Views exports so front-end components can share parsing logic.
- Agree a data contract between front end and back end and tweak it from the View UI rather than in code.
- Feed a mobile app's list or search view with results plus pagination in one request.
- Support a filtered, sorted, paginated API listing served entirely from Views.
- Reduce client-side guesswork about how many results and pages exist.
- Bring a JSON:API-style metadata envelope to plain Views REST Export displays.
- Prototype a hybrid/decoupled search interface quickly on top of an existing view.
