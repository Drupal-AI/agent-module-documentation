# search_api_solr_admin — agent start

Solr admin tasks (Collections API + field analysis) for Search API Solr servers. Adds local
actions on `/admin/config/search/search-api/server/{server}` and Drush commands.

- Admin tasks (upload config set, reload, delete collection/all) & field analysis →
  [configure/admin-tasks.md](configure/admin-tasks.md)

Permissions: `execute solr admin task`, `perform field analysis`.
Drush: `solr-reload`, `solr-delete-collection`, `solr-delete-all`, `solr-upload-conf`.
