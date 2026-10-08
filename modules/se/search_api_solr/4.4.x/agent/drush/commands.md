# Drush commands

Defined in `src/Commands/SearchApiSolrCommands.php` (service `search_api_solr.commands`,
backed by `SolrCommandHelper`). Run with `drush <command>`.

| Command | Aliases | Does |
|---|---|---|
| `search-api-solr:reinstall-fieldtypes` | `solr-reinstall-ft`, `sasm-reinstall-ft` | Delete and reinstall all SolrFieldType config entities. |
| `search-api-solr:install-missing-fieldtypes` | — | Install only field types that are missing. |
| `search-api-solr:get-server-config <server_id> [file_name] [solr_version]` | `solr-gsc`, `sasm-gsc` | Generate & output the Solr config set (zip) for a server. |
| `search-api-solr:finalize-index [indexId]` | `solr-finalize` | Run index finalization (e.g. commit/optimize) for one/all indexes. |
| `search-api-solr:execute-raw-streaming-expression <indexId> <expression>` | `solr-erse` | Execute a raw Solr streaming expression. |
| `search-api-solr:index-parallel [indexId]` | — | Index items using multiple threads (`--threads`, `--batch-size`). |
| `search-api-solr:reset-empty-index-state [indexId]` | — | Reset the "empty index" tracking state. |

The `search_api_solr_admin` submodule adds Collections-API commands: `solr-reload`,
`solr-delete-collection`, `solr-delete-all`, `solr-upload-conf` (upload config set).

Typical bootstrap flow:
```
drush search-api-solr:get-server-config my_solr_server            # download config set
# install it into Solr, then:
drush search-api-solr:reinstall-fieldtypes
drush search-api-index                                            # index content
```
