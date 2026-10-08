<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `Drupal\acquia_search\Commands\AcquiaSearchCommands` (registered in
`drush.services.yml`). All require the `acquia_search` module enabled; the cores they report
come from the Acquia Search API, so they need a connected subscription + network to return
real data (offline they return empty/exception).

| Command | Alias | Args / options | Purpose |
|---|---|---|---|
| `acquia:search-solr:cores` | `acquia:ss:cores` | `--format=json` | List every Solr core available to the site's Acquia subscription |
| `acquia:search-solr:cores:cache-reset` | `acquia:ss:cores:cr` | `--id=ABCD-12345` | Clear the cached core list for a subscription identifier (e.g. after a subscription change) |
| `acquia:search-solr:cores:possible` | `acquia:ss:cores:possible` | `<server_id>`, `--format=json` | Show the *possible* cores for a given Search API server id |
| `acquia:search-solr:cores:preferred` | `acquia:ss:cores:preferred` | `<server_id>` | Show the single *preferred* core the module would use for that server |

Examples:

```bash
drush acquia:search-solr:cores --format=json
drush acquia:ss:cores:possible acquia_search_server
drush acquia:ss:cores:preferred acquia_search_server
drush acquia:ss:cores:cr --id=ABCD-12345
```

The `--id` value is validated against `^[A-Z]{4,5}-[0-9]{5,6}$` (the Acquia subscription
identifier format); an invalid id throws. If no `--id` is given the command uses the
identifier from the connected subscription.
