A Postman-style REST client embedded in the Drupal admin UI for building, sending, and inspecting arbitrary HTTP requests.

---

API Tester adds a single-page tool at `/admin/config/development/api-tester` (Configuration » Development » API Tester) that lets developers and site builders compose HTTP requests — method, URL, query params, headers, body, and authentication — and send them through the Drupal server via Guzzle. Responses are shown with status, timing, size, headers, and a pretty/raw/preview body view. Requests can be run as another site user to check permission logic, saved as personal presets in the State API, and exported as ready-to-run code snippets in more than a dozen languages. It requires only Drupal core and Guzzle, defines the `use api tester` and `administer api tester` permissions, and stores no configuration entities.

---

- Test an internal Drupal REST/JSON:API endpoint without leaving the admin UI.
- Send GET, POST, PUT, PATCH, DELETE, HEAD, or OPTIONS requests to any external API.
- Add and toggle custom request headers (e.g. `Content-Type`, `Accept`).
- Attach query parameters that auto-sync with the URL bar.
- Send a JSON, XML, or plain-text request body.
- Send `application/x-www-form-urlencoded` form-data as key/value pairs.
- Authenticate with a Bearer token.
- Authenticate with HTTP Basic auth (username + password).
- Authenticate with an API key placed in a header or appended to the query string.
- Reuse the current Drupal session cookie and an injected `X-CSRF-Token` to hit session-protected routes.
- Re-run a request as a different site user via "Test as User" to verify access-control and permission logic.
- Inspect response status code, reason phrase, round-trip time, and payload size.
- View JSON responses as a collapsible tree, raw syntax-highlighted text, or a table preview.
- View a non-JSON (HTML/text) response in the preview pane.
- Read back all response headers returned by the endpoint.
- Save a fully configured request as a named preset for quick recall.
- Update, duplicate, or delete saved presets from the sidebar.
- Search your saved presets by name.
- Generate a cURL command from the current request.
- Generate client code for JavaScript (Fetch/XHR/Axios), Python, PHP (cURL/Guzzle), Node, Ruby, Go, Java, or C#.
- Copy a generated snippet to the clipboard for use elsewhere.
- Debug why an API call returns a 401/403 by re-sending it under different roles.
- Confirm CORS/redirect behavior by watching status and headers on each send.
