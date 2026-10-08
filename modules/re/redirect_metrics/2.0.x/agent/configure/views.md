# Redirect metrics — report Views & local tasks

The module has **no settings form** (`configure: null`). Its "configuration" is the View it
ships and the local-task tabs it registers. All of it is driven by the two base fields
`access_count` and `last_access` (see [../api/metrics.md](../api/metrics.md)).

## Shipped View: `redirect_metrics`
Config: `config/install/views.view.redirect_metrics.yml` (base table `redirect`). The master
display defaults to sorting by `access_count`. Two page displays:

| Display | Path | Purpose | Key logic |
|---|---|---|---|
| `page_1` "Popular redirects" | `admin/config/search/redirect/popular` | Most-used redirects | Sorted by `access_count` DESC |
| `page_2` "Stale redirects" | `admin/config/search/redirect/stale` | Redirects gone cold | Filter `last_access` `<` `-6 months` (offset), not exposed |

Both pages show source path, target URI, status code, `last_access`, `access_count`, created,
and operations, plus a redirect bulk-operations form and exposed filters (From / To / Status
code). Access is inherited from the redirect module (permission **"administer redirects"**);
the View has no separate permission of its own.

## Local tasks (tabs)
`redirect_metrics.links.task.yml` adds three tabs under the core redirect list route
(`redirect.list`, i.e. `admin/config/search/redirect`):

- **All redirects** → `redirect.list` (weight 1)
- **Popular redirects** → `view.redirect_metrics.page_1` (weight 2)
- **Stale redirects** → `view.redirect_metrics.page_2` (weight 3)

## Customising
There is nothing to configure via drush config-set. To change the "stale" threshold, the sort,
or the columns, edit the `views.view.redirect_metrics` config (e.g.
`drush config:edit views.view.redirect_metrics`) — for example change the `page_2`
`last_access` filter `value` (`-6 months`) to a different relative offset. To reuse the metrics
elsewhere, add the `access_count` / `last_access` fields to any other redirect-based View.
