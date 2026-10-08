<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scolta provides AI-powered client-side search via Pagefind as a Search API backend.

---

Scolta **provides client-side search via Pagefind** — a Search API backend that builds a static Pagefind
index so search runs in the browser (client-side), with configurable relevance scoring and optional AI-powered
query expansion, result summarization and follow-up questions. It depends on the Search API module and provides
its own permissions (`administer scolta`, `use scolta ai`).

Use it for fast static/client-side search with no server search engine (no Solr/Elasticsearch). It is a search
feature. Data-handling note: Pagefind builds a static index of your content that is **served to the browser** — so
anything indexed is effectively **public** to anyone who can load the search. The gatherer indexes only
**published** entities but does not enforce per-user/entity view access, so ensure only public content is indexed
(respect Search API access, don't index access-restricted nodes). The optional AI endpoints (`/api/scolta/v1/*`)
are gated by the `use scolta ai` permission plus a decoratable feature access check, with fail-closed flood
limits; the anonymous role is not granted that permission by default. Outbound LLM calls use Drupal's HTTP client
(TLS verified) against an admin-configured provider URL. Build the Pagefind index with `drush scolta:build` and
place the Scolta Search block.

---

- Provide client-side Pagefind search as a Search API backend.
- Build a static search index at publish time.
- Run search entirely in the visitor's browser (Rust/WASM engine).
- Avoid a server search engine (no Solr, no Elasticsearch, no managed service).
- Re-rank results with tunable relevance scoring (title/content boosts, recency decay, phrase proximity, exact-title boost).
- Optionally expand queries with an LLM for better recall.
- Optionally summarize search results and suggest follow-up questions.
- Route AI through the built-in client, the Amazee.ai managed gateway, or the Drupal AI module (48+ providers).
- Serve the static index to the browser (indexed content is effectively public).
- Index only published, public content and respect Search API access.
- Gate the AI endpoints behind `use scolta ai` plus a decoratable per-feature access check.
- Rate-limit the AI endpoints per-IP and site-wide (fail closed).
- Build, rebuild, export and monitor the index with Drush commands.
- Run chunked, resumable index builds with memory budgets for large or shared-hosting sites.
- Scope a build to specific bundles or entity IDs.
- Auto-rebuild incrementally when nodes are inserted, updated or deleted.
- Offer search-as-you-type suggestions with recent-search history.
- Configure facet index loading (eager, deferred, or disabled).
- Place a ready-made Scolta Search block via Block layout.
- Deploy the browser bundle (JS/CSS/WASM) from the installed scolta-php on every cache rebuild.
- Expose an anonymous status-only health endpoint for uptime monitors.
- Limit indexed content to public content.
