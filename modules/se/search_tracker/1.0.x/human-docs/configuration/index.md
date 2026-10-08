# Configuration

Search Tracker needs a few settings before it starts capturing searches, and its
display block has to be placed. None of it is complicated — the goal is just to
tell the module which URL parameter carries the search term and where tracking
should be active.

## Open the settings form

1. Make sure your role has the **Administer Search Tracker settings** permission
   (granted on **People → Permissions**).
2. Go to **Configuration → Search and metadata → Search Tracker**
   (`/admin/config/search/search-tracker`).

## The settings

- **URL parameter name** — the query parameter your search uses to pass the term,
  so the module knows what to capture. The default is `search`, but set it to
  whatever your search actually uses — for example `q`, `keywords`, or, if you
  search with Search API, `search_api_fulltext`.
- **Maximum number of terms to store** — how many recent searches to keep per
  visitor (default **10**). Older entries drop off once the limit is reached.
- **Activation paths** — the pages on which search tracking should be active.
  Wildcards are supported, so you can enter something like `/search` or
  `/search/*` to activate tracking only on your search pages.
- **localStorage key** — the name under which the history is stored in the
  visitor's browser. You can customise this if the default clashes with something
  else on your site; most sites can leave it as-is.

Save the form when you are done.

## Place the display block

The recent searches are shown through a block. Go to **Structure → Block layout**
(`/admin/structure/block`) and place the **Search Tracker** block in the region
where you want recent searches to appear. It renders them as clickable links, and
includes a **Clear History** control so visitors can wipe their own history.

## Test it

Perform a search on one of your configured activation paths. The term should
appear in the Search Tracker block, and re-running any listed search should be a
single click. Remember that because everything is stored in the browser's
localStorage, the history is per-visitor and per-browser — nothing is recorded on
the server.
