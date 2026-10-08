<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr Boost By Date — agent index

Views filter that **boosts Solr search results by an indexed date field** (recency ranking) — newer/
date-weighted content ranks higher while keeping full-text relevance. Depends on `views`, `search_api`,
`search_api_solr`. Version **1.0.3**. Core `^8.8||^9||^10||^11`.

Query/ranking layer (not access). Configure as a filter on the search View; tune the boost.
