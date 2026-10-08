<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vertex AI Search provides for creation of search pages using Google Vertex AI Search.

---

Vertex AI Search lets you create search pages powered by Google Vertex AI Search (Google Cloud's
enterprise/generative search) — so site search queries are answered by Vertex AI Search over your indexed
content/data store. It depends on core Search and Token, provides its own permissions.

Use it to build AI-powered search pages via Google Vertex. Security notes: it authenticates to Google Cloud
with credentials (a service-account key / OAuth) — **store those as secrets**, not in exported config;
queries and possibly content are sent to Google (a data-handling consideration); and ensure the search
respects content access (results should not surface content the requester shouldn't see — verify the
indexed data store / result handling doesn't leak restricted content). It has no access-control role beyond
its permission. Configure the Vertex AI Search data store and credentials.

---

- Create Vertex AI Search pages.
- Power site search with Google Vertex.
- Answer queries over a data store.
- Depend on core Search and Token.
- Provide its own permissions.
- Store Google Cloud credentials as secrets.
- Avoid credentials in exported config.
- Mind queries/content sent to Google.
- Ensure search respects content access.
- Not surface restricted content.
- Verify the data store doesn't leak.
- Have no access-control role beyond permission.
- Configure the Vertex data store.
- Build AI-powered search.
- Handle credentials securely.
- Configure the credentials.
- Search with Vertex AI.
- Create search pages.
- Handle enterprise search.
- Configure Vertex search.
