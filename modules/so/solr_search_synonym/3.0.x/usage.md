<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SOLR Search Synonym lets you manage search synonyms in Drupal and export them to Solr for use in search.

---

SOLR Search Synonym provides a UI to manage search synonyms in Drupal — defining that certain terms
are equivalent (e.g. "car" ~ "automobile") — and exports them to Solr so the search engine treats them
as synonyms, improving recall. It depends on core System (>=11), Options, Views, Search API and Search
API Solr, is configured via the `solr_search_synonym` collection, and provides its own permissions.

Use it on Search API Solr sites where editors should manage synonyms without touching Solr config files.
It is a site-search feature operating at the search/index layer; it shapes search matching, not access
(results still respect the index and entity access). Manage the synonym sets and export to Solr as part
of your search configuration.

---

- Manage search synonyms in Drupal.
- Export synonyms to Solr.
- Define equivalent terms.
- Improve search recall.
- Depend on Search API Solr.
- Configure via the synonym collection.
- Provide its own permissions.
- Let editors manage synonyms.
- Avoid editing Solr config files.
- Shape search matching, not access.
- Respect index and entity access.
- Handle car~automobile synonyms.
- Export synonym sets.
- Support Search API Solr.
- Manage synonyms via UI.
- Broaden search matches.
- Configure synonym sets.
- Improve findability.
- Sync synonyms to Solr.
- Manage query expansion.
