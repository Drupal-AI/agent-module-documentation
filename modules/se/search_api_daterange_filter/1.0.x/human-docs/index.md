# Search Api Daterange Filter — manual setup guide

**Search Api Daterange Filter** (`search_api_daterange_filter`) adds a
date-*range* exposed filter for Search API date fields in Views. It extends
Search API's built-in date filter with a "from / to" option, so visitors can
narrow a search to results that fall between two dates — events after a given day,
content published between two dates, and so on.

The gap it fills is range-based date filtering on Search API indexes. Search API
ships a single-date filter, but if you want a genuine start-to-end range that a
user sets themselves, this module provides it. You build a Search API-backed View,
add the module's date-range filter as an exposed filter, and the search form gains
a from/to control. It depends on the **Search API** module (`search_api`) and sits
in the Views package.

There is nothing to configure globally — the project's own documentation says *no
configuration needed*. It works by giving you a new exposed filter to place on a
View; the rest is standard Views work. The filter only shapes the search query,
so results still respect the index and entity access, and the module has no
access-control role of its own. It pairs nicely with the **Better Exposed
Filters** module if you want a friendlier date-picker UI, though that is optional.

This guide is written for a **human** working through the admin UI. If you are an
AI agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module has no settings page; you use it by adding its exposed filter to a
search View. A typical setup, following the project's own guidance:

1. Create content that has a core **date range** field.
2. Build a Search API index and add both the **date** and **date end** fields to
   it.
3. Create a Views display on that index and add the **date** field as a filter
   (you do *not* need to add the date-end field as a filter).
4. In the filter's settings, tick **Expose this filter** and choose the operator
   **Is between / Includes**.
5. (Optional) Use the **Better Exposed Filters** module to make the from/to
   control more user-friendly.
