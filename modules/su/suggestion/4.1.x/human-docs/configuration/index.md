# Configuration

Suggestion works from an n-gram index it builds out of your content. The settings
page lets you choose which content feeds it and tune how many suggestions are
generated — tuning matters here, because the number of suggestions is tied to how
much content your site has.

## Open the settings form

1. Log in as a user with the **Administer suggestion** permission (an administrator
   by default).
2. Go to **Configuration → Suggestion**, or navigate directly to
   `/admin/config/suggestion`.

## The settings, and how to tune them

The suggestions come from three sources — the titles of selected content types,
priority suggestions you add here, and the searches visitors actually run — all
tokenized and broken into n-grams. The following settings control the shape and
volume of what gets generated:

- **Minimum characters** *(default 4)* — the shortest a suggestion can be.
  **Increasing this reduces the number of suggestions dramatically.**
- **Maximum characters in a suggestion** *(default 45)* — the longest a suggestion
  can be. Increasing it produces more suggestions, but this is really about matching
  the size of your text field rather than controlling volume.
- **Minimum words in a suggestion** *(default 1)* — **increasing this reduces the
  number of suggestions dramatically.**
- **Maximum words in a suggestion** *(default 6)* — **decreasing this reduces the
  number of suggestions dramatically.**
- **Maximum suggestions returned** *(default 20)* — how many completions are shown.
  Fewer suggestions means faster responses; more means slower. Because autocomplete
  lives or dies on response time, keep this sensible.
- **Stopwords** — words to exclude. Adding irrelevant or undesirable terms here
  removes them from suggestions.

The guiding trade-off: sites with **lots of content** can generate an excess of
suggestions (and an unmanageable number of rows in the database, which slows
responses) — tighten the thresholds above to cut the volume. Sites with **little
content** may not generate enough good suggestions automatically — lean on priority
suggestions to fill the gap.

### Content types

Select which content types' titles seed the initial suggestions. This is your
starting point, and it needs a fair amount of content to produce enough
auto-complete terms on its own.

### Priority suggestions

Add priority suggestions directly in the admin interface. These receive the
**highest score**, so they float to the top — use them to guarantee a set of useful,
high-quality completions where the automatically generated set falls short.

## Managing individual suggestions

You can edit or remove a single suggestion at
`/admin/config/suggestion/edit/{ngram}` — handy for suppressing an embarrassing or
unwanted completion that crept in from content or visitor searches.

## How suggestions are served

The type-ahead data is served from `/suggestion/autocomplete`. This endpoint is
intentionally open so any visitor's search box can use it — and responses are
cacheable (varying on the query, with a one-hour max-age), while queries shorter than
your configured minimum simply return nothing.

## Check what gets indexed on restricted sites

Indexing only includes **published** content, so unpublished nodes never appear as
suggestions. Note, though, that the filter is publication status, **not node
access** — content that is published but locked down by a node-access module (Group,
a realm-based access module, and the like) is still indexed, and its vocabulary can
surface as a suggestion. If your site relies on per-node access restrictions, review
what is being indexed so private wording does not leak through the suggestions.
