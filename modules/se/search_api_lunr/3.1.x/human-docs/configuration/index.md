# Configuration

You configure Search API Lunr the same way you configure any Search API backend —
through the standard Search API screens at **Configuration → Search and metadata →
Search API** (`/admin/config/search/search-api`). There is no separate settings
page; the Lunr-specific options live inside the server and index forms.

> **Before you begin — a privacy check.** The Lunr index is written to JSON files
> that are downloaded into the browser, so everything you index is fully public.
> Only index content that is safe for anyone to read, and never add
> access-restricted content to a Lunr index.

## Create a Lunr server

1. Go to **Search API** and choose **Add server**.
2. Give it a name and select the **Lunr** backend.
3. Save the server.

## Create and configure the index

1. Choose **Add index**, name it, and pick the data source (for example, Content).
2. Assign it to the Lunr server you just created.
3. On the index's **Fields** tab, add the fields you want to be searchable —
   remembering that whatever you add here becomes publicly downloadable.
4. On the **Processors** tab, enable the processing pipeline you want, exactly as
   you would for any Search API index.

## Ranking and boosting

Lunr gives you two ways to influence how results are ranked:

- **Per-field boosting** — for each indexed field you can set how much weight it
  carries when ranking results, so (for example) a match in the title counts for
  more than a match in the body.
- **Per-document boosting** — you can nominate a field to act as a document-level
  boost, pushing specific results higher or lower in the rankings overall.

## The instant-search autocomplete block

The module provides an **instant search autocomplete block**. Place it through
**Structure → Block layout** (`/admin/structure/block`) in whichever region you
like. Visitors can then jump straight to a relevant result as they type, or run a
full search across the index.

## The JavaScript API

For anything more custom, the module exposes a JavaScript API you can use to run
your own searches, read documents out of the index, and integrate results into
your front-end however suits your site. This is the route for decoupled or
instant-search interfaces that go beyond the bundled block.

## Indexing

Because the backend uses Search API's own index tracking, items are written to the
index on demand as content is created or updated — you don't need to rebuild the
whole index by hand. This makes it well suited to an integrated Drupal front-end,
and less suited to a static build-step workflow.
