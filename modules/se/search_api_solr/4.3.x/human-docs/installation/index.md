# Installation

## Requirements

Search API Solr has more moving parts than most contrib modules:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- The **Search API** module (`drupal/search_api`, `^1.37`) and core's **Language**
  module — both are dependencies.
- A running **Apache Solr server** (self‑hosted, SolrCloud, or a hosted provider) that
  Drupal can reach. This is an external service, not something the module installs; you
  point the module at it and install the generated config set into it (see below).
- Several **Composer libraries**, installed automatically with the module:
  `solarium/solarium` (the Solr client), `composer/semver`,
  `maennchen/zipstream-php`, `laminas/laminas-stdlib`, and
  `consolidation/annotated-command`. The PHP extensions `dom`, `json`, and
  `simplexml` are also required (they are standard on most PHP builds).

Optional companions the project suggests: **Facets** (faceted search),
**Search API Autocomplete**, **Search API Location**, **Search API Spellcheck**, and
**Search API Solr NLP** (natural‑language field types).

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull in
Search API and all the Solarium/library dependencies and update shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr -y
```

This enables the base module (and Search API as a dependency). Nothing is indexed
yet — you next create a Solr‑backed server and an index, and install the Solr config
set on your Solr server. See [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Search API Solr ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Solr Admin** | `search_api_solr_admin` | Manage Solr from Drupal via the Collections API — upload config sets, reload/delete collections. Adds Drush commands (`solr-upload-conf`, `solr-reload`, `solr-delete-collection`, `solr-delete-all`). |
| **Autocomplete** | `search_api_solr_autocomplete` | Solr‑powered autocomplete/typeahead for search boxes (works with the Search API Autocomplete module). |
| **Devel** | `search_api_solr_devel` | Developer/debugging helpers for inspecting raw Solr requests and responses. |
| **Legacy** | `search_api_solr_legacy` | Support for older Solr server versions. |
| **Log** | `search_api_solr_log` | Logging integration for Solr operations. |

For example, to manage Solr config sets directly from Drupal:

```bash
drush en search_api_solr_admin -y
```

## Getting Solr ready

Search API Solr generates the Solr configuration your server needs. After you create a
server (see [Configuration](../configuration/index.md)) you download the config set —
from the server's **Files** tab, or with `drush search-api-solr:get-server-config
{server_id}` — and install it into your Solr instance. If you enabled the **Solr
Admin** submodule and use SolrCloud, `drush solr-upload-conf` can upload it for you.
Then index your content with `drush search-api-index`.
