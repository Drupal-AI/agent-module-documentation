<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup — what Acquia Search Defaults installs

Enable it:

```bash
drush en acquia_search_defaults -y
```

It has **no configuration UI, settings, permissions, or Drush commands**. It provides two
optional config entities (in `config/optional/`, imported on enable *if* their dependencies
already exist):

| Config | Machine name | Notes |
|---|---|---|
| Search API index | `acquia_search_index` ("Acquia Search Solr Index") | Datasource `entity:node`; server `acquia_search_server`; indexes Title, Body, type, uid, status, node grants |
| View | `views.view.acquia_search` | Renders results from the index |

The index ships pre-enabled Solr processors: `content_access`, `entity_status`, `highlight`
(excerpts, 400 chars, `<strong>` markers), `html_filter`, `type_boost`, `rendered_item`,
`add_url`, `solr_date_range`. `index_directly` is off (`cron_limit: 50`), so content is indexed
on cron.

**Dependency gotcha:** the index config depends on `search_api.server.acquia_search_server`
and `field.storage.node.body`. Because the files are in `config/optional`, if the Acquia server
or the node Body field is missing when you enable the submodule, Drupal silently skips creating
the index — enable/create those first, or re-run the import after they exist.

Everything it creates is ordinary Search API / Views config you can edit, clone, or delete
(unlike the parent's protected default server/index, these defaults are not delete-protected).

Parent module config: [../../../../3.1.x/agent/configure/acquia_search.md](../../../../3.1.x/agent/configure/acquia_search.md)
