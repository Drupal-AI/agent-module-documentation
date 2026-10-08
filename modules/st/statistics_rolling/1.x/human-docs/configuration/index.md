# Configuration

Statistics Rolling Period is configured on core Statistics' own settings page,
plus a Views field it provides for reporting.

## Turn on core view counting and set the period

1. Log in as a user who can administer statistics.
2. Go to **Configuration → System → Statistics**
   (`/admin/config/system/statistics`).
3. Enable the core **Count content views** option (`count_content_views`). Rolling
   tracking does nothing until this is on, because it builds on core's counting.
4. Set the **rolling period** — the length of the moving time window (for example
   15 days) over which views are counted.

Save the form. Views are counted via AJAX, which is what lets the counting keep
working even when pages are served from a cache such as Varnish.

## Report on the rolling counts in Views

The module provides a Views field called **Day count during rolling period**. This
is a multi-valued field: it holds one value per day of the rolling window, each
being that day's view count.

To sort or rank content by its total views over the whole period:

1. Add the **Day count during rolling period** field to your view.
2. Enable **aggregation / grouping** on the view.
3. Set the aggregation type for that field to **sum**.

The view will then total each item's daily counts across the rolling window, so
you can sort by "most viewed in the last N days" to surface currently-trending
content.

## Privacy

View statistics record viewing activity, which can be personal data. Keep only
what you need, anonymize where you can, disclose the tracking in your privacy
policy, and make sure any report you build on this data is behind an appropriate
permission so it is not exposed to people who should not see it.
