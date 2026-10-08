# Configuration

Scolta is set up like any other Search API backend, plus a couple of Scolta-specific
steps to build and display the browser-side index.

## 1. Create a Search API server with the Scolta backend

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Add a new **server** and choose **Scolta Pagefind** as the backend.
3. Create a new **index** (or update an existing one) to use that server, and add
   the content and fields you want searchable.

> **Only index public content.** Pagefind builds a static index that is served to
> the visitor's browser, so everything in the index is effectively public. Respect
> Search API's access settings and do not add restricted or unpublished nodes to a
> Scolta index.

## 2. Build the search index

Pagefind builds a static index that the browser searches against. Build it from the
command line:

```bash
drush scolta:build
```

Scolta's Drush commands can build, rebuild, export and monitor the index, and
support **chunked, resumable builds with memory budgets** — useful for large sites
or shared hosting. Rebuild the index whenever your content changes enough to
warrant it.

## 3. Place the search block

Add the **Scolta Search** block to your site through **Structure → Block layout**
(`/admin/structure/block`). Position it in whatever region suits your theme; this
is the search box your visitors use, and queries resolve in their browser against
the static index.

## 4. Relevance tuning (optional)

In Scolta's settings you can re-rank Pagefind results with tunable boosts:

- **Title match weight** — how much a match in the title counts.
- **Content match weight** — how much a match in the body counts.
- **Recency decay** — a curve that favours more recent content.
- **Phrase-proximity multiplier** — rewards results where query words appear close
  together.
- **Exact title match boosting** — lifts results whose title exactly matches the
  query.

Adjust these to suit the balance of freshness versus relevance your site needs.

## 5. AI query expansion and summaries (optional)

The AI features are entirely optional — base search works without any AI provider.
To enable them, configure an **LLM provider** in Scolta's settings form. Scolta can
then rewrite queries for better recall, generate result summaries and suggest
follow-up questions. It supports several backends, including the **Drupal AI**
module (which brings 48+ providers plus Key-module support, rate limiting and token
tracking), Anthropic, OpenAI, and OpenAI-compatible endpoints. Selecting Drupal AI
routes AI calls through that module's plugin system instead of Scolta's built-in AI
client.
