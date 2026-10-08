# Similar By Terms — manual setup guide

**Similar By Terms** (`similarterms`) helps you build "related content" listings
driven by taxonomy. If two pieces of content share tags, they're probably related —
this module turns that idea into three Views handlers you can drop into a view: a
**contextual filter** that finds content sharing a given node's terms, a **sort**
that ranks results by how similar they are, and a **field** that shows the
similarity score. Put them together and you get a "Related articles" or "You might
also like" block with no custom SQL.

Similarity is measured from the taxonomy terms content has in common. You can tune
it: limit the comparison to certain vocabularies (say, only "Topics" and ignore
"Content type"), include or exclude the source item itself, and enforce a minimum
match — 25%, 50%, 75%, or a 100% exact‑match. The field can show similarity as a
raw count of shared terms, as a percentage of the source's terms, or as the summed
**weight** of matching terms, and the sort can order by either count or weight. Term
weight is the standard taxonomy weight, so you can make important tags (brand,
price, series) dominate recommendations over minor ones.

By default the handlers work on **nodes**, using Drupal core's `taxonomy_index`
table — which means only published nodes are eligible. If you also enable the
optional [Taxonomy Entity Index](https://www.drupal.org/project/taxonomy_entity_index)
module, the same handlers appear on **every** content entity type — media, users,
custom entities — so you can recommend similar profiles by shared interests, similar
products by shared attributes, and so on.

There's no admin page, no permissions, and no Drush — everything is configured per
view and travels with your exported view configuration. The module depends on core
**Taxonomy** and **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus the optional Taxonomy Entity Index companion).

## Where it lives in the admin menu

There's no settings page. The three handlers show up inside the **Views UI**
(**Structure → Views**, `/admin/structure/views`), grouped under **"Similar by
terms"** when you add a contextual filter, sort, or field to a view.

## How to use it

The classic setup is a "related content" block on node pages:

1. Enable the module (see [Installation](installation/index.md)).
2. Create a view of **Content** with a **Block** display.
3. Under **Advanced → Contextual filters**, add **Similar by terms: Nid**. Set its
   default value to the current node (for example, "Content ID from URL") so the
   block knows which node to find matches for. On the filter's options you can:
   - restrict **vocabularies** so only chosen tag types count toward similarity,
   - leave the source node **excluded** (the default) so the list never links to
     the page you're on,
   - set a **minimum match percentage** to hide weak matches (100% means an exact
     term set).
4. Under **Sort criteria**, add **Similar by terms: Similarity** (descending) and
   choose to order by matching‑term **count** or by matching‑term **weight**.
5. Optionally add the **Similar by terms: Similarity** field to display the score —
   as a count, a percentage (with a `%` suffix), or a summed weight.
6. Save the view and place the block on your node pages.

Because the contextual filter uses a LEFT join, items with no matching terms can
still appear (ranked last), which lets the sort "fill" a fixed‑size block. Add a
secondary sort — random or by date — to break ties when similarity is equal.

> **Beyond nodes:** to build similarity lists for media, users, or custom
> entities, enable **Taxonomy Entity Index** and re‑index. The same handlers then
> appear on those entity types (the contextual filter is labelled "Content ID"),
> reading from that module's cross‑entity index table instead of core's node‑only
> one.
