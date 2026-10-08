<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `overpass` service — talking to the Overpass API

Service id **`overpass`** → `Drupal\openstreetmap\Overpass` (`openstreetmap.services.yml`),
constructed with `@database`, `@http_client` (Guzzle), `@config.factory`. It is the single point of
external HTTP in the project; get it via `\Drupal::service('overpass')`.

## Methods (from `src/Overpass.php`)

- `query(string $query): string` — reads `openstreetmap.settings:endpoint`; throws if unset.
  Issues `httpClient->request('GET', $endpoint, ['query' => ['data' => $query], 'timeout' => 25])`
  and returns the raw body. **The endpoint is the admin-configured interpreter URL; the `$query` is
  the Overpass QL sent as the `data` parameter.**
- `json(string $query)` — wraps as `[out:json];{$query}out;` then `json_decode`.
- `node(int $node_id)` — `json("node($node_id);")`, returns the first element.
- `way(int $way_id)` — `query("[out:json];way($way_id);out geom;")`, first element (includes
  geometry).
- `nodesFromQuery($query, $bundle = 'default')` — decodes the response and sets a Drupal **batch**
  whose operations call `OSMNode::saveFromElement($element, $bundle)` for each returned element.

## How queries are built / where they come from

- `OSMNode::save()` calls `node()`/`way()` with the entity's numeric `osm_id` (cast to `int`).
- `OSMImportForm` and the `osm_query` entities (queries submodule) supply the free-form Overpass QL.
  `OSMImportForm::submitForm()` normalizes it (`[out:json];` prefix, `out geom;` suffix) before
  calling `nodesFromQuery()` / `query()`.

## Operational notes

- **Endpoint is not request-controlled** — it is the site setting `openstreetmap.settings:endpoint`.
  The remote host is fixed by an administrator, not by end-user input.
- TLS: the call uses the standard Drupal Guzzle `http_client`; no client options disable
  certificate verification.
- Requests carry no API key/token (public Overpass instances are unauthenticated); nothing secret is
  placed in the URL.
- 25-second timeout per request; large area queries can be slow — the module warns about this on the
  Sync form when the queries submodule is present.
- Responses are decoded with `json_decode`; a malformed/empty response yields no elements and the
  batch simply adds nothing.
