<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# linked_data_field — endpoints & plugins

**Create endpoints:** Structure → Linked Data Lookup Endpoint → Add. Pick a
type plugin and fill its settings:

- **SparqlQuery** — `base_url` (SPARQL endpoint); the typed string is sent as a
  GET query; `label_key` / `url_key` select fields from the JSON result.
- **LoCAuthority** — Library of Congress suggest API at `base_url`.
- **URLArgument** — generic JSON API; `base_url` + appended argument,
  `result_json_path` (root), `label_key`, `url_key`.

**Field use:** add the Linked Data field to a bundle; the autocomplete widget
hits `/linked-data-lookup/{endpoint}?q=...` (authenticated users only) and
stores `label` plus the URI captured as `label - [[uri]]`. Pass
`?_ldquery_debug=1` to surface debug info from `getSuggestions()`.

**Extend:** add a `@LinkedDataEndpointTypePlugin` implementing
`getSuggestions()` / `postProcessResponse()` for another API. Requests use the
`httpClient` service (Guzzle, default certificate verification).
