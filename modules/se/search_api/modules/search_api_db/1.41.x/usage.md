Search API Database Search is a submodule of Search API that provides a `search_api_db` **backend** plugin, storing and querying indexed content in ordinary SQL database tables — no external search server required.

---

Database Search implements a Search API **backend** (`Drupal\search_api_db\Plugin\search_api\backend\Database`, id `search_api_db`) that indexes items into dynamically created database tables and answers Search API queries with SQL. It is the zero-infrastructure option: create a Search API Server, choose the "Database" backend, point an index at it, and full-text and filtered search work immediately on MySQL, PostgreSQL, or SQLite. It supports fulltext search, partial (substring) matching, autocomplete, facets, and configurable minimum word length via database-specific compatibility handlers. It is ideal for small-to-medium sites, local development, and as a fallback before adopting Solr; the backend's own description notes it "should not be used for large sites." The bundled `search_api_db_defaults` module can install a ready-made server, index, and search View to get a working search page in one step.

---

- Add site search to a small or medium site without running Solr/Elasticsearch.
- Use the database backend for local development and CI where no search server exists.
- Stand up a working search page fast via the `search_api_db_defaults` submodule.
- Provide full-text search over nodes and other entities using only the DB.
- Enable partial / substring matching for as-you-type style search.
- Power autocomplete suggestions on a database-backed index.
- Back faceted search (with the Facets module) on a DB server.
- Run on MySQL, PostgreSQL, or SQLite via database compatibility handlers.
- Set a minimum word length to keep the index compact.
- Prototype a search feature before committing to external infrastructure.
- Serve as a fallback backend when a Solr server is unavailable.
- Index multiple content types into one database-backed index.
- Keep search entirely within the site's existing database/backups.
- Avoid extra hosting cost for search on low-traffic sites.
- Support multilingual indexes on the database backend.
- Clear and rebuild a database index with standard Search API tools/Drush.
- Test processors and field configuration against a real backend locally.
- Migrate later to Solr by re-pointing the index at a different server.
- Provide search for intranet or internal tools with modest data volumes.
- Deploy the DB server and index as exportable configuration.
