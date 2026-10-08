<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Connect to the Searchify API to run search queries (with a public search UI).

---

Searchify Connector connects to the Searchify API to perform search queries — providing a search page and a streaming (SSE) endpoint that forward visitor queries to the Searchify hosted search/AI service and stream results back, so a site can offer Searchify-powered search.

Configure the API credentials securely through the admin interface (env-backed / Key); the API key stays server-side and is not exposed to the client. The `/searchify` search page and `/searchify/stream` SSE endpoint are public by design (a site search feature) — consider rate-limiting to bound paid-API cost. Depends on core `system`; supports Drupal 10 and 11. Project `searchifyai`.

---

- Connect to the Searchify API.
- Run search queries.
- Provide a search page.
- Stream results via SSE.
- Keep the API key server-side.
- Store credentials securely.
- Serve a public search feature.
- Consider rate-limiting for cost.
- Depend on core `system`.
- Support Drupal 10 and 11.
- Handle Searchify search.
- Query the SaaS
- Support Drupal.
- Support Drupal.
- Support Drupal.
