# Search API Solr: Boosted Keyword — manual setup guide

**Search API Solr: Boosted Keyword** (`search_api_solr_boosted_keyword`) adds a
new field type where editors enter **keywords, each with its own boost level**, so
that a specific piece of content ranks higher for the terms someone has decided
matter for it. It comes with a field type, a widget for entering the keywords, and
a formatter for displaying them.

Most relevance tuning happens bluntly at the index level — boost the title field,
boost recent content, boost a whole content type. But relevance is often
*per-document*: this page is the canonical answer for "password reset" even though
the phrase only appears twice in it, and that product page should surface for the
product's old name, which appears nowhere in its text. Putting the keywords in a
field means the decision lives with the content, shows on the edit form, travels
with a revision, and can be reviewed. Under the hood it repeats each keyword in the
Solr document as many times as its boost level, and alters Solr queries to add a
term-frequency boost per keyword — so a curated result feels intentional rather
than merely correct.

It depends on **Search API Solr 4.x or newer** and core's **Field** module, and
works across Drupal 8 through 11. It provides an `administer boosted keywords
overview` permission that gives a site-wide view of everything that has been
boosted — the piece that keeps the feature governable. Note that this release
(2.0.x) is a **beta** and the project is minimally maintained.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no central settings page. You use the module by adding a field:

1. On the content type (or other fieldable entity) you want to curate, add a new
   field of type **Search API Solr: Boosted Keyword** at **Structure → Content
   types → &lt;type&gt; → Manage fields**.
2. When editing content, editors enter one or more keywords, each with a boost
   level.
3. Make sure that field is included in your Search API Solr index, then reindex —
   the boost only takes effect once the item has been reindexed.

Grant the **Administer boosted keywords overview** permission (at **People →
Permissions**) to whoever is responsible for search quality, so they can see the
whole site's boosted keywords in one place.

## Three things to hold in mind

**Boosting is a relevance signal, not a filter.** A boosted document ranks *higher*
for a term it matches; it does **not** appear for terms it does not match at all.
This is the most common misunderstanding when someone asks why their keyword
"didn't do anything."

**Boosts compete.** If every editor boosts their own page, the effect cancels out
and you are back where you started. The overview permission exists precisely so
that someone can watch for this — but someone has to actually use it.

**The field is index data.** A change to the keywords needs a reindex of that item
before it takes effect.
