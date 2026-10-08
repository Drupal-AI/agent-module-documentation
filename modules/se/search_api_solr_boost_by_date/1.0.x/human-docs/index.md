# Search API Solr Boost By Date — manual setup guide

**Search API Solr Boost By Date** (`search_api_solr_boost_by_date`) adds a Views
filter that lets you weight an indexed **date field** into a Solr search's
relevance score — so that more recent content ranks higher without you having to
write any code. It is the classic "newest first, but still by relevance" behaviour
that news, articles and other time-sensitive listings usually want.

Search API Solr does not offer date boosting from the UI on its own — normally you
would have to alter the query programmatically. This module turns that into a
point-and-click Views filter: add it to a Solr-backed search View and it shapes the
Solr boost for you. It works at the query/ranking layer only — it influences the
order results come back in, not who is allowed to see them.

**Note that this module is deprecated.** Since Search API Solr 4.1.12, date
boosting is supported by Search API Solr itself, so you only need this module if
you want to set *different* date boosting for multiple Views that share the same
Search API index. It is marked "seeking new maintainer" with no further
development planned — for a new site on a current Search API Solr, prefer the
built-in feature.

It depends on core **Views**, **Search API** and **Search API Solr**, and works
across Drupal 8.8 through 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin settings page; you configure the boost as a Views filter. The
typical setup is:

1. Create a Search API Solr **server** and an **index**.
2. Make sure the index has at least one **Date** field — the node's *Authored on*
   (`created`) field is a common choice.
3. Create a **View** based on that Search API index.
4. Set the View to sort **by relevance, descending**.
5. Add the **Boost by Date** filter to the View.
6. Optionally tune the boost parameters that control how strongly recency
   influences the score, so you can balance freshness against text relevance.

Save the View and your results will be ordered by a date-weighted relevance score.
