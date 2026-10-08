# Search API Stats — manual setup guide

**Search API Stats** (`search_api_stats`) records every keyword search that runs
through the Search API into a dedicated database table, then hands that log to
Views so you can build reports of what your visitors are searching for. If you
already run a Search API index and want to know which terms are popular, which
searches return nothing, and how search usage changes over time, this module
gives you the raw data to answer those questions.

The recording is completely automatic. Once the module is enabled, every Search
API query that has actual search text is logged as one row — the server and
index it hit, the timestamp, the user and session, the keyword phrase, how many
results came back, and the language. Empty-keyword queries (such as browsing a
facet page with no search box entry) are skipped, so your log stays free of
noise. There is no settings form to fill in and nothing you have to switch on.

Reporting is where you do the work, and you do it entirely with **Views**. The
module registers its `search_api_stats` table as a Views base table with a
relationship to users, so a "top search terms" report is just a View that groups
by keyword and counts, a "zero results" report is a View filtered to
`numfound = 0`, and a raw query log is a View that lists keywords, timestamps,
and user names. The module also defines an **access search api stats**
permission you can use to gate those report pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Search API.

## Where it lives in the admin menu

Search API Stats has **no admin settings page** — its `configure` route is
empty, and recording happens the moment the module is on. Everything you
actually see and use lives in the Views UI at **Structure → Views**
(`/admin/structure/views`), where you build your own reports on the *Search API
stats* base table.

## How to use it

Because there is nothing to configure, using the module is a matter of building
the reports you want:

1. **Confirm searches are being logged.** Run a few keyword searches on your site,
   then check the `search_api_stats` table (for example with
   `drush sql:query "SELECT keywords, numfound, timestamp FROM search_api_stats"`).
   You should see one row per non-empty search.

2. **Build a report View.** Go to **Structure → Views → Add view**
   (`/admin/structure/views/add`) and choose **Search API stats** as the base
   table. Some useful starting points:
   - *Top search terms* — add the **Keywords** field, turn on aggregation, group
     by keywords with a **Count**, and sort by that count descending.
   - *Zero-result searches* — add a filter on **Number found** (`numfound`) equal
     to 0 to surface content gaps where people searched but found nothing.
   - *Raw query log* — add **Keywords**, **Timestamp** (formatted as a date), and,
     through the built-in **User** relationship, the account **Name**; expose the
     Keywords and Timestamp filters so editors can search the log.

3. **Protect the report.** Under the View display's **Access** settings, gate it
   with the **access search api stats** permission (or any permission you prefer).
   Note that recording itself is never gated — every search is logged regardless
   of who runs it; the permission only controls who can view the reports you build.

A note about default views: the project still ships a Drupal 7-era default View
(`search_api_reports`), but it uses the old Views API and does **not** load on
Drupal 11. On Drupal 11 there is no ready-made report — you build your own as
described above.

There is also an optional submodule, **Search API Stats Block**
(`search_api_stats_block`), which adds a per-index block that shows the top
search phrases next to your search box.

Because there is no built-in purge, apply any data-retention policy yourself by
deleting old rows directly (for example
`drush sql:query "DELETE FROM search_api_stats WHERE timestamp < <cutoff>"`).
