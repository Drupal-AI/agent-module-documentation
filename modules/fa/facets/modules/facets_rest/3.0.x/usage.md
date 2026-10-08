Rest Facets exposes configured facets in the output of a REST-export Views display over a Search API index, so a decoupled/headless front end receives the available facets and their counts alongside the search results.

---

This facets submodule provides a Views style plugin (`FacetsSerializer`) that extends the REST/serializer style so that, in addition to the serialized rows, the response includes the facets attached to that view display — each facet with its values, counts, and active state. It is meant for a "REST export" Views display backed by a Search API index, giving JavaScript apps or external clients everything they need to render their own facet UI and build filter URLs. It relies on the core REST module and Facets; facets are configured normally at the Facets admin page and bound to the view's REST display as their source. A config schema is added for the serializer style. Use it whenever a JS/SPA, mobile app, or external service needs faceted search data as JSON.

---

- Return facets and counts as JSON from a REST-export view.
- Power a React/Vue/Angular search UI with server-computed facets.
- Feed faceted filter options to a mobile app.
- Build a headless catalog with brand/category/price facets over REST.
- Let an external service consume search facets programmatically.
- Render custom facet widgets client-side from REST facet data.
- Provide active-facet state to a decoupled front end for filter chips.
- Serve facet counts for a live-updating search-as-you-type UI.
- Expose facets for a Next.js/Gatsby statically-generated search page.
- Include facets in a JSON:API-adjacent REST search endpoint.
- Give a third party a documented faceted search API.
- Drive a map-based search with facet filters over REST.
- Return only facets for a lightweight "filters" endpoint.
- Support offline-capable apps caching facet metadata.
- Combine serialized search rows and facets in one HTTP response.
- Localize facet labels in the REST output for multilingual clients.
- Build a voice/assistant search that reads back available filters.
- Provide facet data to a design-system search component.
- Expose faceted search to a partner portal.
- Prototype a decoupled search UI without a Drupal front end.
