<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Location Views adds Views integration for Search API Location: it exposes a proximity filter, contextual filters (arguments) and a distance sort on any Search API index field that has the `location` data type.

---

This submodule implements `hook_views_data_alter()` and, for every Search API index field whose data type is `location`, wires up Views handlers on that field's Views table (`search_api_index_<index>`). The location field gets a **filter** (handler id `search_api_location`) — an exposed distance/proximity filter that reuses Search API Location's Location Input plugins (raw, map, geocode) to collect a centre point and radius — and a **contextual filter/argument** (`search_api_location_point`) so a point can be passed in the URL. Search API backends that expose a per-result distance pseudo-field (e.g. Solr, as `<field>__distance`) also get a **sort** handler (`search_api_location_distance`) to order results by distance and an argument (`search_api_location_radius`) on that pseudo-field; filtering on the pseudo-field is removed because the location field itself handles it. It has no configuration UI of its own — you add these handlers on a Search API view the normal way once the index field is typed as `location`. The backend must actually support location/distance queries (Solr) for results to be correct.

---

- Add an exposed "within X km of here" proximity filter to a Search API view of places.
- Sort a search results view by distance from the searched location (Solr backend).
- Pass a search origin point as a contextual filter (argument) in the view's URL.
- Build a "stores near me" listing that orders by nearest first.
- Combine a location filter with keyword search and other Search API filters in one view.
- Offer a radius dropdown (5/10/25 km) on the exposed filter via the Location Input plugin settings.
- Let editors preview proximity results in the Views UI without writing queries.
- Expose the distance of each result for display using the distance pseudo-field.
- Use the raw lat/lon Location Input in a view filter for precise coordinate searches.
- Use the map or geocoded Location Input (with the other submodules) as the view's filter widget.
- Provide a contextual radius argument so a page can hard-code its search radius.
- Restrict a view to results near a taxonomy term's or node's stored coordinates via an argument.
- Add proximity search to an existing Search API view by changing the field's data type to location.
- Order a directory of members/venues by distance for a given postcode (with geocoding).
- Feed the proximity view into a block for a "nearby" sidebar.
- Reuse one index for both a distance-sorted view and a keyword search.
- Drive a REST/JSON export view of nearby items for a decoupled front end.
- Combine with facets to let users both draw a map area and sort by distance.
- Show the N closest results by pairing the distance sort with a Views pager/limit.
- Let a contextual filter supply coordinates from the current user's saved location.
