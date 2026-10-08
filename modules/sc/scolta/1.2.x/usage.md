<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scolta provides AI-powered client-side search via Pagefind as a Search API backend.

---

Scolta **provides client-side search via Pagefind** — a Search API backend that builds a static Pagefind
index so search runs in the browser (client-side), with AI-powered relevance, avoiding a server search engine. It
depends on the Search API module and provides its own permissions.

Use it for fast static/client-side search. It is a search feature. Data-handling note: Pagefind builds a static
index of your content that is **served to the browser** — so anything indexed is effectively **public** to anyone
who can load the search; ensure only public content is indexed (respect Search API access, don't index restricted
nodes). It has no access-control role beyond its permission. Configure the Pagefind index.

---

- Provide client-side Pagefind search.
- Build a static search index.
- Run search in the browser.
- Depend on Search API + provide permissions.
- Serve search.
- Avoid a server search engine.
- SERVE the static index to the browser (indexed content is effectively public).
- Index only public content (respect Search API access).
- Not index restricted nodes.
- Have no access-control role beyond permission.
- Configure the Pagefind index.
- Handle client-side search.
- Search content.
- Configure the index.
- Build the index.
- Handle the search.
- Serve results.
- Index content.
- Limit to public content.
- Provide Pagefind search.
