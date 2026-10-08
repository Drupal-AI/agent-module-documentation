Stores Drupal's system log (watchdog) events in Apache Solr instead of the database, with a Views- and Facets-powered report for fast, searchable log browsing.

---

Search API Solr Log provides a logger that writes system events into a Solr index, offloading logging from the database and making very large log volumes searchable and filterable. It ships a Views-based log report with exposed Facets filters (severity, type, date, etc.) so administrators can drill into events quickly even at scale. A settings form (`search_api_solr_log.settings`, at `/admin/config/search/search-api-solr-log`) controls the logger, and a confirm form lets you clear recent log messages (`/admin/reports/search-api-solr-log/clear-logs`). Because logs live in Solr, queries stay fast where a database `watchdog` table would become a bottleneck. It depends on `search_api_solr`, `views`, and `facets` (specifically `facets_exposed_filters`). It is aimed at high-traffic sites and Solr-centric infrastructures that want unified, searchable logging.

---

- Store watchdog/system log events in Solr instead of the database.
- Keep the `watchdog` table small on high-traffic sites.
- Search log messages full-text via Solr.
- Filter logs by severity using exposed facets.
- Filter logs by event type/channel.
- Filter logs by date range.
- Browse a Views-based log report at scale.
- Clear recent log messages from a confirm form.
- Configure the Solr logger on the settings page.
- Offload logging I/O away from the primary database.
- Retain far more log history than a DB table comfortably allows.
- Provide unified logging on Solr-centric infrastructure.
- Analyze error trends with faceted drill-down.
- Speed up log queries that would be slow in `dblog`.
- Combine log search with other Solr search on one server.
- Give ops teams a fast searchable audit trail.
- Reduce database growth from verbose logging.
- Investigate incidents by faceting on severity + type + time.
- Export/report log data through Views.
- Centralize logs for a multisite Solr setup.
