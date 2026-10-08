# Configure the Database backend

The module adds the **Database** backend (plugin id `search_api_db`) to Search API. There is
no separate settings page — configure it while creating a **Server** at
`/admin/config/search/search-api` (see the parent module's
[configure doc](../../../../search_api/1.41.x/agent/configure/indexes-servers.md)).

Steps: Add server → **Backend: Database** → pick the target **database** connection → set
options → assign an index to this server.

Backend options (schema `config/schema/search_api_db.backend.schema.yml`):
- **database** — the Drupal database connection key/target to store index tables in.
- **min_chars** — minimum indexed word/substring length (e.g. `1`–`6`).
- **matching** — full-text matching mode: `words` (whole words) or `partial`
  (substring / "words starting with").
- **autocomplete** — enable suggestion/spellcheck support for Search API Autocomplete.
- **phrase / fuzzy** matching options depending on version.

Server config (`search_api.server.default_server.yml`), abridged:
```yaml
id: default_server
name: 'Database server'
backend: search_api_db
backend_config:
  database: 'default:default'
  min_chars: 3
  matching: words
  autocomplete: { suggest_suffix: true, suggest_words: true }
```

Database-specific behaviour (case sensitivity, transliteration) is handled by
`*.search_api_db.database_compatibility` services for MySQL, PostgreSQL, and SQLite. Bundled
`search_api_db_defaults` can install a server + index + search View automatically. Index and
clear via standard Search API tools/Drush (`drush search-api:index`).
