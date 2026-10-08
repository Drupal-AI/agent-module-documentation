# Search API Solr Boost By User Term — manual setup guide

**Search API Solr Boost By User Term** (`search_api_solr_boost_by_user_term`) adds
a Views filter that personalises search ranking: content tagged with taxonomy terms
that match terms referenced on the **current user's profile** is boosted higher in
the results. If a user has set their favourite animal to "elephant" in their
profile, content tagged "elephant" rises up their search results.

You add the **Boost by User Term** filter to a Solr-backed search View and choose
which user field to read the value from and which node field to boost against. You
can add more than one such boost with different strengths — an ecommerce site might
boost strongly on gender, moderately on favourite colour, and weakly on favourite
category. Support beyond nodes is likely possible where the field machine name
matches; explicit multi-entity support may come later.

It works purely at the query/ranking layer and has no access-control role. It
depends on core **Views**, **Search API**, **Search API Solr**, and the **User
Reference Field Cache Context** module (which gives proper caching of the
personalised results), and runs on Drupal 8.8 through 11. This release is covered
by Drupal's security advisory policy.

If you would rather *filter* results down to only those that match a user's
profile, rather than boosting them, the module's own documentation points you to
the separate **Views User Term Filter** project instead.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin settings page; the boost is a Views filter:

1. Build a **View** on a Search API Solr index.
2. Add the **Boost by User Term** filter.
3. In the filter, choose the **user field** to take the value from and the **node
   field** to apply the boost to.
4. Optionally add further Boost by User Term filters with different boost values to
   weight several interests differently.

Two practical notes from the module's own documentation: it does not yet validate
that the two taxonomy reference fields point at the same vocabulary — if they don't
line up, the worst case is simply that nothing gets boosted. And if you use this
with **Acquia Search**, you must uncheck the **Enable eDisMax** option in the
"Acquia Search Solr" fieldset for your index, or the boost will not take effect.
