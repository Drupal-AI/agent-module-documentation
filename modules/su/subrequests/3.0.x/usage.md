<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Subrequests adds a `/subrequests` front-controller endpoint so a client can bundle many independent HTTP API calls into a single POST (a "blueprint") and receive one combined multi-response instead of making N separate round trips.

---

The module accepts a JSON array of subrequest objects, each describing an inner HTTP call (`uri`, `action`, `headers`, `body`, `requestId`), and executes them all internally against Drupal's own `http_kernel`, reusing the master request's cookies/session so each subrequest runs with the caller's normal permissions. Subrequests with no `waitFor` dependency run in one parallel batch; a subrequest can declare `waitFor: ["req-1"]` to defer until another finishes, letting later requests read data out of earlier responses via a `{{requestId.body@$.jsonpath}}` replacement token (evaluated by the `JsonPathReplacer` service using a JSONPath library). Access is gated by a single `issue subrequests` permission on the `/subrequests` route, which accepts `basic_auth`, `cookie`, `oauth2`, and `token_bearer` authentication. The endpoint always returns HTTP 207 (Multi-Status): by default the body is a `multipart/related` document with one part per subrequest, keyed by `Content-ID`, but appending `?_format=json` (or an `Accept: application/json` on the master request) instead returns a single JSON object keyed by each subrequest's `requestId`. Internally, `BlueprintManager` parses the payload into a `SubrequestsTree` (an ordered stack of parallel batches) and combines the resulting responses; `SubrequestsManager` walks that tree batch by batch, denormalizing each `Subrequest` value object into a real Symfony `Request` and dispatching it through the kernel. The module ships no settings form, no config schema, and no Drush commands — its only configurable surface is the one permission and whatever the client sends in the blueprint itself.

---

- Fetch a node, a related taxonomy term, and a block of recent content in one HTTP round trip instead of three.
- Build a mobile app "screen" endpoint that assembles several independent API resources into a single response.
- Chain a `create` subrequest (e.g. add a comment) to a prior `view` subrequest that resolved the parent node's ID.
- Reduce client-side request waterfalls by expressing dependent calls (`waitFor`) that Drupal executes server-side.
- Use JSONPath response embedding (`{{req-1.body@$.id}}`) to pass an ID from one subrequest's JSON body into the next subrequest's URI.
- Pass data from one subrequest's response into another subrequest's POST body via a body-location token.
- Request several JSON:API or REST resources at once and get back one 207 Multi-Status multipart/related response.
- Request the JSON aggregate form instead (`?_format=json`) to get a single object keyed by `requestId` for easier client-side parsing.
- Grant a decoupled front-end application the `issue subrequests` permission so it can batch calls without hitting rate limits per-call.
- Use `action: "create"`, `"update"`, `"replace"`, `"delete"`, `"exists"`, or `"discover"` per subrequest to map onto POST/PATCH/PUT/DELETE/HEAD/OPTIONS respectively.
- Send the blueprint as a `POST` body or, for cacheable read-only batches, as a percent-encoded `query` parameter on a `GET /subrequests` request.
- Authenticate the master request with `basic_auth`, `cookie`, `oauth2`, or `token_bearer` — the chosen auth context is reused for every subrequest inside the batch.
- Build a single "dashboard" call that issues several `view` subrequests to different REST/JSON:API resources in parallel.
- Avoid N+1 client requests when a decoupled front end needs data from several unrelated endpoints on page load.
- Perform a multi-step write operation (e.g. create a node, then create a paragraph referencing it) atomically from the client's perspective in one call.
- Give each subrequest its own `requestId` so the client can correlate each part of the combined response back to the request that produced it.
- Rely on the module's automatic Content-ID header matching to identify which part of a `multipart/related` response corresponds to which subrequest.
- Bundle several `view` requests to paginate through related collections without issuing separate HTTP connections.
- Use the `subrequests.blueprint_manager` service directly from custom PHP code to parse and execute a programmatically built blueprint.
- Use the `subrequests.json_path_replacer` service standalone to understand or reuse the token-replacement logic elsewhere.
- Reduce mobile client battery/network usage by trading several small HTTP requests for one bundled request.
- Compose a blueprint where a single JSONPath match against an array yields multiple values, causing the module to fan out one subrequest per matched value.
- Restrict the front controller to trusted API consumers only by granting `issue subrequests` to a dedicated integration role instead of `authenticated user`.
- Debug a subrequests batch by inspecting each part's `Content-ID`, `Status`, and body in the combined multipart response.
- Feed a client-generated blueprint (e.g. from a GraphQL-like batching client) into the `/subrequests` endpoint without writing custom backend glue code.
