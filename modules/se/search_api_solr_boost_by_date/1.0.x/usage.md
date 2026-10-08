<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr Boost By Date adds a Views filter that boosts indexed date fields, so more recent (or date-weighted) content ranks higher in Solr search results.

---

Search API Solr Boost By Date provides a special Views filter that applies a date-based boost to
Solr search results. On a Search API Solr index, it lets you weight an indexed date field into the
relevance score, so that (for example) newer content ranks higher — a common requirement for news,
articles and time-sensitive listings where recency should influence ranking, not just text relevance.

Use it on a Views-based Solr search where you want recency to affect ordering while keeping full-text
relevance. It depends on core Views, Search API and Search API Solr, and operates at the query/ranking
layer (it shapes the Solr boost, not access). Configure it as a filter on the search View and tune the
boost against the indexed date field.

---

- Boost Solr results by an indexed date field.
- Rank newer content higher in search.
- Add recency weighting to Solr ranking.
- Configure a date-boost Views filter.
- Keep full-text relevance while favouring recency.
- Apply to a Search API Solr index.
- Tune the date boost strength.
- Use on news or article search.
- Depend on Views, Search API and Search API Solr.
- Weight a date field into the score.
- Improve time-sensitive search ordering.
- Operate at the query/ranking layer.
- Filter a search View by date boost.
- Favour recent listings.
- Shape the Solr boost, not access.
- Combine relevance and recency.
- Rank by date-weighted score.
- Add to an existing Solr search View.
- Boost by publish or changed date.
- Tune ranking for freshness.
