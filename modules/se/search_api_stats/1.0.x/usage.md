<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Stats records every keyword search that runs through the Search API into a dedicated database table, then exposes that log to Views so you can build reports of what visitors are searching for and how the search performs.

---

The module implements `hook_search_api_results_alter()`: after any Search API query returns a result set, it reads the current user, language, server, index and the query's original keywords and inserts one row into its own `search_api_stats` table (server/index machine names, timestamp, uid, session id, keyword string, result count, and columns reserved for filters/sort/timing/language). Empty-keyword queries are skipped so browsing a facet page does not create noise. Before each insert it invokes a `hook_search_api_stats_record_alter()` alter hook, letting other modules rewrite or enrich the recorded fields (for example to strip PII or add custom columns). It ships a Views integration (`hook_views_data()`) that turns `search_api_stats` into a Views base table with a relationship to users, so all reporting is built as ordinary Views — group by keyword for "top searches", filter by timestamp for a date range, join to the user for per-account analysis. It defines a permission (`access search api stats`) intended to gate those report views/pages. Note: the project also carries a legacy Drupal 7-era `hook_views_default_views()` default view (`search_api_reports`) that does **not** load on Drupal 11, so on D11 you build your own View on the base table. A companion submodule (`search_api_stats_block`) adds a per-index block of the top search phrases.

---

- Log every site search keyword so you can see what visitors actually look for.
- Build a "top search terms" report by grouping the `search_api_stats` table by keyword.
- Identify searches that return zero results (`numfound = 0`) to spot content gaps.
- Track search volume over time by filtering/aggregating on the `timestamp` column.
- See which Search API index or server a query hit via the `i_name` / `s_name` columns.
- Attribute searches to logged-in users through the built-in relationship to the users table.
- Analyse anonymous vs authenticated search behaviour using the `uid` column.
- Report searches per language on multilingual sites via the `language` column.
- Create a Views page at an admin path to give editors a live search-report dashboard.
- Expose a search-terms report as a block or feed for content strategists.
- Feed keyword data into content planning by surfacing the most-searched phrases.
- Detect trending queries by comparing keyword counts across timestamp windows.
- Measure whether a search redesign changed what/how people search.
- Drive an autocomplete or "popular searches" widget from the recorded keyword counts.
- Enrich each recorded row with custom data by implementing `hook_search_api_stats_record_alter()`.
- Strip or hash sensitive keyword data at record time via the alter hook for privacy compliance.
- Add extra columns (e.g. referrer) to the record by altering the fields before insert.
- Gate access to search reports behind the `access search api stats` permission.
- Combine with the `search_api_stats_block` submodule to show top phrases beside a search box.
- Audit search usage session-by-session using the recorded `sid` column.
- Clear or archive the query log (truncate `search_api_stats`) as part of a data-retention policy.
- Export the raw query log via a Views data export display for offline analysis.
- Compare popularity of two search phrases by counting their rows.
- Provide a "no results for X" alerting report to editors so missing content gets created.
- Benchmark search result counts per keyword to tune relevance and boosting.
