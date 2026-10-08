<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Coveo Integration provides a Search API backend integration with the Coveo search engine.

---

Search API Coveo Integration provides a Search API backend for Coveo — the enterprise/AI-powered search
platform — so Drupal content is indexed into Coveo and search queries are served by Coveo. It ships a
`search_api_coveo_keys` submodule (key management) and depends on the Search API module, in the Search
package.

Use it to power site search with Coveo. Security notes: it authenticates to Coveo with API keys — **store
those as secrets** (the keys submodule/Key integration helps), operate over HTTPS, and ensure the search
respects content access (results shouldn't surface content the requester can't see — Coveo's security model +
your index config govern this). It has no access-control role of its own. Configure the Coveo connection and
index.

---

- Provide a Coveo Search API backend.
- Index Drupal content into Coveo.
- Serve search via Coveo.
- Ship a keys submodule.
- Depend on the Search API module.
- Use Coveo's enterprise/AI search.
- Store Coveo API keys as secrets.
- Operate over HTTPS.
- Ensure search respects content access.
- Not surface restricted content.
- Have no access-control role of its own.
- Configure the Coveo connection.
- Handle Coveo integration.
- Index into Coveo.
- Configure the index.
- Handle credentials securely.
- Search with Coveo.
- Configure Coveo.
- Handle the backend.
- Power search with Coveo.
