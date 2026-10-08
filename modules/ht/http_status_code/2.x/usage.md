<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Status Code lets an administrator map specific request paths to a chosen HTTP status code (for example returning `410 Gone` for a removed page), which a response event subscriber applies on every request.

---

The intended use is SEO / index hygiene: manually returning `410 Gone` for a deleted URL makes search engines drop it from the index, and the module's own help warns that "fiddling with HTTP Headers could make both browsers and Google confused." Configuration is stored as `http_status_entity` config entities (id, label, url, status_code), managed through an entity CRUD UI at `/admin/config/http_status_code/...`. At runtime `HTTPStatusSubscriber::onRespond()` loads the entity whose `url` matches the current `getRequestUri()` and, if found, calls `$response->setStatusCode()`.

Two things an operator should know. Performance: the subscriber runs a `loadByProperties(['url' => ...])` lookup for the request URI on *every* response, so large numbers of mappings add overhead on each page. Access control: the entity CRUD routes are correctly gated behind the `administer http status code` permission (via `AdminHtmlRouteProvider`), **but** the separate settings form route (`/admin/config/http_status_code/settings`) is declared with `_access: 'TRUE'`, so it is reachable and submittable by anonymous users. That form only toggles a single `automatic_410` flag that is documented as "not implemented yet", so the practical impact is limited to writing an inert config value — but it is still a missing access check that should be fixed.

---

- Return `410 Gone` for a removed page so search engines deindex it
- Map any request path to any HTTP status code
- Add a path→status mapping through the entity CRUD UI
- Edit an existing status mapping
- Delete a status mapping when the page is restored
- List all configured status mappings in one place
- Export the mappings as configuration (they are config entities)
- Force a `404 Not Found` on a legacy URL
- Signal `503 Service Unavailable` for a temporarily withdrawn path
- Restrict mapping management to the `administer http status code` permission
- Understand that the subscriber overrides the status of every matching response
- Match paths exactly, including leading slash and query string
- Audit the per-request config lookup as a performance consideration on large mapping sets
- Add a `_permission` requirement to the settings route before production use
- Deindex an entire retired section by mapping each of its paths to 410
- Combine with SEO tooling to clean up crawl errors
