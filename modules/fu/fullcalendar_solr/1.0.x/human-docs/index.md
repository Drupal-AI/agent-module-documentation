# FullCalendar Solr — manual setup guide

**FullCalendar Solr** (`fullcalendar_solr`) provides a **Views display style** that
renders a Search API (Solr) result set as an interactive **year calendar**, built
with the FullCalendar JavaScript library. The calendar highlights every date that
has content, and offers a year dropdown containing only the years that actually have
results. It integrates well with Search API Solr and the Facets module.

It fills a specific gap: core Views' calendar options do not work against a Search
API index, because Solr results are documents rather than entities and Search API
does not do SQL-style aggregation. This module counts results per date itself and
re-queries the index (using the `search_api_facets` feature) to build the list of
populated years.

> **Important:** this formatter is **not** compatible with regular content Views —
> it only works with a Search API index whose backend supports `search_api_facets`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views and Search API.

This module has **no central settings page**. All configuration happens on the
**View** you build with it, described below.

## How to use it: building a year calendar view

1. Go to **Structure → Views** (`/admin/structure/views`) and add a View. Under
   **View settings → Show**, select your Search API **index**.
2. Add a **Page** display and set its **display format** to **FullCalendar Solr**.
3. Give the page a **path whose last component is `year`** — for example
   `/events/year`. This is required: if the final component is not `year`, the
   calendar will not render.
4. Under **Fields**, add a **string field containing a date in `YYYY-MM-DD`
   format** (it must be indexed). Any date not in that format will not appear on the
   calendar.
5. Under **Advanced → Contextual filters**, add a field containing **year values in
   `YYYY` format**, usually fed from the raw value in the URL.
6. Under **Format → Settings**, map the **date field** and **year field**, and
   optionally set: the highlight colour, the maximum months per row, the minimum
   month width in pixels, a heading template (with a `<year>` placeholder), whether
   to render an empty calendar when there are no results, and extra CSS classes.
7. Save the view.

### Linking to a day view (optional)

To let visitors click a highlighted date and see that day's results:

1. In the year view's **Format → Settings**, enable **Navigation Links to Day
   View**.
2. Create a second view display that shows the same indexed content in any style
   *other* than FullCalendar Solr.
3. Give it a contextual filter on the same `YYYY-MM-DD` date field, and a path
   identical to the year view except the last component is **`day`** instead of
   `year` (so `/events/year` pairs with `/events/day`).

With "Link to Item" enabled, clicking a date that has a single result takes the user
straight to that item instead.

## A note on the FullCalendar library (CSP / offline)

By default the module loads the FullCalendar library from a CDN
(`https://www.unpkg.com/fullcalendar@6.1.5/...`) with no Subresource Integrity hash,
so the calendar pulls third-party JavaScript at render time. If your site has a
strict Content Security Policy or an offline requirement, vendor the FullCalendar
library locally instead of relying on the CDN.
