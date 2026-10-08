# Flag Search API — manual setup guide

**Flag Search API** (`flag_search_api`) is the bridge between the
[Flag](https://www.drupal.org/project/flag) module and
[Search API](https://www.drupal.org/project/search_api). It lets flag data —
*who* flagged each item, and *how many* people flagged it — be indexed, so you can
search, filter, sort, and facet on it just like any other indexed field. That is
what powers experiences like "My bookmarks," a "flagged by me" facet, a
"most‑flagged" trending block, or a flag/unflag link right on search result rows.

It does its work through **two Search API processors** you enable on an index. The
**Flag indexing** processor (`flag_indexer`) adds one multi‑valued field per flag,
`flag_<flag_id>`, holding the user IDs of everyone who flagged each item. The
**Flag count indexing** processor (`flag_count_indexer`) adds `flag_<flag_id>_count`
fields holding the number of flaggings. On top of that it registers a Views field
handler (`search_api_flag`) that renders the flag link on a result row, and a
Facets widget (`user_flag`) — a single checkbox that limits a search to the
current user's flagged content.

The module depends on both **Flag** and **Search API**, and you'll also want the
**Facets** module if you intend to use the "flagged by me" widget. It has just one
setting of its own — a single checkbox — and no permissions, Drush commands, or
plugin types of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and enable it
   alongside Flag and Search API.

## Where it lives in the admin menu

The module's own settings form is a single checkbox at **Configuration → Search
and metadata → Flag Search API** (`/admin/config/search/flag-search-api`), gated
by the **Administer Search API** permission. Note that this form does *not* choose
which flags get indexed — that happens on each index's processor settings (see
below).

## How to use it

**1. Enable the processors on your index.** Go to **Configuration → Search and
metadata → your index → Processors**. Tick **Flag indexing** (and/or **Flag count
indexing**), then in each processor's settings choose which flags to index. Each
selected flag becomes its own indexed field: `flag_<flag_id>` (the user IDs who
flagged the item) and, for the count processor, `flag_<flag_id>_count` (the
number of flaggings). Reindex when you're done so the fields fill in.

**2. Keep the index fresh (optional).** Open the module's settings form at
**Configuration → Search and metadata → Flag Search API** and tick **Reindex Item
on Flagged action**. With it on, flagging or unflagging an entity immediately marks
the affected item for reindex in every Search API index that contains it, so flag
data stays current without waiting for a full reindex. Leave it off and flag
changes are only picked up on the next scheduled/manual reindex — which is cheaper
if freshness isn't critical. The setting is stored as
`flag_search_api.settings:reindex_on_flagging`; no default ships, so it is off
until you save the form.

**3. Display and filter with it.** On a Search API–backed View, the
`flag_<id>` fields expose a **flag link** field (`search_api_flag`) you can add to
result rows. For facets, create a facet on a `flag_<id>` field and choose the
**User Flags** widget to render the "My Flagged Items" checkbox that filters
results to what the current user has flagged. The `flag_<id>_count` fields can be
used for sorting, filtering, or count facets ("flagged by 10+ users").

> **Privacy note.** The Flag indexing processor stores the *user IDs* of everyone
> who flagged each item in the search index. Whether those IDs ever surface to end
> users depends entirely on how you configure your Views fields and facets. If who
> flagged what should stay private, keep the `flag_<id>` (user) field out of
> public‑facing displays and use the count field instead.
