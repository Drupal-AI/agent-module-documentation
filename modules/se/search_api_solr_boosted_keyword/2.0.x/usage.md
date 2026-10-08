<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr: Boosted Keyword adds a field where editors enter keywords each with a boost level, so a Solr-indexed document ranks higher for the terms someone decided matter for it — no code, no index-wide rules.

---

Relevance tuning usually happens at the index level: boost the title field, boost recent content, boost a content type. That is blunt, because relevance is often per-document — this page is the canonical answer for "password reset" even though the phrase appears only twice, and that product page should surface for the product's old name, which appears nowhere in its body. This module handles both by giving each entity a `search_api_solr_boosted_keyword` field: a repeatable pair of a keyword string and a boost level (an integer 1–20). The mechanism has two halves and both are driven by a Search API Solr event subscriber, not by a Search API processor. At **index time** (`PostCreateIndexDocumentsEvent`) each keyword is written into the Solr document repeated once per boost level — boost 5 means the word appears five times — with internal spaces stripped so multi-word phrases survive as a single token. At **query time** (`PreQueryEvent`) the module rewrites the query to `defType=edismax`, escapes each search term with Solarium's helper, and adds a `termfreq(field,term)^boost` boost function for every boosted-keyword field (the `^boost` here is the Search API *field* boost); it also removes those fields from the edismax query-fields (`qf`) so they contribute to ranking rather than to matching. Net effect: term frequency (set by the per-keyword boost) times the field boost decides how much a document is lifted for a query. A `search_api_solr_boosted_keyword.keywords_overview` admin form at `/admin/config/search/keywords` (permission `administer boosted keywords overview`) lists every boosted keyword across node fields — filterable by content type, language and status — and exports the lot to CSV. Version **2.0.0-beta3**, a **beta**, requiring `search_api_solr >= 4.x` and core `field`. Three things to hold in mind. **Boosting is a relevance signal, not a filter** — a boosted document ranks higher for a term it already matches and does not appear for terms it matches nowhere, which is the commonest misunderstanding. **Boosts compete** — when every editor boosts their own page the effect cancels, which is why the site-wide overview exists and why someone has to actually govern it. And **the field is index data** — a change takes effect only after that item is reindexed.

---

- Boost a page for a specific search term without touching global index config.
- Surface a canonical support article first for a common query.
- Rank a product page for the product's old or discontinued name.
- Make a page findable by a synonym that appears nowhere in its text.
- Give content editors per-document control over search ranking.
- Boost a policy page for the colloquial term users actually search.
- Add campaign or seasonal keywords to a landing page for a limited push.
- Fix a persistently poor result for a known, high-traffic query.
- Weight a knowledge-base answer above near-duplicate lower-quality pages.
- Promote a service page for a term the marketing copy avoids.
- Add multiple keywords with different boosts to one document.
- Boost a multi-word phrase (spaces are stripped so it indexes as one token).
- Support an editor-curated site search programme.
- Audit which keywords are boosted site-wide via the overview form.
- Filter the boosted-keyword overview by content type, language or status.
- Export all boosted keywords and their pages to CSV for review.
- Detect keyword-boost inflation where everyone boosts their own content.
- Give a field-level, revisionable, reviewable home to relevance decisions.
- Rank a translated node for language-specific keywords.
- Tune relevance for content whose important terms are visual or in metadata.
- Provide a governable alternative to hard-coded Solr boost queries.
