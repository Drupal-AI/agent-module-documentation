# Search API Date Boost — manual setup guide

**Search API Date Boost** (`search_api_date_boost`) is a Search API *processor*
that nudges more recent content higher in search results. Instead of writing a
custom sort, you let the processor add a relevance boost to each indexed item
based on how recent one of its date fields is — so newer articles, and upcoming
events, naturally rank above stale ones.

The maths behind it is straightforward once you know the shape. For each date
field you configure, the processor works out how many days old the value is
relative to now. Content dated in the **past** gets an *exponential-decay* boost:
it starts near the full boost factor and fades the older it gets, so a week-old
article still ranks well while a two-year-old one barely gets a nudge. Content
dated in the **future** always receives the *full* boost factor, which keeps
upcoming events pinned near the top until they actually happen. The boost is
*added* to whatever boost the item already has (not multiplied), and only kicks in
when both the boost factor and the decay period are positive. It's a natural fit
for time-sensitive sites — news, blogs, schedules, releases, event listings —
where recency should count toward relevance.

This is not an on-enable feature: enabling the module makes the processor
available, and you then turn it on and tune it per index. It depends on **Search
API** (`search_api`) and **Search API Database** (`search_api_db`), and it is
designed specifically for the **Database** backend (Solr/Elasticsearch support may
come later). The module has no routes, permissions, or endpoints of its own —
everything is administered inside Search API's index screens, which are already
permission-gated by Search API. Note this release (`1.0.0`) is **not covered** by
Drupal's security advisory policy.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the processor on an index and
   tune the boost factor and decay period, field by field.

## How to use it

Once installed, the module's functionality lives inside your Search API index
configuration:

1. Go to **Configuration → Search and metadata → Search API** and edit your index.
2. Open the **Processors** tab and enable **Date field-based boosting**.
3. For each date field, set a boost factor and a decay period (see
   [Configuration](configuration/index.md)).
4. Save the index and **re-index** so the new boosts are written in.
