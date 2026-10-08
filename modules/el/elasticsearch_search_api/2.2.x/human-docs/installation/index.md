# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`) — manages your indexed data.
- The **Elasticsearch Connector** module (`elasticsearch_connector`) — sets up the
  connection to your Elasticsearch backend.
- A running **Elasticsearch cluster** to connect to.
- The **blockui** JavaScript library, which is a dependency of this module but isn't
  a standard Drupal package — see the step below.

## Add the blockui library repository

Before requiring the module, add the blockui library to your project's
`composer.json` `repositories` section (a one-time step):

```json
"repositories": [
    {
        "type": "package",
        "package": {
            "name": "library-blockui/blockui",
            "version": "v2.70",
            "type": "drupal-library",
            "dist": {
                "url": "https://github.com/malsup/blockui/archive/2.70.zip",
                "type": "zip"
            }
        }
    }
]
```

If your `composer.json` already has a `repositories` array, add this entry to it
rather than replacing the whole array.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Search API and Elasticsearch Connector — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_search_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_search_api -y
```

This pulls in Search API and Elasticsearch Connector if they aren't already on.

## Submodules

Two optional submodules ship with the project — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Elasticsearch Search API Example** | `elasticsearch_search_api_example` | A worked example of a custom Elasticsearch-backed search page to learn from or adapt. |
| **ESA Pager** | `esa_pager` | Pagination for search results, so users can flip forward/back and jump to the first/last page. |

For example, to add the pager:

```bash
drush en esa_pager -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and start adding a server — you should be able
to choose the **Elasticsearch** backend. If it's available, the module is installed;
continue to [Configuration](../configuration/index.md).
