<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Project Browser API Browser turns any external JSON API into a Project Browser source, so administrators can browse a curated project list from inside the site.

---

Each API you connect to is stored as an "API Browser Service" configuration entity, and every service is derived into its own Project Browser source plugin that appears as a tab under Extend. A service names a listing endpoint (the set of projects) and, optionally, a per-project endpoint that fills in detail; JMESPath selects the records out of each JSON response and a set of Twig templates maps them onto the fields Project Browser expects (title, machine name, description, type, usage, categories, images, and so on). Authentication can be an API key, bearer token, basic auth or OAuth 2.0 client credentials, and with the optional Key module the secret is read from a key rather than stored in configuration. Endpoints that page by number or by cursor are supported, requests are sent concurrently and retried with a backoff when the API returns 429/503, and results are cached and rebuilt when a service is saved or refreshed. Six example services pointing at packagist.org ship with the module as starting points, and each endpoint can be test-fired from the service form. Requires Drupal 11.2+/12, Project Browser 2.1+ and PHP 8.3+; administration is gated by the `administer api_browser_service` permission.

---

- Expose a private or internal module registry as a Project Browser tab.
- Serve a curated catalog of vetted modules to site builders.
- List Drupal modules, themes or recipes published on packagist.org.
- Connect Project Browser to a composer/satis repository's JSON index.
- Aggregate projects from a company-internal package index.
- Map an arbitrary JSON API's fields onto Project Browser projects with Twig.
- Select records out of a nested JSON response using JMESPath paths.
- Authenticate to an API with an API key placed in a header or query parameter.
- Authenticate with a bearer token, basic auth, or OAuth 2.0 client credentials.
- Keep API secrets out of exported configuration using the Key module.
- Page through large listings by page number or by cursor.
- Fetch thousands of project detail records concurrently to fill a cold cache.
- Automatically retry rate-limited (429) or unavailable (503) responses with backoff.
- Filter out unwanted records before their detail endpoint is ever requested.
- Filter out projects after fetching, using the full project data.
- Define a category vocabulary and drive Project Browser's category filter from it.
- Test a listing or project endpoint from the form and inspect the raw response.
- Log every request a live service makes (method, URL, status, duration) for diagnosis.
- Duplicate an existing working service to start a new one from a known-good config.
- Refresh a service's cached projects on demand from the services list.
- Add search parameters (including repeated `fields[]` parameters) to every request.
- Restrict a listing to a single vendor or project type via a Twig filter.
- Present externally-hosted logos and screenshots for each listed project.
